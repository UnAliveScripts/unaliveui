--[[
	UnaliveUI Figma Demo
	Load with: loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"))()
--]]

local T = game:GetService("TweenService")
local HS = game:GetService("HttpService")
local cam = workspace.CurrentCamera

-- Setup GUI
local gui = Instance.new("ScreenGui")
gui.Name = "UnaliveUIDemo"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 200
gui.IgnoreGuiInset = true
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Depth of Field
local dof
for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
	if v:IsA("DepthOfFieldEffect") and v:HasTag(".") then dof = v end
end
if not dof then
	dof = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
	dof.FarIntensity = 0; dof.NearIntensity = 1; dof.InFocusRadius = 0.1
	dof.Name = HS:GenerateGUID(true); dof:AddTag(".")
end

-- Blur function
local function blur(fr)
	local d = 0.001
	local bf = Instance.new("Folder", cam); bf.Name = HS:GenerateGUID(true)
	local cn = {}
	local tp = { topLeft = Vector2.new(), topRight = Vector2.new(), bottomRight = Vector2.new() }

	local pt = Instance.new("Part")
	pt.Color = Color3.new(0, 0, 0); pt.Material = Enum.Material.Glass
	pt.Size = Vector3.new(1, 1, 0); pt.Anchored = true
	pt.CanTouch = false; pt.CanCollide = false; pt.CanQuery = false
	pt.Locked = true; pt.CastShadow = false; pt.Transparency = 0.98
	local ms = Instance.new("SpecialMesh", pt)
	ms.MeshType = Enum.MeshType.Brick; ms.Offset = Vector3.new(0, 0, -0.000001)

	local function us(sz, po)
		tp.topLeft = po
		tp.topRight = po + Vector2.new(sz.X, 0)
		tp.bottomRight = po + sz
	end

	local function rn()
		local cm = workspace.CurrentCamera; if not cm then return end
		local ok1, tl = pcall(function() return cm:ScreenPointToRay(tp.topLeft.X, tp.topLeft.Y).Origin + cm.CFrame.LookVector * d end)
		local ok2, tr = pcall(function() return cm:ScreenPointToRay(tp.topRight.X, tp.topRight.Y).Origin + cm.CFrame.LookVector * d end)
		local ok3, br = pcall(function() return cm:ScreenPointToRay(tp.bottomRight.X, tp.bottomRight.Y).Origin + cm.CFrame.LookVector * d end)
		if not ok1 or not ok2 or not ok3 then return end
		pt.CFrame = CFrame.fromMatrix((tl + br) / 2, cm.CFrame.XVector, cm.CFrame.YVector, cm.CFrame.ZVector)
		ms.Scale = Vector3.new((tr - tl).magnitude, (tr - br).magnitude, 0)
	end

	local function oc(rx)
		us(rx.AbsoluteSize, rx.AbsolutePosition)
		task.spawn(rn)
	end

	pt.Parent = bf
	pt.Destroying:Connect(function()
		for _, c in cn do pcall(function() c:Disconnect() end) end
		pcall(function() bf:Destroy() end)
	end)

	local cm = workspace.CurrentCamera
	if cm then
		cn[#cn+1] = cm:GetPropertyChangedSignal("CFrame"):Connect(rn)
		cn[#cn+1] = cm:GetPropertyChangedSignal("ViewportSize"):Connect(rn)
		cn[#cn+1] = cm:GetPropertyChangedSignal("FieldOfView"):Connect(rn)
	end

	fr:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() oc(fr) end)
	fr:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() oc(fr) end)
	fr.Destroying:Connect(function() pt:Destroy() end)
	oc(fr); task.spawn(rn)
end

-- ============================================================================
-- WINDOW PILL (drag handle at top)
-- ============================================================================
local p = Instance.new("ImageButton", gui)
p.Name = "WindowPill"
p.AnchorPoint = Vector2.new(0.5, 0)
p.AutoButtonColor = false; p.BackgroundTransparency = 1; p.BorderSizePixel = 0
p.Image = "rbxassetid://93520763686656"
p.ImageTransparency = 0.5; p.ImageColor3 = Color3.fromRGB(245, 245, 245)
p.Position = UDim2.new(0.5, 0, 0, 10)
p.Size = UDim2.fromOffset(180, 5); p.ZIndex = 999
Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

local ti2 = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local ct = nil
p.MouseEnter:Connect(function()
	if ct then ct:Cancel() end
	ct = T:Create(p, ti2, { ImageTransparency = 0.15 }); ct:Play()
end)
p.MouseLeave:Connect(function()
	if ct then ct:Cancel() end
	ct = T:Create(p, ti2, { ImageTransparency = 0.5 }); ct:Play()
end)

-- ============================================================================
-- NOTIFICATION
-- ============================================================================
local n = Instance.new("Frame", gui)
n.Name = "Notification"
n.Size = UDim2.fromOffset(386, 64)
n.Position = UDim2.new(0.5, -193, 0.5, -128)
n.BackgroundTransparency = 1; n.BorderSizePixel = 0; n.ZIndex = 10
Instance.new("UICorner", n).CornerRadius = UDim.new(0, 24)

local ns = Instance.new("Frame", n)
ns.Size = UDim2.new(1, 4, 1, 4); ns.Position = UDim2.fromOffset(-2, -2)
ns.BackgroundColor3 = Color3.fromRGB(0, 0, 0); ns.BackgroundTransparency = 0.78
ns.BorderSizePixel = 0; ns.ZIndex = -1
Instance.new("UICorner", ns).CornerRadius = UDim.new(0, 24)

local nc = Instance.new("Frame", n)
nc.Size = UDim2.fromScale(1, 1)
nc.BackgroundColor3 = Color3.fromRGB(18, 20, 26); nc.BackgroundTransparency = 0.08
nc.BorderSizePixel = 0; nc.ZIndex = 1
Instance.new("UICorner", nc).CornerRadius = UDim.new(0, 24)

local nb = Instance.new("Frame", n)
nb.Size = UDim2.new(1, -24, 1, -24); nb.Position = UDim2.fromOffset(12, 12)
nb.BackgroundTransparency = 1; nb.BorderSizePixel = 0; nb.ZIndex = 0; blur(nb)

local ni = Instance.new("ImageLabel", n)
ni.Size = UDim2.fromOffset(38, 38); ni.Position = UDim2.fromOffset(14, 13)
ni.BackgroundTransparency = 1; ni.BorderSizePixel = 0
ni.Image = "rbxassetid://127922205331150"; ni.ZIndex = 3
Instance.new("UICorner", ni).CornerRadius = UDim.new(0, 10)

local nt = Instance.new("TextLabel", n)
nt.Size = UDim2.fromOffset(274, 17); nt.Position = UDim2.fromOffset(62, 12)
nt.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
nt.Text = "UnAlive"; nt.TextSize = 15; nt.TextColor3 = Color3.fromRGB(255, 255, 255)
nt.TextXAlignment = Enum.TextXAlignment.Left; nt.TextYAlignment = Enum.TextYAlignment.Top
nt.RichText = true; nt.BackgroundTransparency = 1; nt.BorderSizePixel = 0; nt.ZIndex = 3

local nd = Instance.new("TextLabel", n)
nd.Size = UDim2.fromOffset(274, 18); nd.Position = UDim2.fromOffset(62, 30)
nd.FontFace = Font.new("rbxassetid://12187365364")
nd.Text = "Welcome to UnAlive"; nd.TextSize = 15
nd.TextColor3 = Color3.fromRGB(180, 180, 190)
nd.TextXAlignment = Enum.TextXAlignment.Left; nd.TextYAlignment = Enum.TextYAlignment.Top
nd.RichText = true; nd.BackgroundTransparency = 1; nd.BorderSizePixel = 0; nd.ZIndex = 3

local nx = Instance.new("TextLabel", n)
nx.Size = UDim2.fromOffset(26, 17); nx.Position = UDim2.fromOffset(346, 12)
nx.FontFace = Font.new("rbxassetid://12187365364")
nx.Text = "now"; nx.TextSize = 13; nx.TextColor3 = Color3.fromRGB(140, 140, 150)
nx.TextXAlignment = Enum.TextXAlignment.Right; nx.TextYAlignment = Enum.TextYAlignment.Top
nx.BackgroundTransparency = 1; nx.BorderSizePixel = 0; nx.ZIndex = 3

n.Position = UDim2.new(0.5, -193, 0.5, -130)
T:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -193, 0.5, -120)
}):Play()

