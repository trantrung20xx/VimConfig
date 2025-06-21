"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                  " Hiển thị số dòng
set relativenumber          " Số dòng tương đối
set mouse=a                 " Cho phép sử dụng chuột
set tabstop=4               " Kích thước tab là 4 ký tự
set shiftwidth=4            " Độ rộng khi thụt dòng
set smarttab                " Nếu con trỏ ở đầu dòng thì thụt lề theo shiftwidth, giữa dòng theo tabstop
" set expandtab               " Sử dụng khoảng trắng thay vì tab
set termguicolors           " Bật chế độ màu 24-bit (có thể hiển thị 16.7 triệu màu thay vì 256 màu mặc định)
syntax on                   " Bật highlight cú pháp
set listchars=tab:\│\       " Tab sẽ được hiển thị bằng ký tự ¦ (│)
set list                    " Hiển thị các ký tự không in được (tab, khoảng trống, dòng mới)
set ignorecase              " Bỏ qua chữ hoa và chữ thường khi tìm kiếm
set autoindent              " Tự động áp dụng thụt lề cho dòng dưới dựa trên dòng hiện tại
set encoding=UTF-8
set signcolumn=auto         " Hiển thị cột dấu bên trái cột số dòng (hiển thị cảnh báo, lỗi hoặc git, ...)
"set cursorline             " Làm nổi bật dòng hiện tại
set undolevels=1000         " Số bước hoàn tác tối đa được lưu trữ cho mỗi tệp (buffer)
set history=100             " Số lượng lệnh (khi sử dụng với : ) và tìm kiếm gần nhất được lưu trữ 
set noshowmode              " Không hiển thị mode ở dưới phần command line
set lazyredraw
filetype plugin on


" Disable backup
set nobackup                " Tắt tính năng tạo file sao lưu
set nowb                    " Tắt sao lưu tạm thời trước khi ghi đè nội dung
set noswapfile              " Tắt tạo file .swap (dùng để khôi phục nội dung khi neovim bị đóng bất ngờ)
set nowritebackup



" Đồng bộ clipboard của Vim với clipboard mặc định của hệ thống
if has('win32')             " Nếu là Windows
  set clipboard=unnamed  
else                        " Không phải Windows (MacOS, Linux)
  set clipboard=unnamedplus
endif


" Close buffer without exitting vim 
nnoremap <silent> <leader>bd :bp \| sp \| bn \| bd<CR>

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
    \ |   checktime 
    \ | endif
autocmd FileChangedShellPost *
    \ echohl WarningMsg 
    \ | echo "File changed on disk. Buffer reloaded."
    \ | echohl None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Clipboard
" let mapleader = "\<Space>"
inoremap <silent> <S-Insert> <C-R>+         " Dán nội dung trực tiếp từ clipboard trong insert mode

