local cfg = require("custom.blitz")

local language_mappings = {
    formatters = {
        lua = {"stylua"},
        rust = {"rustfmt"},  -- Corrected default formatter for rust
        python = {"autopep8"},

        csharp = {"csharpier"},
        c = {"clang_format"},
        cpp = {"clang_format"},

        typescript = {"prettier"},
        svelte = {"prettier"},
        javascript = {"prettier"},

        go = {"golines"},

        ruby = {"ruby_fmt"}
    },

    lsp_servers = {
        lua = {"lua_ls"},
        rust = {"rust_analyzer"},
        python = {"pylsp"},

        csharp = {"csharp_ls"},
        c = {"clangd"},
        cpp = {"clangd"},

        javascript = {"tsserver"},
        typescript = {"tsserver"},
        svelte = {"svelte"},

        go = {"gopls"},

        ruby = {"ruby_lsp"}
    },

    ts_languages = {
        typescript = {"typescript", "html"},
        csharp = {"c_sharp"}
    }
}

function get_languages_formatter()
    local formatters = {}
    for _, language in ipairs(cfg.languages) do
        if type(language) == "table" then
            -- If language is a table with specific formatter
            if language.fmt then
                formatters[language.name] = { language.fmt }
            elseif language_mappings.formatters[language.name] then
                formatters[language.name] = language_mappings.formatters[language.name]
            end
        elseif type(language) == "string" and language_mappings.formatters[language] then
            -- If language is a string
            formatters[language] = language_mappings.formatters[language]
        end
    end
    return formatters
end

function get_languages_ts()
    local ts_languages = {}
    for _, language in ipairs(cfg.languages) do
        if type(language) == "table" then
            -- If language is a table
            if language_mappings.ts_languages[language.name] then
                for _, ts_language in ipairs(language_mappings.ts_languages[language.name]) do
                    table.insert(ts_languages, ts_language)
                end
            else
                table.insert(ts_languages, language.name)
            end
        elseif type(language) == "string" then
            -- If language is a string
            if language_mappings.ts_languages[language] then
                for _, ts_language in ipairs(language_mappings.ts_languages[language]) do
                    table.insert(ts_languages, ts_language)
                end
            else
                table.insert(ts_languages, language)
            end
        end
    end
    return ts_languages
end

function get_languages_lsp()
    local lsp_servers = {}
    for _, language in ipairs(cfg.languages) do
        if type(language) == "table" then
            -- If language is a table with specific LSP
            if language.lsp then
                table.insert(lsp_servers, language.lsp)
            elseif language_mappings.lsp_servers[language.name] then
                for _, lsp_server in ipairs(language_mappings.lsp_servers[language.name]) do
                    table.insert(lsp_servers, lsp_server)
                end
            end
        elseif type(language) == "string" and language_mappings.lsp_servers[language] then
            -- If language is a string
            for _, lsp_server in ipairs(language_mappings.lsp_servers[language]) do
                table.insert(lsp_servers, lsp_server)
            end
        end
    end
    return lsp_servers
end
