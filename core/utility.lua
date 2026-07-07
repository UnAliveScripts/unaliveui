local U = {}

function U.DeepCopy(t)
	local c = {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			c[k] = U.DeepCopy(v)
		else
			c[k] = v
		end
	end
	return c
end

function U.Map(v, i1, i2, o1, o2)
	return (v - i1) * (o2 - o1) / (i2 - i1) + o1
end

function U.Clamp(v, mn, mx)
	return math.max(mn, math.min(mx, v))
end

function U.ProtectUI(inst)
	pcall(function()
		inst.ResetOnSpawn = false
		inst.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	end)
	return inst
end

return U