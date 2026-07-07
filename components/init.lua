local components = {}
local names = { "Stepper", "StepperPill", "Pulldown", "TrailingAccessories", "Notification", "Alert", "EditMenu", "WindowPill" }
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