-- ============================================================================
-- EDIT MENU
-- ============================================================================
local m = Instance.new("Frame", gui)
m.Name = "EditMenu"
m.Size = UDim2.fromOffset(488, 44)
m.Position = UDim2.new(0.5, -244, 0.5, -22)
m.BackgroundTransparency = 1; m.BorderSizePixel = 0; m.ZIndex = 20
Instance.new("UICorner", m).CornerRadius = UDim.new(0, 34)

local ms = Instance.new("Frame", m)
ms.Size = UDim2.new(1, 4, 1, 4); ms.Position = UDim2.fromOffset(-2, -2)
ms.BackgroundColor3 = Color3.fromRGB(0, 0, 0); ms.BackgroundTransparency = 0.82
ms.BorderSizePixel = 0; ms.ZIndex = -1
Instance.new("UICorner", ms).CornerRadius = UDim.new(0, 34)

local mc2 = Instance.new("Frame", m)
mc2.Size = UDim2.fromScale(1, 1)
mc2.BackgroundColor3 = Color3.fromRGB(15, 17, 22); mc2.BackgroundTransparency = 0.08
mc2.BorderSizePixel = 0; mc2.ZIndex = 1
Instance.new("UICorner", mc2).CornerRadius = UDim.new(0, 34)

local mb = Instance.new("Frame", m)
mb.Size = UDim2.new(1, -34, 1, -34); mb.Position = UDim2.fromOffset(17, 17)
mb.BackgroundTransparency = 1; mb.BorderSizePixel = 0; mb.ZIndex = 0; blur(mb)

