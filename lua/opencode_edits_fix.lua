---Replace opencode.nvim's OpencodeEdits autocmds with a hardened version.
---Upstream issues addressed:
--- - Paths must be fnameescape'd in Ex commands (spaces / special chars break :tabnew / :bwipeout / :diffpatch).
--- - Server.new(...):permit(...) without :catch causes "unhandled promise rejection" when new(port) fails.
--- - diffpatch / tabnew wrapped in pcall + notify so a bad patch (e.g. some new-file edge cases) does not leave Neovim in a broken state.

local M = {}

---@type string?
local current_edit_request_id = nil
---@type nil|integer
local diff_tabpage = nil

---@param id string|number
---@param port number
---@param reply "once"|"always"|"reject"
local function permit(id, port, reply)
  require("opencode.server")
    .new(port)
    :next(function(server) ---@param server opencode.server.Server
      server:permit(id, reply)
    end)
    :catch(function(err)
      if err == nil or err == "" then
        return
      end
      if type(err) == "table" and next(err) == nil then
        return
      end
      vim.notify(vim.inspect(err), vim.log.levels.ERROR, { title = "opencode: permit" })
    end)
end

function M.apply()
  vim.api.nvim_create_augroup("OpencodeEdits", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = "OpencodeEdits",
    pattern = { "OpencodeEvent:permission.asked", "OpencodeEvent:permission.replied" },
    callback = function(args)
      ---@type opencode.server.Event
      local event = args.data.event
      ---@type number
      local port = args.data.port

      local opts = require("opencode.config").opts.events.permissions or {}
      if not opts.enabled or not opts.edits.enabled then
        return
      end

      if event.type == "permission.asked" and event.properties.permission == "edit" then
        local idle_delay_ms = opts.idle_delay_ms or 1000
        vim.notify(
          "`opencode` requested permission — awaiting idle…",
          vim.log.levels.INFO,
          { title = "opencode", timeout = idle_delay_ms }
        )
        require("opencode.util").on_user_idle(idle_delay_ms, function()
          vim.schedule(function()
            local diff = event.properties.metadata.diff
            local patch_filepath = vim.fn.tempname() .. ".patch"
            if vim.fn.writefile(vim.split(diff, "\n"), patch_filepath) ~= 0 then
              vim.notify(
                "Failed to write patch file for opencode edit request",
                vim.log.levels.ERROR,
                { title = "opencode" }
              )
              return
            end

            local filepath = event.properties.metadata.filepath
            local esc_file = vim.fn.fnameescape(filepath)
            local esc_new = vim.fn.fnameescape(filepath .. ".new")
            local esc_patch = vim.fn.fnameescape(patch_filepath)

            vim.cmd("silent! bwipeout " .. esc_new)
            vim.cmd("tabnew " .. esc_file)
            local dp_ok, dp_err = pcall(vim.cmd, "silent vertical diffpatch " .. esc_patch)
            if not dp_ok then
              pcall(vim.cmd, "tabclose")
              vim.notify(
                "opencode diffpatch failed (try rejecting in TUI): " .. tostring(dp_err),
                vim.log.levels.ERROR,
                { title = "opencode" }
              )
              permit(event.properties.id, port, "reject")
              return
            end

            diff_tabpage = vim.api.nvim_get_current_tabpage()
            current_edit_request_id = event.properties.id

            vim.keymap.set("n", "dp", function()
              if current_edit_request_id then
                current_edit_request_id = nil
                permit(event.properties.id, port, "reject")
              end
              return "dp"
            end, { buffer = true, desc = "Accept opencode edit hunk", expr = true })
            vim.keymap.set("n", "do", function()
              if current_edit_request_id then
                current_edit_request_id = nil
                permit(event.properties.id, port, "reject")
              end
              return "do"
            end, { buffer = true, desc = "Reject opencode edit hunk", expr = true })
            vim.keymap.set("n", "da", function()
              permit(event.properties.id, port, "once")
            end, { buffer = true, desc = "Accept opencode edit" })
            vim.keymap.set("n", "dr", function()
              permit(event.properties.id, port, "reject")
            end, { buffer = true, desc = "Reject opencode edit" })
            vim.keymap.set("n", "q", function()
              vim.cmd("tabclose")
              current_edit_request_id = nil
              diff_tabpage = nil
            end, { buffer = true, desc = "Close opencode edit diff" })
          end)
        end)
      elseif event.type == "permission.replied" then
        local rid = event.properties.requestID
        local cur = current_edit_request_id
        if cur == nil or rid == nil or tostring(cur) ~= tostring(rid) then
          return
        end
        current_edit_request_id = nil
        if diff_tabpage and vim.api.nvim_tabpage_is_valid(diff_tabpage) then
          vim.api.nvim_set_current_tabpage(diff_tabpage)
          vim.cmd("tabclose")
          diff_tabpage = nil
        end
      end
    end,
    desc = "Display opencode proposed edits (patched)",
  })
end

return M
