lua << EOF
-- lua/cmp_config.lua
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Cần load friendly-snippets nếu chưa được load ở đâu đó
-- (Trong đoạn setup plugin, đã có friendly-snippets là dependency của LuaSnip, nên nó sẽ được load)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Sử dụng luasnip để mở rộng snippet
    end,
  },
  window = {
    completion = cmp.config.window.bordered(), -- Khung gợi ý có viền
    documentation = cmp.config.window.bordered(), -- Khung tài liệu có viền
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-5), -- Cuộn tài liệu lên
    ['<C-f>'] = cmp.mapping.scroll_docs(5),  -- Cuộn tài liệu xuống
    ['<C-Space>'] = cmp.mapping.complete(),  -- Kích hoạt tự động hoàn thành
    ['<C-e>'] = cmp.mapping.abort(),         -- Hủy tự động hoàn thành
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Chấp nhận mục đã chọn (chọn và chèn)
    ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Chọn mục trước đó
    ['<Tab>'] = cmp.mapping.select_next_item(), -- Chọn mục tiếp theo
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- Nguồn từ LSP servers (bao gồm pyright, clangd, rust_analyzer, jdtls, lua_ls, html, cssls, jsonls, vimls)
    { name = 'luasnip' },   -- Nguồn từ LuaSnip (snippets)
  }, {
    { name = 'buffer' },    -- Nguồn từ buffer hiện tại
    { name = 'path' },      -- Nguồn từ đường dẫn file
  }),
  formatting = {
    -- Tùy chỉnh hiển thị mục gợi ý với lspkind
    format = lspkind.cmp_format({ -- Dùng lspkind.cmp_format để đơn giản hóa
      with_text = true, -- Hiển thị cả icon và văn bản gợi ý
      maxwidth = 50, -- Giới hạn độ rộng để tránh tràn
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        path = "[Path]",
      }
    })
  },
})

-- Tùy chỉnh cửa sổ diagnostic (lỗi/cảnh báo)
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "", -- Ký tự prefix cho virtual text
  },
  signs = true, -- Hiển thị dấu hiệu (signs) ở cột signcolumn
  update_in_insert = false, -- Không cập nhật diagnostic trong chế độ Insert
  severity_sort = true, -- Sắp xếp diagnostic theo mức độ nghiêm trọng
  float = {
    border = "rounded", -- Khung diagnostic nổi có viền bo tròn
  },
})

-- require('lspkind').init({
   -- mode = 'symbol_text', -- hiển thị icon và text
   -- preset = 'codicons',  -- sử dụng icon từ codicons
-- })
EOF
