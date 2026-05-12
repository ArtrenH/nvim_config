local function python_with_pynvim()
    local candidates = {
        vim.fn.exepath("python3"),
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
    }

    for _, py in ipairs(candidates) do
        if py ~= "" and vim.fn.executable(py) == 1 then
            local cmd = { py, "-c", "import pynvim" }
            if vim.fn.system(cmd) and vim.v.shell_error == 0 then
                return py
            end
        end
    end

    return ""
end

local py = python_with_pynvim()
if py ~= "" then
    vim.g.python3_host_prog = py
end

require("plugins").setup()

require("settings.opts")
require('settings.tabwidth')
-- general lsp config
require('core.lsp_config')
-- cmp config
require('core.cmp_config')
require('core.diagnostics_config')

vim.g.UltiSnipsSnippetsDir = vim.fn.stdpath("config") .. "/UltiSnips"

vim.g.vimtex_quickfix_ignore_filters = {
    'LaTeX Warning: Reference',
}

--require("luasnip.loaders.from_snipmate").lazy_load()
