-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Cài đặt SHELL mặc định
config.default_prog = {"powershell.exe", "-NoLogo"}    

-- Tắt tab bar
config.enable_tab_bar = false
-- Tắt hiển thị tên cửa sổ
config.window_decorations = "RESIZE"

-- Theme
config.color_scheme = 'Tokyo Night'
-- Font
config.font = wezterm.font("Hack Nerd Font", {
    weight = "Medium",
})
-- Cursor color
config.colors = {
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
}

-- Padding
config.window_padding = {
    left = 0,
    right = 0,
    bottom = 0,
    top = 0,
}

-- Customize window opacity
config.window_background_opacity = 0.91
config.text_background_opacity = 1
config.macos_window_background_blur = 30

-- Config Image
config.window_background_image_hsb = {
    brightness = 0.08,
    hue = 1.0,
    saturation = 0.8,
}

-- Đường dẫn đến thư mục chứa hình ảnh
local background_folder = 'C:/Users/trant/Pictures/Background'

-- Hàm chọn ngẫu nhiên một hình ảnh từ thư mục
local function pick_random_background(folder)
    local pfile = io.popen('dir "' .. folder .. '" /b') -- Lệnh cmd để lấy danh sách các tệp trong thư mục
    if not pfile then return nil end 

    local images = {}
    for file in pfile:lines() do
        local ext = file:match("^.+(%..+)$") -- Lấy phần mở rộng của file
        if ext == ".jpg" or ext == ".jpeg" or ext == ".png" or ext == ".gif" or ext == ".JPG" or ext == ".bmp" then 
            table.insert(images, file) -- Thêm hình ảnh vào bảng
        end
    end
    pfile:close() -- Đóng file

    -- Nếu có hình ảnh, chọn ngẫu nhiên một hình ảnh từ thư mục
    return #images > 0 and folder .. "\\" .. images[math.random(1, #images)] or nil
end

-- Cấu hình phím tắt
config.keys = {
    {
        key = "b",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(
            function(window, pane)
                local new_background = pick_random_background(background_folder)
                if new_background then
                    window:set_config_overrides({
                        window_background_image = new_background,
                    })
                    wezterm.log_info("New background: " .. new_background)
                else
                    wezterm.log_error("Could not find any image.")
                end
            end
        ),
    },
    -- Chia dọc
    {
        key = "H",
        mods = "CTRL|ALT",
        action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}},
    },
    -- Chia ngang
    {
        key = "V",
        mods = "CTRL|ALT",
        action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}},
    },
    -- Đóng pane hiện tại (Cần xác nhận)
    {
        key = "w",
        mods = "CTRL",
        action = wezterm.action{CloseCurrentPane={confirm=true}},
    },
     -- Di chuyển giữa các pane
    {
        key = "H",
        mods = "CTRL",
        action = wezterm.action{ActivatePaneDirection="Left"},
    },
    {
        key = "L",
        mods = "CTRL",
        action = wezterm.action{ActivatePaneDirection="Right"},
    },
    {
        key = "K",
        mods = "CTRL",
        action = wezterm.action{ActivatePaneDirection="Up"},
    },
    {
        key = "J",
        mods = "CTRL",
        action = wezterm.action{ActivatePaneDirection="Down"},
    },
    -- Chuyển đổi giữa toàn màn hình và cửa sổ
    {
        key = "f",
        mods = "CTRL|ALT",
        action = wezterm.action.ToggleFullScreen,
    },
}

-- Trả về cấu hình cho Wezterm
return config