-- Edit menu content row
local mc = Instance.new("Frame", m)
mc.Size = UDim2.fromScale(1, 1); mc.BackgroundTransparency = 1
mc.BorderSizePixel = 0; mc.ZIndex = 3

local ml = Instance.new("UIListLayout", mc)
ml.FillDirection = Enum.FillDirection.Horizontal
ml.VerticalAlignment = Enum.VerticalAlignment.Center; ml.Padding = UDim.new(0, 0)
Instance.new("UIPadding", mc).PaddingLeft = UDim.new(0, 20)
Instance.new("UIPadding", mc).PaddingRight = UDim.new(0, 4)

local function addItem(t, w, tw, sep, dest)
	local a = Instance.new("Frame", mc)
	a.Size = UDim2.fromOffset(w, 18); a.BackgroundTransparency = 1; a.BorderSizePixel = 0

	if sep then
		local s = Instance.new("Frame", a)
		s.Size = UDim2.fromOffset(1, 18); s.Position = UDim2.fromOffset(0, 0)
		s.BackgroundColor3 = Color3.fromRGB(255, 255, 255); s.BackgroundTransparency = 0.8
		s.BorderSizePixel = 0
	end

	local l = Instance.new("TextLabel", a)
	l.Size = UDim2.fromOffset(tw, 18); l.Position = UDim2.fromOffset(sep and 17 or 0, 0)
	l.BackgroundTransparency = 1; l.BorderSizePixel = 0
	l.FontFace = Font.new("rbxassetid://12187365364")
	l.Text = t; l.TextSize = 15
	l.TextColor3 = dest and Color3.fromRGB(255, 66, 84) or Color3.fromRGB(245, 245, 245)
	l.TextXAlignment = Enum.TextXAlignment.Left

	return a, l
end

addItem("Farm", 50, 34, false, false)
addItem("Shop", 68, 35, true, false)
addItem("Steal", 67, 34, true, false)
addItem("Spawn", 78, 45, true, true)
addItem("Config", 77, 44, true, false)
addItem("Settings", 88, 55, true, false)

-- Indicator
local ind = Instance.new("Frame", m)
ind.Size = UDim2.fromOffset(36, 36); ind.Position = UDim2.fromOffset(448, 4)
ind.BackgroundColor3 = Color3.fromRGB(18, 18, 18); ind.BorderSizePixel = 0; ind.ZIndex = 6
Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

