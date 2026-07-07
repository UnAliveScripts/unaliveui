local S = {}
local tried = {}

return setmetatable(S, {
	__index = function(_, k)
		if tried[k] then
			return nil
		end
		tried[k] = true

		local ok, sv = pcall(game.GetService, game, k)
		if ok then
			S[k] = sv
			return sv
		end
	end,
})