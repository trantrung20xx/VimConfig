" Cài đặt các extension cần thiết ngay từ lần khởi động đầu tiên
let g:coc_global_extension = [
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-pyright',
  \ 'coc-clangd',
  \ 'coc-rust-analyzer',
  \ 'coc-java',
  \ 'coc-omnisharp',
  \ 'coc-lua',
  \ 'coc-vimlsp'
  \]

" Tô sáng biến hoặc hàm khi di chuyển con trỏ vào
autocmd BufEnter * silent! call CocActionAsync('highlight')

" Giảm thời gian cập nhật để cải thiện trải nghiệm người dùng (mặc định là 4000ms)
set updatetime=300

" Dùng phím Tab để gợi ý và chuyển qua lại giữa các lựa chọn gợi ý
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Dùng phím Enter để chọn mục gợi ý hoặc xuống dòng (và tự động định dạng nếu cần)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
                              \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Hàm kiểm tra nếu ký tự trước con trỏ là khoảng trắng
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Gợi ý thủ công khi nhấn Ctrl + Space
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Điều hướng các lỗi (diagnostics)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Điều hướng mã nguồn
nmap <silent> gd <Plug>(coc-definition)         " Đi đến định nghĩa
nmap <silent> gy <Plug>(coc-type-definition)    " Đi đến kiểu dữ liệu
nmap <silent> gi <Plug>(coc-implementation)     " Đi đến nơi cài đặt
nmap <silent> gr <Plug>(coc-references)         " Tìm tất cả nơi được tham chiếu

" Hiển thị tài liệu hàm dưới con trỏ bằng Ctrl + Alt + K
nnoremap <silent> <C-M-K> :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Tô sáng khi giữ con trỏ đứng yên tại một vị trí
autocmd CursorHold * silent call CocActionAsync('highlight')

" Đổi tên biến/hàm
nmap <leader>rn <Plug>(coc-rename)

" Định dạng đoạn mã được chọn
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f :call CocActionAsync('format')<CR>
nmap <leader>f :call CocActionAsync('format')<CR>

" Cấu hình định dạng tự động theo loại file
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" Thực hiện code actions trên vùng được chọn
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Thực hiện code action tại vị trí con trỏ
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" Thực hiện code action cho toàn bộ file
nmap <leader>as  <Plug>(coc-codeaction-source)

" Áp dụng quickfix cho lỗi hiện tại
nmap <leader>qf  <Plug>(coc-fix-current)

" Áp dụng refactor
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Chạy CodeLens trên dòng hiện tại
nmap <leader>cl  <Plug>(coc-codelens-action)

" Di chuyển theo hàm hoặc class
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Cuộn popup khi xem tài liệu nếu cần
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Thêm lệnh :Format để định dạng toàn bộ file
command! -nargs=0 Format :call CocActionAsync('format')

" Thêm lệnh :Fold để gấp/mở mã
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Thêm lệnh :OR để tự động tổ chức lại phần import
command! -nargs=0 OR   :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Thêm thông tin Coc vào statusline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Các lệnh cho CocList
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>     " Xem toàn bộ lỗi
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>      " Quản lý extension
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>        " Hiển thị các lệnh
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>         " Xem outline file hiện tại
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>      " Tìm ký hiệu trong workspace
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>                 " Mục tiếp theo trong danh sách
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>                 " Mục trước đó trong danh sách
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>           " Quay lại danh sách Coc trước đó