local ch = Instance.new("ImageLabel", ind)
ch.Size = UDim2.fromOffset(16, 16); ch.Position = UDim2.fromOffset(10, 10)
ch.BackgroundTransparency = 1; ch.BorderSizePixel = 0
ch.Image = "rbxassetid://103603118195781"
ch.ImageColor3 = Color3.fromRGB(245, 245, 245); ch.ScaleType = Enum.ScaleType.Fit

T:Create(m, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -244, 0.5, -22)
}):Play()

-- ============================================================================
-- ALERT
-- ============================================================================
local a = Instance.new("Frame", gui)
a.Name = "Alert"
a.Size = UDim2.fromOffset(260, 140)
a.Position = UDim2.new(0.5, -130, 0, 180)
a.BackgroundTransparency = 1; a.ZIndex = 100
Instance.new("UICorner", a).CornerRadius = UDim.new(0, 10)

local af = Instance.new("Frame", a)
af.Size = UDim2.fromScale(1, 1)
af.BackgroundColor3 = Color3.fromRGB(18, 20, 26); af.BackgroundTransparency = 0.08
af.BorderSizePixel = 0; af.ZIndex = 100
Instance.new("UICorner", af).CornerRadius = UDim.new(0, 26)

local as2 = Instance.new("Frame", a)
as2.Name = "Shadow"; as2.Size = UDim2.new(1, 4, 1, 4); as2.Position = UDim2.fromOffset(-2, -2)
as2.BackgroundColor3 = Color3.fromRGB(0, 0, 0); as2.BackgroundTransparency = 0.78
as2.BorderSizePixel = 0; as2.ZIndex = 98
Instance.new("UICorner", as2).CornerRadius = UDim.new(0, 26)

local ab = Instance.new("Frame", a)
ab.Size = UDim2.new(1, -20, 1, -20); ab.Position = UDim2.fromOffset(10, 10)
ab.BackgroundTransparency = 1; ab.BorderSizePixel = 0; ab.ZIndex = 99; blur(ab)

local aStroke = Instance.new("UIStroke", af)
aStroke.Color = Color3.fromRGB(255, 255, 255)
aStroke.Transparency = 0.88; aStroke.Thickness = 1

local at2 = Instance.new("TextLabel", a)
at2.Size = UDim2.fromOffset(216, 16); at2.Position = UDim2.fromOffset(22, 20)
at2.BackgroundTransparency = 1; at2.BorderSizePixel = 0
at2.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold)
at2.Text = "UnAlive"; at2.TextSize = 13; at2.TextColor3 = Color3.fromRGB(255, 255, 255)
at2.TextXAlignment = Enum.TextXAlignment.Left; at2.TextYAlignment = Enum.TextYAlignment.Center
at2.RichText = true; at2.ZIndex = 102

local ad2 = Instance.new("TextLabel", a)
ad2.Size = UDim2.fromOffset(216, 28); ad2.Position = UDim2.fromOffset(22, 46)
ad2.BackgroundTransparency = 1; ad2.BorderSizePixel = 0
ad2.FontFace = Font.new("rbxassetid://12187365364")
ad2.Text = "Your Items have been saved by Anti Stealer"
ad2.TextSize = 11; ad2.TextColor3 = Color3.fromRGB(180, 180, 190)
ad2.TextXAlignment = Enum.TextXAlignment.Left; ad2.TextYAlignment = Enum.TextYAlignment.Top
ad2.RichText = true; ad2.ZIndex = 102

local function mkB(x, t, s)
	local b = Instance.new("TextButton", a)
	b.AutoButtonColor = false; b.Size = UDim2.fromOffset(110, 32); b.Position = UDim2.fromOffset(x, 92)
	b.BackgroundTransparency = 1; b.BorderSizePixel = 0; b.Text = ""; b.ZIndex = 102
	Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

	local bg = Instance.new("Frame", b)
	bg.Size = UDim2.fromScale(1, 1); bg.BorderSizePixel = 0; bg.ZIndex = 101
	bg.BackgroundColor3 = s == "D" and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(230, 230, 230)
	bg.BackgroundTransparency = s == "D" and 0.77 or 0
	Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

	local l = Instance.new("TextLabel", b)
	l.Size = UDim2.fromScale(1, 1); l.BackgroundTransparency = 1; l.BorderSizePixel = 0
	l.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
	l.Text = t; l.TextSize = 13
	l.TextColor3 = s == "D" and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(0, 0, 0)
	l.TextXAlignment = Enum.TextXAlignment.Center; l.TextYAlignment = Enum.TextYAlignment.Center
	l.ZIndex = 102
