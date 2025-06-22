lua << EOF
-- lua/lsp_config.lua
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- 1. Thiết lập Mason để quản lý các LSP server
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Định nghĩa hàm on_attach dùng chung cho tất cả các LSP server
local on_attach_shared_keymaps = function(client, bufnr)
    -- Các tùy chọn chung cho keymap: không đệ quy, im lặng, và chỉ áp dụng cho buffer hiện tại
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Đặt omnifunc cho buffer hiện tại để sử dụng tính năng tự động hoàn thành của LSP
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Định nghĩa các keymap LSP chung
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- Đi tới Definition
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)     -- Đi tới Declaration
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)      -- Đi tới References
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- Đi tới Implementation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)            -- Hiển thị thông tin hover (tài liệu)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  -- Đổi tên biểu tượng
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- Hành động code (chế độ normal và visual)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)   -- Định dạng code

    -- Tự động định dạng code trước khi lưu file nếu LSP server hỗ trợ
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", {}), -- Tạo một nhóm autocommand để quản lý
        buffer = bufnr, -- Chỉ áp dụng cho buffer hiện tại
        callback = function()
            -- Kiểm tra xem client có hỗ trợ phương thức định dạng không
            if client.supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = bufnr }) -- Thực hiện định dạng
            end
        end
    })

    -- Định nghĩa các keymap cho Diagnostic (thông báo lỗi/cảnh báo)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)     -- Đi tới Diagnostic trước đó
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)     -- Đi tới Diagnostic tiếp theo
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts) -- Đặt tất cả Diagnostic vào loclist
end

-- 2. Thiết lập mason-lspconfig để quản lý cài đặt và cấu hình các LSP server
mason_lspconfig.setup({
  -- Danh sách các LSP server mà Mason sẽ cài đặt nếu chưa có
  ensure_installed = {
    "lua_ls",        -- Lua language server (cần cho cấu hình Neovim bằng Lua)
    "html",          -- HTML language server
    "cssls",         -- CSS language server
    "jsonls",        -- JSON language server
    "vimls",         -- Vim Script language server
    "pyright",       -- Python language server
    "clangd",        -- C/C++ language server
    "rust_analyzer", -- Rust language server
    "jdtls",         -- Java Development Tools Language Server
    -- Thêm các server khác ở đây
  },
  automatic_installation = true, -- Tự động cài đặt nếu thiếu server trong danh sách
  handlers = {
    -- Hàm này sẽ được gọi cho MỌI LSP server mà Mason cài đặt và lspconfig setup
    function(server_name)
      -- Lấy capabilities mặc định cho LSP client từ cmp_nvim_lsp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Cấu hình mặc định chung cho TẤT CẢ các server
      local server_opts = {
        capabilities = capabilities,
        on_attach = on_attach_shared_keymaps, -- Gắn hàm keymap chung đã định nghĩa
      }

      -- Cấu hình đặc biệt cho TỪNG server (chỉ khi server đó cần cài đặt riêng biệt)
      if server_name == "lua_ls" then
        server_opts.settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Khai báo "vim" là biến toàn cục để tránh cảnh báo
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Thiết lập thư viện workspace
              checkThirdParty = false, -- Không kiểm tra các thư viện bên thứ ba
            },
            telemetry = {
              enable = false, -- Tắt telemetry (gửi dữ liệu sử dụng)
            },
          },
        }
      elseif server_name == "jdtls" then
        -- Cấu hình cho JDTLS (Java)
        server_opts.settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21", -- Tên phiên bản Java
                  path = "C:\\Users\\trant\\scoop\\apps\\temurin-lts-jdk\\current",
                  default = true, -- Đặt làm runtime mặc định
                },
              },
            },
          },
        }
      end

      -- Cuối cùng, thiết lập LSP server với cấu hình đã tổng hợp
      lspconfig[server_name].setup(server_opts)
    end,
  }
})
EOF
