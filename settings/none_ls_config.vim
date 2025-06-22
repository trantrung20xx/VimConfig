lua << EOF
-- lua/null_ls_config.lua
local none_ls = require("null-ls")

none_ls.setup({
  sources = {
    -- Định dạng code (Formatting)
    none_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "vue", "css", "scss", "html", "json", "markdown", "yaml"
      },
    }),
    none_ls.builtins.formatting.stylua,
    none_ls.builtins.formatting.black.with({
      extra_args = { "--fast" }
    }),
    none_ls.builtins.formatting.isort,
	none_ls.builtins.formatting.black,

    -- Kiểm tra lỗi (Diagnostics/Linting)
    none_ls.builtins.diagnostics.pylint,
  },
  debug = false,
  vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {}),
})
EOF
