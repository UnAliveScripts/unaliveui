local URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/"

local function load(p)
	local ok, r = pcall(function()
		return loadstring(game:HttpGet(URL .. p))()
	end)

	if not ok then
		warn("UI: fail " .. p .. " " .. tostring(r))
		return nil
	end

	return r
end

_G.__unaliveui_icons = load("icons.lua") or {}
_G.__unaliveui_creator = load("core/creator.lua") or {}
_G.__unaliveui_binder = load("core/binder.lua") or {}
_G.__unaliveui_themes_Dark = load("themes/Dark.lua")
_G.__unaliveui_animation = load("animations/init.lua")
_G.__unaliveui_blur = load("core/blur.lua")

local services = load("core/services.lua") or {}
local utility = load("core/utility.lua") or {}

local componentPaths = {
	Window = "components/Window.lua",
	Button = "components/Button.lua",
	Toggle = "components/Toggle.lua",
	Slider = "components/Slider.lua",
	Label = "components/Label.lua",
	TextField = "components/TextField.lua",
	Stepper = "components/Stepper.lua",
	StepperPill = "components/StepperPill.lua",
	Pulldown = "components/Pulldown.lua",
	TrailingAccessories = "components/TrailingAccessories.lua",
	Notification = "components/Notification.lua",
	Alert = "components/Alert.lua",
	WindowPill = "components/WindowPill.lua",
	Icon = "components/Icon.lua",
	Page = "components/Page.lua",
	Row = "components/Row.lua",
	EditMenu = "components/EditMenu.lua",
}

for n, p in pairs(componentPaths) do
	local m = load(p)
	if m then
		_G["__unaliveui_components_" .. n] = m
	end
end

local components = load("components/init.lua") or {}

_G.UnaliveUI = {
	Icons = _G.__unaliveui_icons,
	Services = services,
	Themes = { Dark = _G.__unaliveui_themes_Dark },
	Components = components,
	Creator = _G.__unaliveui_creator,
	Binder = _G.__unaliveui_binder,
	Utility = utility,
	Blur = _G.__unaliveui_blur,
	Animation = _G.__unaliveui_animation,
	VERSION = "2.0.0",
}

return _G.UnaliveUI