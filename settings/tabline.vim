" Bật vim-airline và các mở rộng liên quan
let g:airline#extensions#tabline#enabled = 0                    " Kích hoạt tabline
let g:airline#extensions#tabline#fnamemod = ':t'                " Chỉ hiển thị tên file (không có đường dẫn)
let g:airline#extensions#tabline#show_tabs = 1                  " Hiển thị các tab đang mở

" Kích hoạt các thông tin hữu ích trên thanh trạng thái
let g:airline#extensions#mode#enabled = 1                       " Hiển thị chế độ (normal, insert, v.v.)
let g:airline#extensions#lineinfo#enabled = 1                   " Hiển thị thông tin về dòng và cột
let g:airline#extensions#filename#enabled = 1                   " Hiển thị tên file hiện tại
let g:airline#extensions#filetype#enabled = 1                   " Hiển thị loại file

" Tùy chỉnh tabline trong airline
let g:airline#extensions#tabline#left_sep = ''                 " Dấu phân cách bên trái tab
let g:airline#extensions#tabline#right_sep = ''                " Dấu phân cách bên phải tab
let g:airline#extensions#tabline#max_size = 20                  " Kích thước tối đa cho tên tab

" Tắt bufferline của vim-airline (Để bufferline của bufferline.nvim hoạt động)
let g:airline#extensions#bufferline#enabled = 0                 " Bufferline trong vim-airline
let g:airline#extensions#bufferline#show_numbers = 1            " Hiển thị số thứ tự buffer
let g:airline#extensions#bufferline#highlight_visible = 1       " Làm nổi bật buffer đang hiển thị
let g:airline#extensions#bufferline#highlight_selected = 1      " Làm nổi bật buffer đang được chọn

" Cấu hình để hiển thị thêm các thông tin về người dùng và máy
let g:airline#extensions#hostname#enabled = 1                   " Hiển thị tên host (máy tính)
let g:airline#extensions#branch#enabled = 1                     " Hiển thị nhánh git nếu có
let g:airline#extensions#filetype#enabled = 1                   " Hiển thị loại file

" Hiển thị các phần mở rộng khác nếu cần thiết
let g:airline_theme = 'night_owl'                               " Chọn theme dark cho airline

" Tùy chỉnh font chữ cho vim-airline
let g:airline#extensions#tabline#font = "Hack"
" Kích hoạt Powerline fonts trong vim-airline
let g:airline_powerline_fonts = 1

" Các thiết lập khác
set showtabline=2                                               " Luôn luôn hiển thị tabline
set laststatus=2                                                " Luôn luôn hiển thị thanh trạng thái

