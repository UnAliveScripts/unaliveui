local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Items = props.Items or {}
	local struct = { ItemButtons = {} }

	local body = C("Frame")({
		Name = "EditMenu",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(488, 44),
		AutomaticSize = Enum.AutomaticSize.XY,

		C("Frame")({
			Name = "FillShadow",
			BackgroundColor3 = Color3.fromRGB(204, 204, 204),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 0,

			C("UICorner")({ CornerRadius = UDim.new(0, 34) }),
		}),

		C("Frame")({
			Name = "Glass",
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.996,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 1,

			C("UICorner")({ CornerRadius = UDim.new(0, 34) }),

			C("UIStroke")({
				Name = "Border",
				Color = Color3.fromRGB(255, 255, 255),
				Transparency = 0.95,
				Thickness = 0.5,
			}),
		}),

		C("Frame")({
			Name = "Content",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,

			C("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 0),
			}),

			C("UIPadding")({
				PaddingLeft = UDim.new(0, 20),
				PaddingRight = UDim.new(0, 4),
			}),
		}),
	})

	local content = body.__instance:FindFirstChild("Content")

	for i, item in ipairs(props.Items) do
		if i > 1 then
			local sep = Instance.new("Frame")
			sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sep.BackgroundTransparency = 0.8
			sep.BorderSizePixel = 0
			sep.Size = UDim2.fromOffset(1, 18)
			sep.Parent = content
		end

		local a = Instance.new("Frame")
		a.BackgroundTransparency = 1
		a.BorderSizePixel = 0
		a.AutomaticSize = Enum.AutomaticSize.XY
		a.Name = "A" .. i
		a.Parent = content

		local t = Instance.new("TextLabel")
		t.BackgroundTransparency = 1
		t.BorderSizePixel = 0
		t.FontFace = Font.new("rbxassetid://12187365364")
		t.Text = item.Label
		t.TextSize = 15
		t.AutomaticSize = Enum.AutomaticSize.XY
		t.Size = UDim2.fromOffset(0, 18)
		t.Name = "L"
		t.TextColor3 = item.Destructive
			and Color3.fromRGB(255, 69, 88)
			or Color3.fromRGB(245, 245, 245)
		t.Parent = a

		local p = Instance.new("UIPadding")
		p.PaddingLeft = UDim.new(0, 16)
		p.PaddingRight = UDim.new(0, 16)
		p.Parent = a
	end

	local ind = Instance.new("Frame")
	ind.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	ind.BorderSizePixel = 0
	ind.Size = UDim2.fromOffset(36, 36)
	ind.Parent = content

	Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

	local it = Instance.new("TextLabel")
	it.BackgroundTransparency = 1
	it.BorderSizePixel = 0
	it.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	it.Text = "??"
	it.TextSize = 15
	it.TextColor3 = Color3.fromRGB(245, 245, 245)
	it.Size = UDim2.fromScale(1, 1)
	it.TextXAlignment = Enum.TextXAlignment.Center
	it.TextYAlignment = Enum.TextYAlignment.Center
	it.Parent = ind

	local obj = {
		Type = "EditMenu",
		Theme = self and self.Theme,
		Structures = struct,
		__instance = body.__instance,
	}

	function obj.Parent(p) body.Parent = p end
	return obj
end