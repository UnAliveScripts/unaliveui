--[[
	UnAliveUI — macOS-Style UI Library for Roblox
	
	Usage:
		local UnAlive = loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
		))()
		
		-- Create a window
		local window = UnAlive:Window({
			Title = "My App",
			Size = Vector2.new(540, 400),
		})
--]]

local SERVICES = {
	Players = game:GetService("Players"),
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
	RunService = game:GetService("RunService"),
	HttpService = game:GetService("HttpService"),
	Lighting = game:GetService("Lighting"),
}

local URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/"
local CACHE = {}

local function loadModule(path)
	if CACHE[path] then return CACHE[path] end
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(URL .. path .. "?t=" .. tostring(tick())))()
	end)
	if not ok then
		warn("[UnAlive] Failed to load: " .. path .. " — " .. tostring(result))
		return nil
	end
	CACHE[path] = result
	return result
end

local UnAlive = {
	VERSION = "2.0.0",
	Services = SERVICES,
	Theme = loadModule("themes/Dark.luau"),
	Icons = loadModule("modules/icons.luau"),
	Blur = loadModule("modules/effects/blur.luau"),
	Symbols = loadModule("modules/symbols.luau"),
	Animation = loadModule("animations/init.luau"),
	Utility = loadModule("modules/utility.luau"),
	Creator = loadModule("modules/creator.luau"),
}

local COMPONENT_LIST = {
	"Window", "WindowPill", "Button", "Toggle", "Slider", "Label",
	"TextField", "Icon", "Page", "Row", "Card", "SubCard",
	"Stepper", "StepperPill", "Notification", "Alert",
	"EditMenu", "Pulldown", "TrailingAccessories", "LiquidGlassButton",
}

for _, name in ipairs(COMPONENT_LIST) do
	local mod = loadModule("components/" .. name .. ".luau")
	if mod then
		UnAlive[name] = function(props)
			local ok, result = pcall(mod, UnAlive, props or {})
			if ok then return result end
			warn("[UnAlive] " .. name .. ": " .. tostring(result))
			return nil
		end
	end
end

function UnAlive:New(componentName, props)
	local constructor = self[componentName]
	if constructor then
		return constructor(props)
	end
	warn("[UnAlive] Unknown component: " .. tostring(componentName))
	return nil
end

return UnAlive
