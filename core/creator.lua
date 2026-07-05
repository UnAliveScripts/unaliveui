local creator = {}

function creator.Value(value)
    local callbacks = {}
    local obj = { Value = value }
    function obj:Connect(fn)
        table.insert(callbacks, fn)
        return fn
    end
    function obj:Set(newValue)
        value = newValue
        obj.Value = newValue
        for _, cb in callbacks do
            pcall(cb, newValue)
        end
    end
    return obj
end

function creator.Create(className)
    return function(properties)
        properties = properties or {}
        local instance = Instance.new(className)
        local children = {}
        local dynamicKeys = properties.__dynamicKeys
        local contextKeys = properties.__contextKeys
        properties.__dynamicKeys = nil
        properties.__contextKeys = nil

        for key, value in pairs(properties) do
            local isProxy = type(value) == "table" and type(rawget(value, "__isProxy")) == "boolean" and rawget(value, "__isProxy")
            if isProxy then
                table.insert(children, rawget(value, "__instance"))
            else
                pcall(function() instance[key] = value end)
            end
        end

        for _, child in ipairs(children) do
            pcall(function() child.Parent = instance end)
        end

        if dynamicKeys then
            for key, valueObj in pairs(dynamicKeys) do
                if type(valueObj) == "table" and valueObj.Value ~= nil and type(valueObj.Connect) == "function" then
                    pcall(function() instance[key] = valueObj.Value end)
                    valueObj:Connect(function(newVal)
                        pcall(function() instance[key] = newVal end)
                    end)
                end
            end
        end

        if contextKeys then
            local function updateContext()
                for key, fn in pairs(contextKeys) do
                    pcall(function() instance[key] = fn() end)
                end
            end
            updateContext()
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