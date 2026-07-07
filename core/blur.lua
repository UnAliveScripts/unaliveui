local TS = game:GetService("TweenService")
local function map(v, i1, i2, o1, o2) return (v - i1) * (o2 - o1) / (i2 - i1) + o1 end
local function toWorld(loc, dist) local c = workspace.CurrentCamera; local r = c:ScreenPointToRay(loc.X, loc.Y); return r.Origin + r.Direction * dist end
return function(frame, dist)
	dist = dist or 0.001; local bf = Instance.new("Folder", workspace.CurrentCamera); local cn = {}
	local tp = { topLeft = Vector2.new(), topRight = Vector2.new(), bottomRight = Vector2.new() }
	local pt = Instance.new("Part"); pt.Color = Color3.new(0, 0, 0); pt.Material = Enum.Material.Glass; pt.Size = Vector3.new(1, 1, 0); pt.Anchored = true; pt.CanTouch = false; pt.CanCollide = false; pt.CanQuery = false; pt.Locked = true; pt.CastShadow = false; pt.Transparency = 0.98
	local ms = Instance.new("SpecialMesh", pt); ms.MeshType = Enum.MeshType.Brick; ms.Offset = Vector3.new(0, 0, -0.000001)
	local ef = Instance.new("DepthOfFieldEffect", game:GetService("Lighting")); ef.FarIntensity = 0; ef.NearIntensity = 1; ef.InFocusRadius = 0.1
	local function up(sz, po) tp.topLeft = po; tp.topRight = po + Vector2.new(sz.X, 0); tp.bottomRight = po + sz end
	local function render() local c = workspace.CurrentCamera; if not c then return end; local tl = toWorld(tp.topLeft, dist); local tr = toWorld(tp.topRight, dist); local br = toWorld(tp.bottomRight, dist); pt.CFrame = CFrame.fromMatrix((tl + br) / 2, c.CFrame.XVector, c.CFrame.YVector, c.CFrame.ZVector); ms.Scale = Vector3.new((tr - tl).Magnitude, (tr - br).Magnitude, 0) end
	local function oc(rx) local off = map(workspace.CurrentCamera.ViewportSize.Y, 0, 2560, 8, 56); local sz = rx.AbsoluteSize - Vector2.new(off, off); local po = rx.AbsolutePosition + Vector2.new(off / 2, off / 2); up(sz, po); task.spawn(render) end
	pt.Parent = bf; pt.Destroying:Connect(function() for _, c in cn do pcall(function() c:Disconnect() end) end; pcall(function() ef:Destroy() end); pcall(function() bf:Destroy() end) end)
	local cm = workspace.CurrentCamera; if cm then cn[#cn+1] = cm:GetPropertyChangedSignal("CFrame"):Connect(render); cn[#cn+1] = cm:GetPropertyChangedSignal("ViewportSize"):Connect(render); cn[#cn+1] = cm:GetPropertyChangedSignal("FieldOfView"):Connect(render) end
	frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() oc(frame) end); frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() oc(frame) end); frame.Destroying:Connect(function() pt:Destroy() end); oc(frame); task.spawn(render)
	return { Model = pt, SetVisibility = function(v) TS:Create(pt, TweenInfo.new(0.3), { Transparency = v and 0.98 or 1 }):Play() end, SetIntensity = function(v) ef.InFocusRadius = v or 0.1 end }
end