end

mkB(16, "Turn OFF", "D")
mkB(134, "Keep On", "P")

a.Position = UDim2.new(0.5, -130, 0, 170)
T:Create(a, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -130, 0, 180)
}):Play()

-- ============================================================================
-- STEPPER (100×24, dark theme)
-- ============================================================================
local st = Instance.new("Frame", gui); st.Name = "Stepper"
st.Size = UDim2.fromOffset(100, 24); st.Position = UDim2.new(0.5, -50, 0, 150)
st.BackgroundColor3 = Color3.fromRGB(255, 255, 255); st.BackgroundTransparency = 0.9
st.BorderSizePixel = 0; st.ClipsDescendants = true; st.ZIndex = 50
Instance.new("UICorner", st).CornerRadius = UDim.new(0, 6)

local bg1 = Instance.new("Frame", st)
bg1.Size = UDim2.fromScale(1, 1)
bg1.BackgroundColor3 = Color3.fromRGB(18, 20, 26); bg1.BackgroundTransparency = 0.08
bg1.BorderSizePixel = 0; bg1.ZIndex = 1
Instance.new("UICorner", bg1).CornerRadius = UDim.new(0, 6)
local stStroke = Instance.new("UIStroke", bg1)
stStroke.Color = Color3.fromRGB(255, 255, 255); stStroke.Transparency = 0.85; stStroke.Thickness = 0.5

local val = 5000
local stLbl = Instance.new("TextLabel", st)
stLbl.Size = UDim2.fromOffset(76, 16); stLbl.Position = UDim2.fromOffset(8, 4)
stLbl.BackgroundTransparency = 1; stLbl.BorderSizePixel = 0
stLbl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
stLbl.Text = tostring(val); stLbl.TextSize = 13; stLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
stLbl.TextXAlignment = Enum.TextXAlignment.Left; stLbl.ZIndex = 2

-- Button area bg
local btnBg = Instance.new("Frame", st)
btnBg.Size = UDim2.fromOffset(20, 24); btnBg.Position = UDim2.fromOffset(80, 0)
btnBg.BackgroundColor3 = Color3.fromRGB(44, 44, 50); btnBg.BackgroundTransparency = 0
btnBg.BorderSizePixel = 0; btnBg.ZIndex = 1
local btnCorner = Instance.new("UICorner", btnBg); btnCorner.CornerRadius = UDim.new(0, 6)

-- Corner covers for btnBg (only right corners rounded)
local cv1 = Instance.new("Frame", btnBg)
cv1.Size = UDim2.fromOffset(6, 6); cv1.Position = UDim2.fromOffset(0, 0)
cv1.BackgroundColor3 = Color3.fromRGB(44, 44, 50); cv1.BackgroundTransparency = 0
cv1.BorderSizePixel = 0; cv1.ZIndex = 2
local cv2 = Instance.new("Frame", btnBg)
cv2.Size = UDim2.fromOffset(6, 6); cv2.Position = UDim2.fromOffset(0, 18)
cv2.BackgroundColor3 = Color3.fromRGB(44, 44, 50); cv2.BackgroundTransparency = 0
cv2.BorderSizePixel = 0; cv2.ZIndex = 2

local sep = Instance.new("Frame", st)
sep.Size = UDim2.fromOffset(14, 1); sep.Position = UDim2.fromOffset(83, 11.5)
sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255); sep.BackgroundTransparency = 0.85
sep.BorderSizePixel = 0; sep.ZIndex = 2

