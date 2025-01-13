lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css", "html", "json", "javascript", "python",
    "c", "cpp", "rust", "java", "c_sharp",
    "lua", "vim"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,              -- Bật tô sáng cú pháp
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true               -- Tự động thụt lề
  }
}
EOF
