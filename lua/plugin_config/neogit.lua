local M = {}

function M.setup()
  -- Load Neogit defensively so startup still succeeds if the plugin is absent.
  local status_ok, neogit = pcall(require, "neogit")
  if not status_ok then
    return
  end

  -- Use Neogit's defaults; this wrapper keeps plugin setup consistent.
  neogit.setup {}
end

return M
