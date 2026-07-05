local utility = {}
function utility.ProtectUI(inst)
    pcall(function()
        inst.ResetOnSpawn = false
        inst.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end)
    return inst
end
function utility.DeepCopy(t)
    local c = {}
    for k, v in pairs(t) do
        if type(v) == "table" then c[k] = utility.DeepCopy(v)
        else c[k] = v end
    end
    return c
end
function utility.Map(v, iMin, iMax, oMin, oMax)
    return (v - iMin) * (oMax - oMin) / (iMax - iMin) + oMin
end
return utility