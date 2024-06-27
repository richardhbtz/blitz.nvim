return function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    require("mason-lspconfig").setup({
        ensure_installed = get_languages_lsp(),
        handlers = {
            function(server_name)
                local server = get_languages_lsp()[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })
end
