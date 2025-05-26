lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- Tự động chọn theme dựa trên colorscheme của Neovim
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'nerdtree', 'neo-tree', 'NvimTree', 'dashboard', 'alpha' },
      winbar = {},
    },
    ignore_focus = { 'toggleterm', 'qf' },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
        icon = '', -- Biểu tượng cho mode
        fmt = function(str) return str:sub(1, 1) end, -- Hiển thị chữ cái đầu của mode
      },
    },
    lualine_b = {
      {
        'branch',
        icon = '', -- Biểu tượng Git branch
      },
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- Icons cho diff
        diff_color = {
          added = { fg = '#98c379' },
          modified = { fg = '#e5c07b' },
          removed = { fg = '#e06c75' },
        },
      },
      {
        'diagnostics',
        sources = { 'nvim_lsp', 'coc' }, -- Hỗ trợ cả LSP và COC
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
        file_status = true, -- Hiển thị trạng thái file (modified, readonly)
        path = 1, -- Hiển thị đường dẫn tương đối
        symbols = {
          modified = '●', -- Biểu tượng khi file được sửa đổi
          readonly = '', -- Biểu tượng khi file chỉ đọc
          unnamed = '[No Name]', -- Tên khi file không có tên
        },
      },
      {
        -- Hiển thị thông tin LSP
        function()
          local msg = 'No LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:', -- Biểu tượng cho LSP
        color = { fg = '#ffffff', gui = 'bold' },
      },
    },
    lualine_x = {
      {
        'encoding',
        icon = ' ', -- Biểu tượng cho encoding
      },
      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = '', -- Biểu tượng cho Unix
          dos = '', -- Biểu tượng cho Windows
          mac = '', -- Biểu tượng cho Mac
        },
      },
      {
        'filetype',
        icon_only = true, -- Chỉ hiển thị icon của filetype
      },
    },
    lualine_y = {
      {
        'progress',
        icon = '', -- Biểu tượng mới cho progress
        fmt = function() return '%P/%L' end, -- Hiển thị phần trăm và số dòng
      },
    },
    lualine_z = {
      {
        'location',
        icon = '', -- Biểu tượng cho vị trí con trỏ
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
        mode = 2, -- Hiển thị tên buffer và số
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
    lualine_z = { 'tabs' },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = { 'nvim-tree', 'fugitive', 'quickfix', 'toggleterm' },
}
EOF