" Key mapppings
nnoremap J 5j
nnoremap K 5k
nnoremap <silent> <M-k> :move .-2<CR>==[                 " Di chuyển con trỏ lên trên 2 dòng
nnoremap <silent> <M-j> :move .+1<CR>==[                 " Di chuyển con trỏ xuống dưới 1 dòng
nnoremap <silent> <M-J> :t..<CR>==[                      " Sao chép dòng hiện tại xuống dưới dòng hiện tại
nnoremap <silent> <M-K> :t. \| normal! k<CR>==[          " Sao chép vào dòng hiện tại (đẩy dòng gốc xuống dưới)
nnoremap <silent> <C-j> :wincmd j<CR>                    " Nhảy xuống cửa sổ bên dưới
nnoremap <silent> <C-k> :wincmd k<CR>                    " Nhảy lên cửa sổ bên trên
nnoremap <silent> <C-h> :wincmd h<CR>                    " Nhảy sang cửa sổ bên trái
nnoremap <silent> <C-l> :wincmd l<CR>                    " Nhảy sang cửa sổ bên phải
nnoremap <silent> <C-[> :bprevious<CR>                   " Chuyển sang buffer trước đó
nnoremap <silent> <C-]> :bnext<CR>                       " Chuyển sang buffer tiếp theo

vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> < <gv
vnoremap <silent> > >gv
vnoremap <silent> K :m '<-2<CR>gv=gv

" Di chuyển giữa các cửa sổ trong chế độ Insert
inoremap <C-k> <C-\><C-n><C-w>k
inoremap <C-h> <C-\><C-n><C-w>h
inoremap <C-j> <C-\><C-n><C-w>j
inoremap <C-l> <C-\><C-n><C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => resize pane
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <M-Right> :vertical resize +1<CR>
nnoremap <M-Left> :vertical resize -1<CR>
nnoremap <M-Down> :resize +1<CR>
nnoremap <M-Up> :resize -1<CR>
vnoremap <M-Right> :vertical resize +1<CR>
vnoremap <M-Left> :vertical resize -1<CR>
vnoremap <M-Down> :resize +1<CR>
vnoremap <M-Up> :resize -1<CR>
inoremap <M-Right> :vertical resize +1<CR>
inoremap <M-Left> :vertical resize -1<CR>
inoremap <M-Down> :resize +1<CR>
inoremap <M-Up> :resize -1<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin List
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')

    " Themes
    Plug 'folke/tokyonight.nvim'
    " Plug 'ghifarit53/tokyonight-vim'

    " Cài đặt bufferline
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    " Cài đặt nvim-web-devicons để hiển thị biểu tượng cho các buffer
    Plug 'nvim-tree/nvim-web-devicons'
    " Cài đặt lualine
    Plug 'nvim-lualine/lualine.nvim'

    " Cài đặt vim-airline
    "Plug 'vim-airline/vim-airline'
    " Cài đặt các theme của vim-airline (tuỳ chọn)
    "Plug 'vim-airline/vim-airline-themes'

    " Code intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdcommenter'       " Comment code
    Plug 'windwp/nvim-autopairs'         " Parenthesis auto

    " Code syntax highlight
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "Plug 'sheerun/vim-polyglot'
    
    " File search
    Plug 'junegunn/fzf', 
        \ { 'do': { -> fzf#install() } } " Fuzzy finder 
    Plug 'junegunn/fzf.vim'

    " File browser
    Plug 'preservim/nerdTree'
    Plug 'Xuyuanp/nerdtree-git-plugin'   " Git status         
    Plug 'ryanoasis/vim-devicons'        " Icon
    Plug 'unkiwii/vim-nerdtree-sync'     " Sync current file 
    Plug 'jcharum/vim-nerdtree-syntax-highlight',
    \ {'branch': 'escape-keys'}

    " Source code version control 
    Plug 'tpope/vim-fugitive'            " Git infomation 
    Plug 'tpope/vim-rhubarb' 
    Plug 'airblade/vim-gitgutter'        " Git show changes 
    Plug 'samoshkin/vim-mergetool'       " Git merge

    " Terminal
    Plug 'voldikss/vim-floaterm'

    " Smooth scroll
    Plug 'karb94/neoscroll.nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------- Theme tokyo night ---------------------
colorscheme tokyonight-night                    " night, storm, day, moon

let g:tokyonight_style = 'night'                " available: night, storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_transparent_background = 1
let g:tokyonight_disable_italic_comment = 0
let g:tokyonight_cursor = 'auto'                " auto, red, green, blue
let g:tokyonight_current_word = 'bold'          " bold, underline, italic, grey background

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Background
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark                                  " Đặt nền tối (dark - tối, light - sáng)
hi! Normal ctermbg=NONE guibg=NONE                   " Đặt hình nền chính của Neovim là trong suốt
hi! VertSplit ctermbg=NONE guibg=NONE                " Đặt màu nền của các đường phân tách cửa sổ là trong suốt
hi! StatusLine ctermbg=NONE guibg=NONE               " Đặt màu nền của thanh trạng thái là trong suốt
hi! LineNr ctermbg=NONE guibg=NONE guifg=#FF966C     " Đặt màu nền của số dòng là trong suốt
hi! NonText ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim-autopairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
    require("nvim-autopairs").setup {}
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => smooth scroll
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('neoscroll').setup({
  -- Các tùy chọn tùy chỉnh
  easing_function = "quadratic", -- Kiểu hiệu ứng cuộn (linear, cubic, sine, circular, quadratic, quartic, quintic)
})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ánh xạ phím tắt <leader>td để bật/tắt hiển thị lỗi của coc.nvim (diagnostics)
nnoremap <silent> <leader>td :call CocAction('diagnosticToggle')<CR>

for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
  execute 'source' setting_file
endfor




