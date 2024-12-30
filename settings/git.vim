" Các ký hiệu thay đổi Git theo phong cách GitHub
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '✖'
let g:gitgutter_sign_removed_first_line = '✖'
let g:gitgutter_sign_removed_above_and_below = '≠'
let g:gitgutter_sign_modified_removed = '⚡'


" Cập nhật màu sắc cho các dấu hiệu thay đổi
highlight GitGutterAdd guifg=#98c379  " Thêm dòng mới
highlight GitGutterChange guifg=#e5c07b  " Sửa đổi dòng
highlight GitGutterDelete guifg=#e06c75  " Dòng bị xóa
highlight GitGutterChangeDelete guifg=#d19a66  " Dòng vừa sửa và xóa

" Hiển thị preview các thay đổi Git trong cửa sổ nổi
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_preview_delay = 500

" Hiển thị thay đổi Git khi không có thay đổi
let g:gitgutter_enabled = 1

" Tự động cập nhật trạng thái Git khi lưu tệp
autocmd BufWritePost * GitGutter

" Hiển thị dấu hiệu Git trên cột số dòng (LineNr)
highlight! link SignColumn LineNr

