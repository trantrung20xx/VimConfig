" Cấu hình cho bufferline.nvim (Lua)
lua << EOF
require'bufferline'.setup {
  options = {
    mode = 'buffers',
    numbers = "ordinal",                     -- Hiển thị số thứ tự (có thể là 'none', 'ordinal', 'both')
    close_command = "bdelete",               -- Lệnh để đóng buffer
    right_mouse_command = "bdelete!",        -- Đóng buffer khi click chuột phải
    show_buffer_icons = true,                -- Hiển thị biểu tượng của file
    show_buffer_close_icons = true,          -- Hiển thị biểu tượng đóng buffer
    show_tab_indicators = true,              -- Hiển thị chỉ báo tab
    separator_style = "slant",               -- Chọn kiểu phân cách giữa các buffer (thin, slant, wave, ...)
    diagnostics = "nvim_lsp | coc",          -- Hiển thị cảnh báo lỗi từ LSP nếu có
    diagnostics_update_in_insert = false,    -- Cập nhật diagnostics khi đang trong chế độ insert
    always_show_bufferline = true,           -- Luôn hiển thị bufferline
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
          or (e == "warning" and " " or " ")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = { 
      { filetype = "nerdtree", text = "File Explorer", text_align = "center", highlight = "Directory", separator = true } -- Offset cho NvimTree
    },
    get_element_icon = function(buf)         -- Lấy biểu tượng từ nvim-web-devicons
      local icon, _ = require('nvim-web-devicons').get_icon(buf.name, buf.extension, { default = false })
      return icon or ''
    end,

    highlights = require("tokyonight.colors").setup() -- Tự động sử dụng màu sắc từ tokyonight
  },
}

-- Cấu hình phím tắt trong Lua cho các buffer
vim.api.nvim_set_keymap('n', '<leader>bl', ':BufferLinePick<CR>', { noremap = true, silent = true })      -- Chọn buffer
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true }) -- Chuyển sang buffer tiếp theo
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true }) -- Chuyển sang buffer trước đó
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })             -- Đóng buffer hiện tại
EOF

