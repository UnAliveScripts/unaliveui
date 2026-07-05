local C = {}

function C.Value(v)
    local cbs = {}
    local obj = { Value = v }
    function obj:Connect(fn) cbs[#cbs+1] = fn; return fn end
    function obj:Set(nv) v = nv; obj.Value = nv; for _, fn in cbs do pcall(fn, nv) end end
    return obj
end

function C.Create(cn)
    return function(props)
        props = props or {}
        local inst = Instance.new(cn)
        local dk = props.__dynamicKeys; props.__dynamicKeys = nil
        local ck = props.__contextKeys; props.__contextKeys = nil

        for k, v in pairs(props) do
            if typeof(v) == "table" and rawget(v, "__U") then v.Parent = inst
            else pcall(function() inst[k] = v end) end
        end

        if dk then
            for prop, vo in pairs(dk) do
                if type(vo) == "table" and vo.Value ~= nil and type(vo.Connect) == "function" then
                    pcall(function() inst[prop] = vo.Value end)
                    vo:Connect(function(nv)
                        if ck and ck[prop] then pcall(function() inst[prop] = ck[prop]() end)
                        else pcall(function() inst[prop] = nv end) end
                    end)
                end
            end
        end

        if ck then
            task.defer(function()
                for prop, fn in pairs(ck) do
                    if prop ~= "_general" then pcall(function() inst[prop] = fn() end) end
                end
            end)
        end

        return setmetatable({ __U = true }, {
            __metatable = inst,
            __index = function(_, k)
                if k == "__instance" then return inst end
                local v = inst[k]
                if typeof(v) == "function" then return function(_, ...) return v(inst, ...) end end
                return v
            end,
            __newindex = function(_, k, v) inst[k] = v end,
        })
    end
end

return C