local components = {}
local componentNames = {
    "Window", "Button", "Toggle", "Slider", "Label",
    "TextField", "Stepper", "Notification", "Icon", "Page", "Row", "EditMenu"
}
for _, name in ipairs(componentNames) do
    local mod = _G["__unaliveui_components_" .. name]
    if mod then
        components[name] = function(self, ...)
            local ok, result = pcall(mod, self, ...)
            if not ok then
                warn("UnaliveUI: " .. name .. " error: " .. tostring(result))
                return nil
            end
            if type(result) == "table" then
                result.Type = result.Type or name
                if not result.Theme and self and self.Theme then
                    result.Theme = self.Theme
                end
            end
            return result
        end
    end
end
return components