lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css", "html", "json", "typescript", "python",
    "c", "cpp", "rust", "java", "c_sharp"
  },
  highlight = {
    enable = true,              -- Bật tô sáng cú pháp
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true               -- Tự động thụt lề
  }
}
EOF
