lua << EOF
-- lua/lsp_config.lua
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- 1. Thiết lập Mason UI
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- 2. Hàm on_attach dùng chung
local on_attach_shared_keymaps = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
    buffer = bufnr,
    callback = function()
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ bufnr = bufnr })
      end
    end,
  })

  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
end

-- 3. Khởi tạo danh sách server và tự động cài
local servers = {
  "lua_ls",
  "html",
  "cssls",
  "jsonls",
  "vimls",
  "pyright",
  "clangd",
  "rust_analyzer",
  "jdtls",
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- 4. Duyệt qua từng server để cấu hình
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server_name in ipairs(servers) do
  local opts = {
    on_attach = on_attach_shared_keymaps,
    capabilities = capabilities,
  }

  if server_name == "lua_ls" then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    }
  elseif server_name == "clangd" then
    opts.cmd = {
      "C:\\Users\\trant\\scoop\\apps\\msys2\\current\\mingw64\\bin\\clangd.EXE",
    }
    opts.root_dir = lspconfig.util.root_pattern(
      "compile_commands.json",
      "compile_flags.txt",
      ".git",
      "CMakeLists.txt"
    )
  elseif server_name == "jdtls" then
    opts.settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-21",
              path = "C:\\Users\\trant\\scoop\\apps\\temurin-lts-jdk\\current",
              default = true,
            },
          },
        },
      },
    }
  end

  lspconfig[server_name].setup(opts)
end
EOF
