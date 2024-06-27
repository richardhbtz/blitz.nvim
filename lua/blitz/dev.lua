local cfg = require("custom.blitz")

local language_mappings = {
    formatters = {
        lua = "stylua",
        rust = "rust_analyzer",
        python = "autopep8",

        csharp = "csharpier",
        c = "clang_format",
        cpp = "clang_format",

        typescript = "prettier",
        svelte = "prettier",
        javascript = "prettier",

        go = "golines",

        ruby = "ruby_fmt"
    },

    lsp_servers = {
        lua = "lua_ls",
        rust = "rust_analyzer",
        python = "pylsp",

        csharp = "csharp_ls",
        c = "clangd",
        cpp = "clangd",

        javascript = "tsserver",
        typescript = "tsserver",
        svelte = "svelte",

        go = "gopls",

        ruby = "ruby_lsp"
    },

    ts_languages = {
        typescript = { "typescript", "html" },
        csharp = { "c_sharp" },
    }
}

function get_languages_formatter()
    local formatters = {}
    for _, language in ipairs(cfg.languages) do
        if language_mappings.formatters[language] then
            formatters[language] = language_mappings.formatters[language]
        end
    end
    return formatters
end

function get_languages_ts()
    local ts_languages = {}
    for _, language in ipairs(cfg.languages) do
        if language_mappings.ts_languages[language] then
            for _, ts_language in ipairs(language_mappings.ts_languages[language]) do
                table.insert(ts_languages, ts_language)
            end
        else
            table.insert(ts_languages, language)
        end
    end
    return ts_languages
end

function get_languages_lsp()
    local lsp_servers = {}
    for _, language in ipairs(cfg.languages) do
        if language_mappings.lsp_servers[language] then
            table.insert(lsp_servers, language_mappings.lsp_servers[language])
        end
    end
    return lsp_servers
end
