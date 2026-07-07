--[[
	UnAliveUI — EditMenu Component
	
	Horizontal edit menu bar with items, separators, hover effects, and indicator.
	
	Usage:
		local em = UI.Components.EditMenu(UI, {
			Items = {
				{ Label = "Farm" },
				{ Label = "Shop" },
				{ Label = "Steal", Destructive = true },
			},
			OnSelected = function(item, i) print("Selected:", item.Label) end,
		})
		em.Parent(frame)
--]]

local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create
local blur = _G.__unaliveui_blur

return function(self, props)
	props = props or {}
	props.Items = props.Items or {}

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)
	local struct = {}

	local body = C("Frame")({
		Name = "EditMenu",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(488, 44),
		AutomaticSize = Enum.AutomaticSize.XY,

		-- Shadow
		C("Frame")({
			Name = "FillShadow",
			Size = UDim2.new(1, 4, 1, 4),
			Position = UDim2.fromOffset(-2, -2),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.82,
			BorderSizePixel = 0,
			ZIndex = -1,
			C("UICorner")({ CornerRadius = UDim.new(0, 34) }),
		}),

		-- Glass background
		C("Frame")({
			Name = "Glass",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = dark,
			BackgroundTransparency = 0.08,
			BorderSizePixel = 0,
			ZIndex = 1,
			C("UICorner")({ CornerRadius = UDim.new(0, 34) }),
			C("UIStroke")({
				Name = "Border",
				Color = white,
				Transparency = 0.88,
				Thickness = 1,
			}),
		}),

		-- Blur pane
		C("Frame")({
			Name = "BlurPane",
			Size = UDim2.new(1, -34, 1, -34),
			Position = UDim2.fromOffset(17, 17),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 0,
		}),

		-- Content
		C("Frame")({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 3,

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
	local blurPane = body.__instance:FindFirstChild("BlurPane")

	-- Apply blur
	if blur and blurPane then
		task.spawn(function()
			local b = blur(blurPane)
			struct.Blur = b
		end)
	end

	-- Create items
	for i, item in ipairs(props.Items) do
		if i > 1 then
			local sep = Instance.new("Frame")
			sep.BackgroundColor3 = white
			sep.BackgroundTransparency = 0.8
			sep.BorderSizePixel = 0
			sep.Size = UDim2.fromOffset(1, 18)
			sep.ZIndex = 3
			sep.Parent = content
		end

		local a = Instance.new("Frame")
		a.Size = UDim2.fromOffset(70, 18)
		a.BackgroundTransparency = 1
		a.BorderSizePixel = 0
		a.Name = "A" .. i
		a.Parent = content

		local t = Instance.new("TextLabel")
		t.Size = UDim2.fromScale(1, 1)
		t.BackgroundTransparency = 1
		t.BorderSizePixel = 0
		t.FontFace = Font.new("rbxassetid://12187365364")
		t.Text = item.Label
		t.TextSize = 15
		t.TextColor3 = item.Destructive
			and Color3.fromRGB(255, 66, 84)
			or Color3.fromRGB(245, 245, 245)
		t.TextXAlignment = Enum.TextXAlignment.Center
		t.TextYAlignment = Enum.TextYAlignment.Center
		t.ZIndex = 3
		t.Parent = a

		Instance.new("UIPadding", a).PaddingLeft = UDim.new(0, 16)
		Instance.new("UIPadding", a).PaddingRight = UDim.new(0, 16)

		-- Hitbox for hover + click
		local h = Instance.new("ImageButton")
		h.Name = "H"
		h.BackgroundTransparency = 1
		h.BorderSizePixel = 0
		h.Size = UDim2.fromScale(1, 1)
		h.ZIndex = 10
		h.Parent = a

		local hv = Instance.new("Frame")
		hv.Name = "HV"
		hv.Size = UDim2.fromScale(1, 1)
		hv.BackgroundColor3 = white
		hv.BackgroundTransparency = 1
		hv.BorderSizePixel = 0
		hv.ZIndex = 9
		hv.Parent = a

		Instance.new("UICorner", hv).CornerRadius = UDim.new(0, 6)

		h.MouseEnter:Connect(function()
			TS:Create(hv, TweenInfo.new(0.15), { BackgroundTransparency = 0.92 }):Play()
		end)

		h.MouseLeave:Connect(function()
			TS:Create(hv, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		end)

		h.MouseButton1Down:Connect(function()
			TS:Create(hv, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), {
				BackgroundTransparency = 0.85,
			}):Play()
		end)

		h.MouseButton1Up:Connect(function()
			TS:Create(hv, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()

			if props.OnSelected then
				props.OnSelected(item, i)
			end
		end)
	end

	-- Indicator
	local ind = Instance.new("Frame")
	ind.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	ind.BorderSizePixel = 0
	ind.Size = UDim2.fromOffset(36, 36)
	ind.Parent = content

	Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

	local ii = Instance.new("ImageLabel")
	ii.Size = UDim2.fromOffset(18, 18)
	ii.Position = UDim2.fromOffset(9, 9)
	ii.BackgroundTransparency = 1
	ii.BorderSizePixel = 0
	ii.Image = "rbxassetid://103603118195781"
	ii.ImageColor3 = Color3.fromRGB(245, 245, 245)
	ii.ScaleType = Enum.ScaleType.Fit
	ii.ZIndex = 3
	ii.Parent = ind

	local obj = {
		Type = "EditMenu",
		Theme = self and self.Theme,
		Structures = struct,
		__instance = body.__instance,
	}

	function obj.Parent(p) body.Parent = p end
	return obj
end