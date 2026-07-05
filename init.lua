-- UnaliveUI - Apple-inspired Roblox UI Library
-- Figma-accurate components with iOS 26 / iPadOS 26 / macOS 26 animations

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

_G.__unaliveui_icons = loadModule("icons.lua") or {}
_G.__unaliveui_creator = loadModule("core/creator.lua") or {}
_G.__unaliveui_binder = loadModule("core/binder.lua") or {}

_G.__unaliveui_themes_Dark = loadModule("themes/Dark.lua")
_G.__unaliveui_themes_Light = loadModule("themes/Light.lua")
local themes = loadModule("themes/init.lua") or {}
local accents = loadModule("themes/accents.lua") or {}

_G.__unaliveui_animation = loadModule("animations/init.lua")
_G.__unaliveui_blur = loadModule("core/blur.lua")

local componentList = {
    Window = "components/Window.lua", Button = "components/Button.lua",
    Toggle = "components/Toggle.lua", Slider = "components/Slider.lua",
    Label = "components/Label.lua", TextField = "components/TextField.lua",
    Stepper = "components/Stepper.lua", Notification = "components/Notification.lua",
    Icon = "components/Icon.lua", Page = "components/Page.lua", Row = "components/Row.lua",
    EditMenu = "components/EditMenu.lua",
}
for name, path in pairs(componentList) do
    local mod = loadModule(path)
    if mod then _G["__unaliveui_components_" .. name] = mod end
end
local components = loadModule("components/init.lua") or {}
local services = loadModule("core/services.lua") or {}
local utility_mod = loadModule("core/utility.lua") or {}

local UnaliveUI = {
    Icons = _G.__unaliveui_icons, Services = services,
    Themes = themes, Accents = accents,
    Components = components, Creator = _G.__unaliveui_creator,
    Utility = utility_mod, Blur = _G.__unaliveui_blur,
    Animation = _G.__unaliveui_animation,
    VERSION = "2.0.0",
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

    local win = components.Window(app, { Title = "UnaliveUI", Size = UDim2.fromOffset(420, 360) })
    win.Parent(gui)

    local notif = components.Notification(app, { Title = "UnAlive", Description = "Welcome to UnaliveUI!", Duration = 5 })
    notif.Parent(gui)

    task.delay(1, function()
        local menu = components.EditMenu(app, {
            Items = {
                { Label = "Farm" }, { Label = "Shop" }, { Label = "Steal" },
                { Label = "Spawn", Destructive = true }, { Label = "Config" }, { Label = "Settings" },
            },
            OnSelected = function(item, idx)
                print("Selected:", item.Label, "at index", idx)
            end,
        })
        menu.Parent(gui)
        menu.__instance.Position = UDim2.new(0.5, -244, 0.5, 80)
        menu.__instance.BackgroundTransparency = 0
    end)

    print("UnaliveUI v" .. UnaliveUI.VERSION .. ": App created! (Figma-accurate + iOS 26 animations)")
    return app
end

function UnaliveUI.Demo() return UnaliveUI.New() end

_G.UnaliveUI = UnaliveUI
_G.UnaliveUI_LOADED = true
print("=== UnaliveUI v" .. UnaliveUI.VERSION .. " loaded! ===")
print("Use: UnaliveUI.Demo() to launch")
return UnaliveUI
