lua <<EOF
-- Hàm tùy chỉnh để lấy trạng thái CoC với spinner
local function coc_status()
  local status = vim.fn['coc#status']() or ''
  local spinners = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
  local done = '✓'
  local coc_info = vim.g.coc_service_initialized and vim.g.coc_service_initialized == 1
  if coc_info and status ~= '' then
    local spinner_idx = math.floor(vim.loop.now() / 100) % #spinners + 1
    return spinners[spinner_idx] .. ' ' .. status
  elseif coc_info then
    return done .. ' CoC'
  else
    return 'No CoC'
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- Tự động chọn theme, tương thích với colorscheme
    component_separators = { left = '', right = '' }, -- Separators nhẹ hơn
    section_separators = { left = '', right = '' }, -- Separators mượt hơn
    disabled_filetypes = {
      statusline = { 'nerdtree', 'neo-tree', 'NvimTree', 'dashboard', 'alpha', 'startify' },
      winbar = {},
    },
    ignore_focus = { 'toggleterm', 'qf', 'help' },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
        icon = '', -- Biểu tượng cho mode
        fmt = function(str) return str:sub(1, 1) end, -- Hiển thị chữ cái đầu của mode
        color = { gui = 'bold' },
      },
      {
        -- Thành phần lsp_status cho CoC
        coc_status,
        icon = '', -- Biểu tượng cho CoC status
        color = { fg = '#2e3440', gui = 'bold' }, -- Xanh đen rất đậm, dễ nhìn
      },
    },
    lualine_b = {
      {
        'branch',
        icon = '', -- Biểu tượng Git branch
        color = { fg = '#98c379' }, -- Màu xanh lá
      },
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color = {
          added = { fg = '#98c379' },
          modified = { fg = '#e5c07b' },
          removed = { fg = '#e06c75' },
        },
      },
      {
        'diagnostics',
        sources = { 'coc' }, -- Chỉ dùng CoC diagnostics
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        diagnostics_color = {
          error = { fg = '#e06c75' },
          warn = { fg = '#e5c07b' },
          info = { fg = '#61afef' },
          hint = { fg = '#98c379' },
        },
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1, -- Đường dẫn tương đối
        symbols = {
          modified = '●',
          readonly = '',
          unnamed = '[No Name]',
        },
        color = { fg = '#d8dee9' }, -- Màu trắng xám nhẹ
      },
      {
        'searchcount',
        icon = '', -- Biểu tượng tìm kiếm
        color = { fg = '#61afef' }, -- Màu xanh dương
      },
    },
    lualine_x = {
      {
        'encoding',
        icon = ' ',
        color = { fg = '#abb2bf' },
      },
      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        },
        color = { fg = '#abb2bf' },
      },
      {
        'filetype',
        --icon_only = true,
        color = { fg = '#abb2bf' },
      },
    },
    lualine_y = {
      {
        'progress',
        icon = '', -- Biểu tượng progress
        fmt = function() return '%P/%L' end,
        color = { fg = '#98c379' },
      },
      {
        'selectioncount',
        icon = '', -- Biểu tượng cho số lượng chọn
        color = { fg = '#e5c07b' },
      },
    },
    lualine_z = {
      {
        'location',
        icon = '',
        color = { fg = '#2e3440', gui = 'bold' }, -- Xanh đen rất đậm, dịu mắt
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        symbols = {
          modified = '●',
          readonly = '',
          unnamed = '[No Name]',
        },
        color = { fg = '#4b5263' }, -- Màu xám cho inactive
      },
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,
        hide_filename_extension = true,
        show_modified_status = true,
        mode = 4, -- Hiển thị buffer với icon filetype
        symbols = {
          modified = ' ●',
          alternate_file = '',
          directory = '',
        },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'tabs',
        mode = 1, -- Hiển thị tên tab
        tabs_color = {
          active = { fg = '#2e3440', gui = 'bold' },
          inactive = { fg = '#4b5263' },
        },
      },
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = { 'nvim-tree', 'fugitive', 'quickfix', 'toggleterm', 'man', 'lazy' },
}
EOF
