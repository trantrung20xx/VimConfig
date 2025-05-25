lua <<EOF
-- Bật module loader mới của Neovim (0.9+) để tăng tốc độ load
vim.loader.enable()

-- 1. Khởi tạo cache hệ thống
local system_info_cache = {
  last_update = 0,
  data = { os_icon = '', cpu = 'N/A', mem = 'N/A' }
}

-- 2. Hàm lấy thông tin hệ thống với lazy loading và caching
local function get_system_info()
  local now = os.time() * 1000
  if now - system_info_cache.last_update < 60000 then
    return system_info_cache.data
  end

  -- Xác định OS icon
  local os_icon = vim.fn.has('win32') == 1 and '' or 
                 vim.fn.has('mac') == 1 and '' or ''

  local cpu_usage, mem_usage = 'N/A', 'N/A'
  
  if vim.fn.has('win32') == 1 then
    local handle = io.popen('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).LoadPercentage" 2>nul')
    cpu_usage = handle:read('*a'):gsub('%s+', '') or 'N/A'
    handle:close()
    
    local mem_cmd = [[powershell -NoProfile -Command "$m=Get-CimInstance Win32_OperatingSystem; $u=($m.TotalVisibleMemorySize-$m.FreePhysicalMemory)/1MB; $t=$m.TotalVisibleMemorySize/1MB; \"{0:N1}GB/{1:N1}GB\" -f $u,$t" 2>nul]]
    handle = io.popen(mem_cmd)
    mem_usage = handle:read('*a'):gsub('%s+', '') or 'N/A'
    handle:close()
  else
    local handle = io.popen("grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' 2>/dev/null | cut -d'.' -f1")
    cpu_usage = handle:read('*a'):gsub('%s+', '') or 'N/A'
    handle:close()
    
    handle = io.popen("free -g | awk 'NR==2{printf \"%.1fGB/%.1fGB\", $3,$2}' 2>/dev/null")
    mem_usage = handle:read('*a'):gsub('%s+', '') or 'N/A'
    handle:close()
  end
  
  cpu_usage = cpu_usage ~= 'N/A' and cpu_usage..'%%' or 'N/A'
  system_info_cache.data = { os_icon = os_icon, cpu = cpu_usage, mem = mem_usage }
  system_info_cache.last_update = now
  return system_info_cache.data
end

-- 3. Các component được tối ưu
local function system_info()
  local info = get_system_info()
  return string.format('%s  |   %s  |   %s', info.os_icon, info.cpu, info.mem)
end

local function time()
  return os.date(' %H:%M')
end

local function location()
  return string.format(' %d:%-2d', vim.fn.line('.'), vim.fn.col('.'))
end

-- 4. Cấu hình chính cho Lualine
local lualine_config = {
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      {
        'filename',
        path = 1,
        symbols = {
          modified = '●',
          readonly = '',
          unnamed = '[No Name]',
        },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp', 'coc' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      },
      'encoding',
      'filetype',
    },
    lualine_y = { system_info },
    lualine_z = { location, time },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'nerdtree', 'neo-tree', 'nvim-tree', 'fzf', 'quickfix' }
}

-- 5. Khởi tạo Lualine
require('lualine').setup(lualine_config)
EOF
