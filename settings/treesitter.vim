lua << EOF
require'nvim-treesitter.configs'.setup {
  auto_install = true,
  ensure_installed = {
    "css", "html", "json", "javascript", "python",
    "c", "cpp", "rust", "java", "c_sharp",
    "lua", "vim", "markdown"
  },
  sync_install = false,
  highlight = {
    enable = true,              -- Bật tô sáng cú pháp
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true               -- Tự động thụt lề
  }
}
EOF