local upBtn = Instance.new("ImageButton", st)
upBtn.Size = UDim2.fromOffset(20, 12); upBtn.Position = UDim2.fromOffset(80, 0)
upBtn.BackgroundTransparency = 1; upBtn.BorderSizePixel = 0; upBtn.ZIndex = 3
local upIcon = Instance.new("ImageLabel", upBtn)
upIcon.Size = UDim2.fromOffset(14, 14); upIcon.Position = UDim2.fromOffset(3, -1)
upIcon.BackgroundTransparency = 1; upIcon.BorderSizePixel = 0
upIcon.Image = "rbxassetid://137296891812002"
upIcon.ImageColor3 = Color3.fromRGB(255, 255, 255); upIcon.ImageTransparency = 0.2
upBtn.MouseButton1Click:Connect(function() val = val + 500; stLbl.Text = tostring(val); print("Stepper:", val) end)

local downBtn = Instance.new("ImageButton", st)
downBtn.Size = UDim2.fromOffset(20, 12); downBtn.Position = UDim2.fromOffset(80, 12)
downBtn.BackgroundTransparency = 1; downBtn.BorderSizePixel = 0; downBtn.ZIndex = 3
local downIcon = Instance.new("ImageLabel", downBtn)
downIcon.Size = UDim2.fromOffset(14, 14); downIcon.Position = UDim2.fromOffset(3, -1)
downIcon.BackgroundTransparency = 1; downIcon.BorderSizePixel = 0
downIcon.Image = "rbxassetid://84215348315149"
downIcon.ImageColor3 = Color3.fromRGB(255, 255, 255); downIcon.ImageTransparency = 0.2
downBtn.MouseButton1Click:Connect(function() val = val - 500; stLbl.Text = tostring(val); print("Stepper:", val) end)

-- ============================================================================
-- STEPPER PILL (92×32 pill design)
-- ============================================================================
local sp = Instance.new("Frame", gui); sp.Name = "StepperPill"
sp.Size = UDim2.fromOffset(92, 32); sp.Position = UDim2.new(0.5, -46, 0, 440)
sp.BackgroundColor3 = Color3.fromRGB(18, 20, 26); sp.BackgroundTransparency = 0.08
sp.ClipsDescendants = true; sp.BorderSizePixel = 0; sp.ZIndex = 50
Instance.new("UICorner", sp).CornerRadius = UDim.new(0, 16)
local spStroke = Instance.new("UIStroke", sp)
spStroke.Color = Color3.fromRGB(255, 255, 255); spStroke.Transparency = 0.92; spStroke.Thickness = 0.5

local decBtn = Instance.new("ImageButton", sp)
decBtn.AutoButtonColor = false; decBtn.BackgroundTransparency = 1; decBtn.BorderSizePixel = 0
decBtn.Position = UDim2.fromOffset(0, 0); decBtn.Size = UDim2.fromOffset(46, 32); decBtn.ZIndex = 2
local di = Instance.new("ImageLabel", decBtn)
di.BackgroundTransparency = 1; di.BorderSizePixel = 0
di.Image = "rbxassetid://110147285593118"; di.ImageColor3 = Color3.fromRGB(255, 255, 255)
di.Size = UDim2.fromOffset(22, 22); di.Position = UDim2.fromOffset(12, 5)

local incBtn = Instance.new("ImageButton", sp)
incBtn.AutoButtonColor = false; incBtn.BackgroundTransparency = 1; incBtn.BorderSizePixel = 0
incBtn.Position = UDim2.fromOffset(46, 0); incBtn.Size = UDim2.fromOffset(46, 32); incBtn.ZIndex = 2
local ii = Instance.new("ImageLabel", incBtn)
ii.BackgroundTransparency = 1; ii.BorderSizePixel = 0
ii.Image = "rbxassetid://126761302820331"; ii.ImageColor3 = Color3.fromRGB(255, 255, 255)
ii.Size = UDim2.fromOffset(22, 22); ii.Position = UDim2.fromOffset(12, 5)

local spSep = Instance.new("Frame", sp)
spSep.Size = UDim2.fromOffset(1, 24); spSep.Position = UDim2.fromOffset(45.5, 4)
spSep.BackgroundColor3 = Color3.fromRGB(235, 235, 245); spSep.BackgroundTransparency = 0.7
spSep.BorderSizePixel = 0
Instance.new("UICorner", spSep).CornerRadius = UDim.new(0, 8)

local sv = 0
decBtn.MouseButton1Click:Connect(function() sv = sv - 1; print("Pill:", sv) end)
incBtn.MouseButton1Click:Connect(function() sv = sv + 1; print("Pill:", sv) end)

