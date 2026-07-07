local services = {}
local tried = {}
setmetatable(services, {
	__index = function(_, k)
		if tried[k] then return nil end
		tried[k] = true
		local ok, sv = pcall(game.GetService, game, k)
		if ok then services[k] = sv; return sv end
	end,
})
return services