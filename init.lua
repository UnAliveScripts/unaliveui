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
_G.__unaliveui_animation = loadModule("animations/init.lua")
_G.__unaliveui_blur = loadModule("core/blur.lua")

local services = loadModule("core/services.lua") or {}
local utility_mod = loadModule("core/utility.lua") or {}

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

_G.UnaliveUI = {
    Icons = _G.__unaliveui_icons,
    Services = services,
    Themes = { Dark = _G.__unaliveui_themes_Dark },
    Components = components,
    Creator = _G.__unaliveui_creator,
    Binder = _G.__unaliveui_binder,
    Utility = utility_mod,
    Blur = _G.__unaliveui_blur,
    Animation = _G.__unaliveui_animation,
    VERSION = "2.0.0",
}

return _G.UnaliveUI