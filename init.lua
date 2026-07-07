local URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/"

local function load(p)
	local ok, r = pcall(function() return loadstring(game:HttpGet(URL .. p))() end)
	if not ok then warn("UI: fail " .. p .. " " .. tostring(r)); return nil end
	return r
end

_G.__unaliveui_icons = load("icons.lua") or {}
_G.__unaliveui_blur = load("core/blur.lua")

local componentPaths = {
	Stepper = "components/Stepper.lua",
	StepperPill = "components/StepperPill.lua",
	Pulldown = "components/Pulldown.lua",
	TrailingAccessories = "components/TrailingAccessories.lua",
	Notification = "components/Notification.lua",
	Alert = "components/Alert.lua",
	EditMenu = "components/EditMenu.lua",
	WindowPill = "components/WindowPill.lua",
}

for n, p in pairs(componentPaths) do
	local m = load(p)
	if m then _G["__unaliveui_components_" .. n] = m end
end

local components = load("components/init.lua") or {}

_G.UnAliveUI = {
	Icons = _G.__unaliveui_icons,
	Components = components,
	Blur = _G.__unaliveui_blur,
	VERSION = "2.0.0",
}

return _G.UnAliveUI