-- ============================================================================
-- PULLDOWN WITH MENU
-- ============================================================================
local pd = Instance.new("Frame", gui); pd.Name = "Pulldown"
pd.Size = UDim2.fromOffset(100, 260); pd.Position = UDim2.new(0.5, 150, 0, 80)
pd.BackgroundTransparency = 1; pd.ZIndex = 50

-- Button
local pb = Instance.new("TextButton", pd); pb.Name = "PullDownButton"
pb.Size = UDim2.fromOffset(100, 24); pb.Text = ""
pb.BackgroundColor3 = Color3.fromRGB(30, 32, 38); pb.BorderSizePixel = 0
pb.ZIndex = 51; pb.AutoButtonColor = false
Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 6)
local pbStroke = Instance.new("UIStroke", pb)
pbStroke.Color = Color3.fromRGB(255, 255, 255); pbStroke.Transparency = 0.85; pbStroke.Thickness = 0.5

local plbl = Instance.new("TextLabel", pb)
plbl.Size = UDim2.fromOffset(56, 24); plbl.Position = UDim2.fromOffset(12, 0)
plbl.BackgroundTransparency = 1; plbl.Font = Enum.Font.SourceSans
plbl.Text = "Pulldown1"; plbl.TextSize = 13; plbl.TextColor3 = Color3.fromRGB(255, 255, 255)
plbl.TextXAlignment = Enum.TextXAlignment.Left; plbl.TextYAlignment = Enum.TextYAlignment.Center

local pch = Instance.new("ImageLabel", pb)
pch.Size = UDim2.fromOffset(24, 24); pch.Position = UDim2.fromOffset(76, 0)
pch.BackgroundTransparency = 1; pch.Image = "rbxassetid://84215348315149"
pch.ImageColor3 = Color3.fromRGB(255, 255, 255); pch.Name = "Chevron"

-- Menu
local pm = Instance.new("Frame", pd); pm.Name = "Menu"
pm.Size = UDim2.fromOffset(95, 0); pm.Position = UDim2.fromOffset(0, 30)
pm.BackgroundColor3 = Color3.fromRGB(18, 20, 26); pm.BackgroundTransparency = 0.08
pm.BorderSizePixel = 0; pm.Visible = false; pm.ClipsDescendants = true; pm.ZIndex = 51
Instance.new("UICorner", pm).CornerRadius = UDim.new(0, 13)
local pmStroke = Instance.new("UIStroke", pm)
pmStroke.Color = Color3.fromRGB(255, 255, 255); pmStroke.Transparency = 0.88; pmStroke.Thickness = 0.5

local pg = Instance.new("Frame", pm)
pg.Size = UDim2.fromScale(1, 1)
pg.BackgroundColor3 = Color3.fromRGB(18, 20, 26); pg.BackgroundTransparency = 0.85
pg.BorderSizePixel = 0; pg.ZIndex = 51
Instance.new("UICorner", pg).CornerRadius = UDim.new(0, 13)

-- Scroller
local ps = Instance.new("ScrollingFrame", pm)
ps.Size = UDim2.new(1, -4, 1, 0); ps.Position = UDim2.fromOffset(2, 0)
ps.BackgroundTransparency = 1; ps.BorderSizePixel = 0; ps.ZIndex = 52
ps.ScrollBarThickness = 4; ps.ScrollBarImageColor3 = Color3.fromRGB(160, 160, 160)
ps.TopImage = "rbxasset://textures/ui/ScrollBar/top.png"
ps.MidImage = "rbxasset://textures/ui/ScrollBar/mid.png"
ps.BottomImage = "rbxasset://textures/ui/ScrollBar/bottom.png"
ps.ScrollingDirection = Enum.ScrollingDirection.Y
ps.ElasticBehavior = Enum.ElasticBehavior.Never; ps.ClipsDescendants = true

local pl = Instance.new("UIListLayout", ps)
pl.Padding = UDim.new(0, 0); pl.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", ps).PaddingTop = UDim.new(0, 5)

local function puc()
	ps.CanvasSize = UDim2.fromOffset(0, math.max(pl.AbsoluteContentSize.Y + 10, ps.AbsoluteSize.Y + 10))
