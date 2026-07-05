local binder = {}
function binder.Apply(props, target, excludes)
    for k, v in pairs(props) do
        if excludes and table.find(excludes, k) then continue end
        pcall(function() target[k] = v end)
    end
    return target
end
return binder