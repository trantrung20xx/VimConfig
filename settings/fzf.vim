" Cài đặt phím tắt mặc định cho các hành động trong FZF
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" Cấu hình giao diện hiển thị FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9, 'highlight': 'Comment', 'relative': v:true } }

" Thiết lập cửa sổ xem trước kết quả FZF
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Tùy chọn định dạng khi hiển thị log git commits
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Tùy chỉnh màu sắc cho giao diện FZF
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
    \ }

" Cấu hình lệnh :Files để tìm kiếm tệp tin với giao diện FZF, dùng with_preview và bat để xem trước
let g:fzf_preview_opts = {
    \ 'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --theme=TwoDark --style=header,numbers,snip --line-range :500 {}']
    \ }

" Cấu hình lệnh :Files để mở tệp tin
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(g:fzf_preview_opts), <bang>0)

" Gán phím F7 để gọi lệnh :Files
map <F7> :Files<CR>

" Cấu hình lệnh :Rg để tìm kiếm nội dung tệp tin bằng ripgrep và bat để xem trước
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --color=always --smart-case -- '.shellescape(<q-args>),
    \   fzf#vim#with_preview(g:fzf_preview_opts), <bang>0)

" Gán phím F8 để gọi lệnh :Rg
map <F8> :Rg<CR>

" Cấu hình lệnh :Buffers để hiển thị danh sách buffer và tìm kiếm
command! -bang -nargs=* Buffers
    \ call fzf#vim#buffers(fzf#vim#with_preview(g:fzf_preview_opts), <bang>0)

" Gán phím F9 để gọi lệnh :Buffers
map <F9> :Buffers<CR>

" Thiết lập lệnh mặc định cho FZF sử dụng fd để liệt kê tệp, loại trừ các thư mục và tệp tin không cần thiết
let $FZF_DEFAULT_COMMAND = 'fd --hidden ' .
    \ '--exclude .git ' .
    \ '--exclude __pycache__ ' .
    \ '--exclude .vagrant ' .
    \ '--exclude node_modules ' .
    \ '--exclude .idea ' .
    \ '--exclude .vscode ' .
    \ '--exclude .terraform ' .
    \ '--exclude .tox ' .
    \ '--exclude .env ' .
    \ '--exclude .envrc ' .
    \ '--exclude target ' .
    \ '--exclude dist ' .
    \ '--exclude "*.log" ' .
    \ '--exclude "*.pyc" ' .
    \ '--exclude "*.pyo" ' .
    \ '--exclude "*.class" ' .
    \ '--exclude "*.o" ' .
    \ '--exclude "*.a" ' .
    \ '--exclude "*.so" ' .
    \ '--exclude "*.swp" ' .
    \ '--exclude "*.bak" ' .
    \ '--exclude "*.tmp" ' .
    \ '--exclude "*.db" ' .
    \ '--exclude "*.tgz" ' .
    \ '--exclude "*.tar.gz" ' .
    \ '--exclude "*.zip" ' .
    \ '--exclude venv ' .
    \ '--exclude build ' .
    \ '--exclude .cache ' .
    \ '--exclude out ' .
    \ '--exclude .mypy_cache ' .
    \ '--exclude .pytest_cache ' .
    \ '--exclude .ipynb_checkpoints ' .
    \ '--exclude .next ' .
    \ '--exclude .nuxt ' .
    \ '--exclude coverage ' .
    \ '--exclude tmp ' .
    \ '--exclude temp ' .
    \ '--exclude logs ' .
    \ '--exclude log ' .
    \ '--exclude .github'


" Tùy chỉnh các tùy chọn mặc định cho FZF
let $FZF_DEFAULT_OPTS="--layout=reverse --info=inline --exact"

