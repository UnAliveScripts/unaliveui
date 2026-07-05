local creator = {}
function creator.Create(className)
    return function(properties)
        properties = properties or {}
        local instance = Instance.new(className)
        local children = {}
        for key, value in pairs(properties) do
            if type(value) == "table" and rawget(value, "__isProxy") then
                table.insert(children, rawget(value, "__instance"))
            else
                pcall(function() instance[key] = value end)
            end
        end
        for _, child in ipairs(children) do
            pcall(function() child.Parent = instance end)
        end
        local proxy = { __isProxy = true, __instance = instance }
        return setmetatable(proxy, {
            __index = function(_, key)
                if key == "__instance" then return instance end
                if key == "__isProxy" then return true end
                local v = instance[key]
                if type(v) == "function" then
                    return function(_, ...) return v(instance, ...) end
                end
                return v
            end,
            __newindex = function(_, key, value)
                instance[key] = value
            end,
            __metatable = "proxy",
        })
    end
end
return creator