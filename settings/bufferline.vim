" Cấu hình cho bufferline.nvim (Lua)
lua << EOF
require'bufferline'.setup {
  options = {
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
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" } -- Offset cho NvimTree
    },
    get_element_icon = function(buf)         -- Lấy biểu tượng từ nvim-web-devicons
      local icon, _ = require('nvim-web-devicons').get_icon(buf.name, buf.extension, { default = false })
      return icon or ''
    end,

    highlights = require("tokyonight.colors").setup() -- Tự động sử dụng màu sắc từ tokyonight
  },
}
EOF

" Cấu hình phím tắt cho các buffer
nnoremap <silent> <leader>bp :BufferLinePick<CR>      " Chọn buffer
nnoremap <silent> <leader>bn :BufferLineCycleNext<CR> " Chuyển sang buffer tiếp theo
nnoremap <silent> <leader>bb :BufferLineCyclePrev<CR> " Chuyển sang buffer trước đó
nnoremap <silent> <leader>bd :bdelete<CR>             " Đóng buffer hiện tại

