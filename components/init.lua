--[[
	UnAliveUI — Component Registry
	
	Auto-loads all components from _G globals set by init.lua.
--]]

local names = {
	"Window", "WindowPill", "EditMenu", "Stepper", "StepperPill",
	"Pulldown", "TrailingAccessories", "Notification", "Alert",
	"Button", "Toggle", "Slider", "Label", "TextField", "Icon", "Page", "Row",
	"LiquidGlassButton",
}

local components = {}
for _, n in ipairs(names) do
	local mod = _G["__unaliveui_components_" .. n]
	if mod then
		components[n] = function(self, ...)
			local ok, r = pcall(mod, self, ...)
			if not ok then warn("UI:" .. n .. " " .. tostring(r)); return nil end
			if type(r) == "table" then
				r.Type = r.Type or n
				if not r.Theme and self and self.Theme then r.Theme = self.Theme end
			end
			return r
		end
	end
end
return components