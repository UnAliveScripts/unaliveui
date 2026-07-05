local binder = {}

function binder.Apply(properties, object, excludes)
    for property, value in pairs(properties) do
        if excludes and table.find(excludes, property) then
            continue
        end
        pcall(function() object[property] = value end)
    end
    return object
end

function binder.Wrap(object, bindings, instance, excludeSets)
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, key)
            if object[key] ~= nil then return object[key] end
            if instance then
                local ok, value = pcall(function() return instance[key] end)
                if ok then return value end
            end
            return nil
        end,
        __newindex = function(_, key, value)
            local handler = bindings[key]
            if handler then
                handler(value)
                if not (excludeSets and table.find(excludeSets, key)) then
                    object[key] = value
                end
            elseif instance then
                local ok, _ = pcall(function() instance[key] = value end)
                if not ok then object[key] = value end
            else
                object[key] = value
            end
        end,
    })
    return proxy
end

return binder