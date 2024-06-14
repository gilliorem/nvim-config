require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Setup LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Python
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup {
  capabilities = capabilities,
}

-- HTML
lspconfig.html.setup {
  capabilities = capabilities,
}
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.snippets = {
  html = {
    luasnip.snippet("!html", {
      luasnip.text_node({
        "<!DOCTYPE html>",
        "<html lang=\"en\">",
        "<head>",
        "  <meta charset=\"UTF-8\">",
        "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
        "  <title>Document</title>",
        "</head>",
        "<body>",
        "  ",
        "</body>",
        "</html>"
      })
    })
  },
}

-- CSS
lspconfig.cssls.setup {
  capabilities = capabilities,
}

-- C/C++
lspconfig.clangd.setup {
  capabilities = capabilities,
}
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'tsserver', 'html', 'cssls', 'clangd' }
})

