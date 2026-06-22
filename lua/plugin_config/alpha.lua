local M = {}

function M.setup()
  -- Load alpha defensively so the dashboard never blocks Neovim startup.
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"

  -- Custom startup banner shown at the top of the dashboard.
  local function header()
    return {
      [[ ███╗  ██╗██╗   ██╗██╗  ██╗██╗   ██╗███████╗███╗   ███╗ ]],
      [[ ████╗ ██║██║   ██║╚██╗██╔╝╚██╗ ██╔╝╚════██║████╗ ████║ ]],
      [[ ██╔██╗██║╚██╗ ██╔╝ ╚███╔╝  ╚████╔╝   ███╔═╝██╔████╔██║ ]],
      [[ ██║╚████║ ╚████╔╝  ██╔██╗   ╚██╔╝  ██╔══╝  ██║╚██╔╝██║ ]],
      [[ ██║ ╚███║  ╚██╔╝  ██╔╝╚██╗   ██║   ███████╗██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝ ]],
    }
  end

  dashboard.section.header.val = header()

  -- Quick dashboard actions for common startup tasks.
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    dashboard.button("E", "  Open current directory", ":Explore<CR>"),
  }

  local function footer()
    -- Show plugin count, current time, and a random fortune below the buttons.
    local lazy_stats = require("lazy").stats()
    local total_plugins = lazy_stats.count
    local datetime = os.date "%d-%m-%Y %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins " .. datetime

    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  -- Highlight each dashboard section with existing colorscheme groups.
  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