end
pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(puc)

-- Menu items
local psel = nil
local pnames = { "Ice Serpent", "Black Dragon", "Raccoon", "Bald Eagle", "Bear", "Unicorn", "Golden Dragonfly", "Monkey", "Butterfly" }

for _, pn in pairs(pnames) do
	local psel2 = pn == "Black Dragon"
	local pi = Instance.new("TextButton", ps)
	pi.Size = UDim2.fromOffset(71, 24); pi.Text = ""; pi.AutoButtonColor = false
	pi.BackgroundTransparency = 1; pi.BorderSizePixel = 0; pi.ZIndex = 53

	local psb = Instance.new("Frame", pi)
	psb.Size = UDim2.fromOffset(85, 24); psb.Position = UDim2.fromOffset(-7, 0)
	psb.BackgroundColor3 = Color3.fromRGB(0, 136, 255)
	psb.BackgroundTransparency = psel2 and 0.2 or 1; psb.BorderSizePixel = 0; psb.ZIndex = 53
	Instance.new("UICorner", psb).CornerRadius = UDim.new(0, 8)

	local pnl = Instance.new("TextLabel", pi)
	pnl.Size = UDim2.fromOffset(71, 24); pnl.BackgroundTransparency = 1
	pnl.BorderSizePixel = 0; pnl.ZIndex = 54
	pnl.Font = Enum.Font.SourceSans; pnl.Text = pn; pnl.TextSize = 13
	pnl.TextColor3 = psel2 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(220, 220, 220)
	pnl.TextXAlignment = Enum.TextXAlignment.Left; pnl.TextYAlignment = Enum.TextYAlignment.Center

	if psel2 then psel = pnl end

	pi.MouseButton1Click:Connect(function()
		if psel and psel ~= pnl then
			psel.TextColor3 = Color3.fromRGB(220, 220, 220)
			local bg = psel.Parent:FindFirstChild("SelBg")
			if bg then bg.BackgroundTransparency = 1 end
		end
		if psel ~= pnl then
			pnl.TextColor3 = Color3.fromRGB(255, 255, 255)
			psb.BackgroundTransparency = 0.2; psel = pnl
		end
	end)
end
puc()

-- Toggle
local pis = false
local pti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

pb.MouseButton1Click:Connect(function()
	pis = not pis
	if pis then
		pm.Size = UDim2.fromOffset(95, 0); pm.Visible = true
		T:Create(pm, pti, { Size = UDim2.fromOffset(95, 226) }):Play()
		T:Create(pch, pti, { Rotation = 180 }):Play()
	else
		local t = T:Create(pm, pti, { Size = UDim2.fromOffset(95, 0) })
		t.Completed:Connect(function() pm.Visible = false end); t:Play()
		T:Create(pch, pti, { Rotation = 0 }):Play()
	end
end)

-- ============================================================================
-- TRAILING ACCESSORIES
-- ============================================================================
local ta = Instance.new("Frame", gui); ta.Name = "TrailingAccessories"
ta.Size = UDim2.fromOffset(60, 16); ta.Position = UDim2.new(0.5, 150, 0, 110)
ta.BackgroundTransparency = 1; ta.ZIndex = 50

local tal = Instance.new("TextLabel", ta)
tal.Size = UDim2.fromOffset(40, 16); tal.Position = UDim2.fromOffset(-1, 0)
tal.BackgroundTransparency = 1; tal.Font = Enum.Font.SourceSans
tal.Text = "Label"; tal.TextSize = 15
tal.TextColor3 = Color3.fromRGB(246, 246, 246); tal.TextTransparency = 0.16
tal.TextXAlignment = Enum.TextXAlignment.Right; tal.TextYAlignment = Enum.TextYAlignment.Center

local tai = Instance.new("ImageLabel", ta)
tai.Size = UDim2.fromOffset(16, 16); tai.Position = UDim2.fromOffset(44, 0)
tai.BackgroundTransparency = 1; tai.BorderSizePixel = 0
tai.Image = "rbxassetid://134900376381669"
tai.ImageColor3 = Color3.fromRGB(246, 246, 246); tai.ImageTransparency = 0.16

print("=== UnaliveUI Figma Demo ===")