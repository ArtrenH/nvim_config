local M = {}

function M.setup()
  local status_ok, vimtex = pcall(require, "vimtex")
  if not status_ok then
    return
  end
	vimtex.setup {}
end

return M
