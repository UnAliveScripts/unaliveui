local creator = {}
function creator.Create(className)
    return function(properties)
        properties = properties or {}
        local instance = Instance.new(className)
        for key, value in pairs(properties) do
            if type(value) == "table" and getmetatable(value) and type(getmetatable(value)) == "Instance" then
                pcall(function() value.Parent = instance end)
            else
                pcall(function() instance[key] = value end)
            end
        end
        return setmetatable({}, {
            __metatable = instance,
            __index = function(_, key)
                if key == "__instance" then return instance end
                local v = instance[key]
                if type(v) == "function" then
                    return function(_, ...) return v(instance, ...) end
                end
                return v
            end,
            __newindex = function(_, key, value)
                instance[key] = value
            end,
        })
    end
end
return creator