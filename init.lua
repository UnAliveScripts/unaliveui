--[[
	UnAliveUI v2.0 — UI Library
	
	Usage:
		local UI = loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
		))()
		
		-- Create components
		local win = UI:New("Window", { Title = "My App" })
		win:Parent(gui)
		
		-- Or direct access
		local st = UI.Stepper({ Value = 5000 })
		st:Parent(gui)
--]]

local URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/"

local function load(path)
	local ok, r = pcall(function() return loadstring(game:HttpGet(URL .. path))() end)
	if not ok then warn("UI: fail " .. path .. " " .. tostring(r)); return nil end
	return r
end

-- Core
_G.__unaliveui_icons = load("icons.lua") or {}
_G.__unaliveui_creator = load("core/creator.lua") or {}
_G.__unaliveui_blur = load("core/blur.lua")

-- Themes
_G.__unaliveui_themes_Dark = load("themes/Dark.lua")

-- Animation
_G.__unaliveui_animation = load("animations/init.lua")

-- Components
local componentMap = {
	Window = "Window.lua", WindowPill = "WindowPill.lua",
	EditMenu = "EditMenu.lua", Stepper = "Stepper.lua",
	StepperPill = "StepperPill.lua", Pulldown = "Pulldown.lua",
	TrailingAccessories = "TrailingAccessories.lua",
	Notification = "Notification.lua", Alert = "Alert.lua",
	Button = "Button.lua", Toggle = "Toggle.lua",
	Slider = "Slider.lua", Label = "Label.lua",
	TextField = "TextField.lua", Icon = "Icon.lua",
	Page = "Page.lua", Row = "Row.lua",
	LiquidGlassButton = "LiquidGlassButton.lua",
}

for name, file in pairs(componentMap) do
	_G["__unaliveui_components_" .. name] = load("components/" .. file)
end

local registry = load("components/init.lua") or {}

-- Build UI object
local UI = {
	Icons = _G.__unaliveui_icons,
	Creator = _G.__unaliveui_creator,
	Blur = _G.__unaliveui_blur,
	Animation = _G.__unaliveui_animation,
	Themes = { Dark = _G.__unaliveui_themes_Dark },
	VERSION = "2.0.0",
}

-- Component constructors
for name, fn in pairs(registry) do
	UI[name] = function(props)
		local ok, r = pcall(fn, UI, props or {})
		if ok then return r end
	end
end

-- Generic constructor
function UI:New(name, props)
	local fn = registry[name]
	if fn then
		local ok, r = pcall(fn, UI, props or {})
		if ok then return r end
	end
end

-- Services
UI.Services = {}
local svcNames = { "Players", "TweenService", "UserInputService", "RunService", "HttpService" }
for _, name in ipairs(svcNames) do
	UI.Services[name] = game:GetService(name)
end

return UI