local binder = {}
function binder.Apply(props, target, excludes)
    for k, v in pairs(props) do
        if excludes and table.find(excludes, k) then continue end
        pcall(function() target[k] = v end)
    end
    return target
end
function binder.Wrap(props, bindings, instance, excludeKeys)
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, k)
            if props[k] ~= nil then return props[k] end
            if instance then
                local ok, v = pcall(function() return instance[k] end)
                if ok then return v end
            end
        end,
        __newindex = function(_, k, v)
            if bindings[k] then
                bindings[k](v)
                if not (excludeKeys and table.find(excludeKeys, k)) then
                    props[k] = v
                end
            elseif instance then
                local ok, _ = pcall(function() instance[k] = v end)
                if not ok then props[k] = v end
            else
                props[k] = v
            end
        end,
    })
    return proxy
end
return binder