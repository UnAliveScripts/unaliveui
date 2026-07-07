local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Minimum = props.Minimum or 0
	props.Maximum = props.Maximum or 100
	props.Value = props.Value or 0

	local theme = self.Theme.Controls.Slider
	local parent = self.__container or self.__instance or self
	local struct = {}
	local dragging = false

	local body = C("Frame")({
		Name = "Slider",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 24),
		Parent = parent,
	})

	local track = C("Frame")({
		Name = "Track",
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, 10),
		Size = UDim2.new(1, 0, 0, 4),
		Parent = body.__instance,
		__dynamicKeys = { BackgroundColor3 = theme.Track[1], BackgroundTransparency = theme.Track[2] },
		C("UICorner")({ CornerRadius = UDim.new(0, 2) })
	})

	local fill = C("Frame")({
		Name = "Fill",
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(0, 4),
		Parent = body.__instance,
		__dynamicKeys = { BackgroundColor3 = theme.TrackFill },
		C("UICorner")({ CornerRadius = UDim.new(0, 2) })
	})

	local thumb = C("ImageButton")({
		Name = "Thumb",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, 2),
		Size = UDim2.fromOffset(20, 20),
		ZIndex = 2,
		Parent = body.__instance,
		__dynamicKeys = { ImageColor3 = theme.Thumb[1], ImageTransparency = theme.Thumb[2] },
		C("UICorner")({ CornerRadius = UDim.new(1, 0) }),
		C("UIStroke")({
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			__dynamicKeys = { Color = theme.ThumbStroke[1], Transparency = theme.ThumbStroke[2] }
		})
	})

	struct.Track = track.__instance
	struct.Fill = fill.__instance
	struct.Thumb = thumb.__instance

	local function setPos(val)
		local range = props.Maximum - props.Minimum
		if range <= 0 then return end

		local pct = (val - props.Minimum) / range
		local w = body.AbsoluteSize.X - 20
		local x = math.floor(pct * w)

		struct.Thumb.Position = UDim2.fromOffset(x, 2)
		struct.Fill.Size = UDim2.fromOffset(x + 10, 4)
	end

	struct.Thumb.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	struct.Thumb.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	struct.Thumb.InputChanged:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local w = body.AbsoluteSize.X - 20
			local x = math.clamp(i.Position.X - 10, 0, w)
			local pct = w > 0 and x / w or 0

			props.Value = props.Minimum + pct * (props.Maximum - props.Minimum)
			setPos(props.Value)

			if props.ValueChanged then
				task.spawn(props.ValueChanged, obj, props.Value)
			end
		end
	end)

	task.wait()
	setPos(props.Value)

	local obj = { Type = "Slider", Theme = self.Theme, Structures = struct, __instance = body.__instance }
	function obj:SetValue(v) props.Value = v; setPos(v) end
	return obj
end