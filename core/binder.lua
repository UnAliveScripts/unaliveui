local B = {}
function B.Apply(props, obj, excl)
    for k, v in pairs(props) do
        if excl and table.find(excl, k) then continue end
        pcall(function() obj[k] = v end)
    end
    return obj
end

function B.Wrap(obj, bindings, inst, excl)
    local p = {}
    setmetatable(p, {
        __index = function(_, k)
            if obj[k] ~= nil then return obj[k] end
            if inst then local ok, v = pcall(function() return inst[k] end); if ok then return v end end
            return nil
        end,
        __newindex = function(_, k, v)
            local h = bindings[k]
            if h then h(v); if not (excl and table.find(excl, k)) then obj[k] = v end
            elseif inst then local ok, _ = pcall(function() inst[k] = v end); if not ok then obj[k] = v end
            else obj[k] = v end
        end,
    })
    return p
end
return B