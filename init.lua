-- UnaliveUI - Apple-inspired Roblox UI Library
-- Load with: loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"))()

local BASE_URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/"

local function loadModule(path)
    local url = BASE_URL .. path
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not ok then
        warn("UnaliveUI: Failed to load " .. path .. " - " .. tostring(result))
        return nil
    end
    return result
end

-- Icons
_G.__unaliveui_icons = loadModule("icons.lua") or {}

-- Core
_G.__unaliveui_creator = loadModule("core/creator.lua") or {}
_G.__unaliveui_binder = loadModule("core/binder.lua") or {}

-- Themes
_G.__unaliveui_themes_Dark = loadModule("themes/Dark.lua")
_G.__unaliveui_themes_Light = loadModule("themes/Light.lua")
local themes = loadModule("themes/init.lua") or {}
local accents = loadModule("themes/accents.lua") or {}

-- Blur
_G.__unaliveui_blur = loadModule("core/blur.lua")

-- Components
local componentList = {
    Window = "components/Window.lua", Button = "components/Button.lua",
    Toggle = "components/Toggle.lua", Slider = "components/Slider.lua",
    Label = "components/Label.lua", TextField = "components/TextField.lua",
    Stepper = "components/Stepper.lua", Notification = "components/Notification.lua",
    Icon = "components/Icon.lua", Page = "components/Page.lua", Row = "components/Row.lua",
}
for name, path in pairs(componentList) do
    local mod = loadModule(path)
    if mod then _G["__unaliveui_components_" .. name] = mod end
end
local components = loadModule("components/init.lua") or {}
local services = loadModule("core/services.lua") or {}
local utility_mod = loadModule("core/utility.lua") or {}

-- Build UnaliveUI
local UnaliveUI = {
    Icons = _G.__unaliveui_icons, Services = services,
    Themes = themes, Accents = accents,
    Components = components, Creator = _G.__unaliveui_creator,
    Utility = utility_mod, Blur = _G.__unaliveui_blur,
    VERSION = "1.0.0",
}

function UnaliveUI.New(config)
    config = config or {}
    local playerGui = services.Players and services.Players.LocalPlayer
        and services.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then playerGui = game:GetService("CoreGui") end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "UnaliveUI"; gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 200; gui.IgnoreGuiInset = true
    gui.Parent = playerGui
    
    local app = { Gui = gui, Theme = _G.__unaliveui_themes_Dark, Accent = accents.Blue, __container = gui }
    setmetatable(app, { __index = components })
    
    -- Demo window
    local win = components.Window(app, { Title = "UnaliveUI", Size = UDim2.fromOffset(420, 360) })
    win.Parent(gui)
    
    -- Demo notification
    local notif = components.Notification(app, { Title = "UnaliveUI", Description = "Welcome to UnaliveUI!", Duration = 5 })
    notif.Parent(gui)
    
    print("UnaliveUI: App created!")
    return app
end

function UnaliveUI.Demo() return UnaliveUI.New() end

_G.UnaliveUI = UnaliveUI
print("=== UnaliveUI v" .. UnaliveUI.VERSION .. " loaded! ===")
print("Use: UnaliveUI.Demo() to launch")
return UnaliveUI