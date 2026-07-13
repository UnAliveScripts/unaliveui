local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local function screenToWorld(camera, position, distance)
	local ray = camera:ScreenPointToRay(position.X, position.Y)
	return ray.Origin + ray.Direction * distance
end

return function(frame, distance)
	distance = distance or 0.001

	local folder = Instance.new("Folder")
	folder.Name = "BlurEffect"
	folder.Parent = workspace.CurrentCamera

	local connections = {}

	local glass = Instance.new("Part")
	glass.Color = Color3.fromRGB(0, 0, 0)
	glass.Material = Enum.Material.Glass
	glass.Size = Vector3.new(1, 1, 0)
	glass.Anchored = true
	glass.CanTouch = false
	glass.CanCollide = false
	glass.CanQuery = false
	glass.Locked = true
	glass.CastShadow = false
	glass.Transparency = 0.98
	glass.Parent = folder

	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Brick
	mesh.Offset = Vector3.new(0, 0, -0.000001)
	mesh.Parent = glass

	local depthOfField = Instance.new("DepthOfFieldEffect")
	depthOfField.FarIntensity = 0
	depthOfField.NearIntensity = 1
	depthOfField.InFocusRadius = 0.1
	depthOfField.Parent = Lighting

	local corners = {
		topLeft = Vector2.new(),
		topRight = Vector2.new(),
		bottomRight = Vector2.new(),
	}

	local function updateCorners(size, position)
		corners.topLeft = position
		corners.topRight = position + Vector2.new(size.X, 0)
		corners.bottomRight = position + size
	end

	local function render()
		local camera = workspace.CurrentCamera
		if not camera then return end

		local topLeft = screenToWorld(camera, corners.topLeft, distance)
		local topRight = screenToWorld(camera, corners.topRight, distance)
		local bottomRight = screenToWorld(camera, corners.bottomRight, distance)

		local center = (topLeft + bottomRight) / 2
		local xAxis = camera.CFrame.XVector
		local yAxis = camera.CFrame.YVector
		local zAxis = camera.CFrame.ZVector

		glass.CFrame = CFrame.fromMatrix(center, xAxis, yAxis, zAxis)
		mesh.Scale = Vector3.new(
			(topRight - topLeft).Magnitude,
			(topRight - bottomRight).Magnitude,
			0
		)
	end

	local function onResize(frameRef)
		local viewportSize = workspace.CurrentCamera.ViewportSize
		local offset = (viewportSize.Y / 2560) * 48 + 8
		local size = frameRef.AbsoluteSize - Vector2.new(offset, offset)
		local position = frameRef.AbsolutePosition + Vector2.new(offset / 2, offset / 2)
		updateCorners(size, position)
		task.spawn(render)
	end

	glass.Destroying:Connect(function()
		for _, connection in ipairs(connections) do
			pcall(function()
				connection:Disconnect()
			end)
		end
		pcall(function()
			depthOfField:Destroy()
		end)
		pcall(function()
			folder:Destroy()
		end)
	end)

	local camera = workspace.CurrentCamera
	if camera then
		table.insert(connections, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
		table.insert(connections, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
		table.insert(connections, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
	end

	frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		onResize(frame)
	end)
	frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		onResize(frame)
	end)

	frame.Destroying:Connect(function()
		glass:Destroy()
	end)

	onResize(frame)
	task.spawn(render)

	return {
		Model = glass,
		SetVisibility = function(visible)
			TweenService:Create(
				glass,
				TweenInfo.new(0.3),
				{ Transparency = visible and 0.98 or 1 }
			):Play()
		end,
		SetIntensity = function(intensity)
			depthOfField.InFocusRadius = intensity or 0.1
		end,
	}
end
