" F5 để bật/tắt NERDTree
map <silent> <F5> :NERDTreeToggle<CR>
" F6 tìm đến tệp hiện tại trong NERDTree
nnoremap <silent> <F6> :NERDTreeFind<CR>
" Đưa con trỏ chuột (tiêu điểm) đến cửa sổ NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>

" Thoát Vim nếu NERDTree là cửa sổ duy nhất còn lại trong tab duy nhất.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Thay đổi mũi tên để mở rộng/gập cây thư mục
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Biểu tượng trạng thái Git
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'★',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'≠',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'~',
    \ 'Ignored'   :'☒',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?',
\ }

" Sử dụng font Nerd để hiển thị icon Git
let g:NERDTreeGitStatusUseNerdFonts = 1  

" Làm nổi bật dòng hiện tại
let g:nerdtree_sync_cursorline = 1

" Hiển thị biểu tượng thư mục
let g:WebDevIconsUnicodeDecorateFolderNodes = 1  

" Thêm vào tabline của vim-airline
let g:webdevicons_enable_airline_tabline = 1

" Thêm vào statusline của vim-airline
let g:webdevicons_enable_airline_statusline = 1

" Thêm vào statusline của flagship
let g:webdevicons_enable_flagship_statusline = 1

" Sử dụng glyph hai chiều (1) hoặc một chiều (0)
" Chỉ thay đổi độ đệm, không ảnh hưởng đến terminal hay font (guifont)
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" Bật cờ để hiển thị glyph thư mục/thư mục con (mặc định là 0)
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Bật cờ để hiển thị glyph thư mục mở và đóng (mặc định là 0)
let g:DevIconsEnableFoldersOpenClose = 1

" let g:NERDTreeLimitedSyntax = 1
" let g:NERDTreeHighlightCursorline = 0

" Ẩn dấu ngoặc ( [] )
let g:NERDTreeGitStatusConcealBrackets = 1

" Nếu một buffer khác cố thay thế NERDTree, hãy đặt nó vào cửa sổ khác và đưa lại NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Hiển thị số dòng của file
let g:NERDTreeFileLines = 1

" Mở file, sau đó đồng bộ thư mục chứa file đó
" if has('win32')
"     autocmd BufEnter * lcd %:p:h
" endif






