local TweenService = game:GetService("TweenService")
local function map(v, iMin, iMax, oMin, oMax)
    return (v - iMin) * (oMax - oMin) / (iMax - iMin) + oMin
end
local function viewportPointToWorld(location, distance)
    local cam = workspace.CurrentCamera
    local unitRay = cam:ScreenPointToRay(location.X, location.Y)
    return unitRay.Origin + unitRay.Direction * distance
end
local function getOffset()
    local viewportSizeY = workspace.CurrentCamera.ViewportSize.Y
    return map(viewportSizeY, 0, 2560, 8, 56)
end
return function(frame, distance)
    distance = distance or 0.001
    local blurFolder = Instance.new("Folder", workspace.CurrentCamera)
    local connections = {}
    local triPositions = { topLeft = Vector2.new(), topRight = Vector2.new(), bottomRight = Vector2.new() }
    local part = Instance.new("Part")
    part.Color = Color3.new(0, 0, 0); part.Material = Enum.Material.Glass
    part.Size = Vector3.new(1, 1, 0); part.Anchored = true
    part.CanTouch = false; part.CanCollide = false; part.CanQuery = false
    part.Locked = true; part.CastShadow = false; part.Transparency = 0.98
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Brick; mesh.Offset = Vector3.new(0, 0, -0.000001); mesh.Parent = part
    local effect = Instance.new("DepthOfFieldEffect")
    effect.FarIntensity = 0; effect.NearIntensity = 1; effect.InFocusRadius = 0.1
    effect.Parent = game:GetService("Lighting")
    local function updatePositions(size, pos)
        triPositions.topLeft = pos; triPositions.topRight = pos + Vector2.new(size.X, 0)
        triPositions.bottomRight = pos + size
    end
    local function render()
        local cam = workspace.CurrentCamera; if not cam then return end
        local camCF = cam.CFrame
        local tl = viewportPointToWorld(triPositions.topLeft, distance)
        local tr = viewportPointToWorld(triPositions.topRight, distance)
        local br = viewportPointToWorld(triPositions.bottomRight, distance)
        local w = (tr - tl).Magnitude; local h = (tr - br).Magnitude
        part.CFrame = CFrame.fromMatrix((tl + br) / 2, camCF.XVector, camCF.YVector, camCF.ZVector)
        mesh.Scale = Vector3.new(w, h, 0)
    end
    local function onChange(rbx)
        local off = getOffset()
        local sz = rbx.AbsoluteSize - Vector2.new(off, off)
        local pos = rbx.AbsolutePosition + Vector2.new(off / 2, off / 2)
        updatePositions(sz, pos); task.spawn(render)
    end
    local function onCameraChange()
        local cam = workspace.CurrentCamera; if not cam then return end
        connections[#connections + 1] = cam:GetPropertyChangedSignal("CFrame"):Connect(render)
        connections[#connections + 1] = cam:GetPropertyChangedSignal("ViewportSize"):Connect(render)
        connections[#connections + 1] = cam:GetPropertyChangedSignal("FieldOfView"):Connect(render)
        task.spawn(render)
    end
    part.Parent = blurFolder
    part.Destroying:Connect(function()
        for _, c in connections do pcall(function() c:Disconnect() end) end
        pcall(function() effect:Destroy() end); pcall(function() blurFolder:Destroy() end)
    end)
    onCameraChange()
    frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() onChange(frame) end)
    frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() onChange(frame) end)
    frame.Destroying:Connect(function() part:Destroy() end)
    onChange(frame)
    return {
        Model = part,
        SetVisibility = function(v)
            TweenService:Create(part, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), { Transparency = v and 0.98 or 1 }):Play()
        end,
        SetIntensity = function(v) effect.InFocusRadius = v or 0.1 end,
    }
end