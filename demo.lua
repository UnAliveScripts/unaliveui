-- UnaliveUI Figma Demo
-- Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"))()

local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local camera = workspace.CurrentCamera
local icons = { UnAlivelogo = "rbxassetid://127922205331150" }

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui"); gui.Name = "UnaliveUIDemo"
gui.ResetOnSpawn = false; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 200; gui.IgnoreGuiInset = true; gui.Parent = playerGui

local function IsNotNaN(x) return x == x end
local MTREL = "Glass"; local wedgeguid = HS:GenerateGUID(true)
local root = Instance.new("Folder", camera); root.Name = HS:GenerateGUID(true)

local DepthOfField
for _,v in pairs(game:GetService("Lighting"):GetChildren()) do
    if not v:IsA("DepthOfFieldEffect") and v:HasTag(".") then
        DepthOfField = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
        DepthOfField.FarIntensity = 0; DepthOfField.NearIntensity = 1; DepthOfField.InFocusRadius = 0.1
        DepthOfField.Name = HS:GenerateGUID(true); DepthOfField:AddTag(".")
    elseif v:IsA("DepthOfFieldEffect") and v:HasTag(".") then DepthOfField = v end
end
if not DepthOfField then
    DepthOfField = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
    DepthOfField.FarIntensity = 0; DepthOfField.NearIntensity = 1; DepthOfField.InFocusRadius = 0.1
    DepthOfField.Name = HS:GenerateGUID(true); DepthOfField:AddTag(".")
end
while not IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x) do RS.RenderStepped:Wait() end

local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt; local sz = 0.2
local function DrawTriangle(v1, v2, v3, p0, p1)
    local s1 = (v1 - v2).magnitude; local s2 = (v2 - v3).magnitude; local s3 = (v3 - v1).magnitude
    local smax = max(s1, s2, s3); local A, B, C
    if s1 == smax then A, B, C = v1, v2, v3 elseif s2 == smax then A, B, C = v2, v3, v1 else A, B, C = v3, v1, v2 end
    local para = ((B-A).x*(C-A).x + (B-A).y*(C-A).y + (B-A).z*(C-A).z) / (A-B).magnitude
    local perp = sqrt((C-A).magnitude^2 - para*para); local dif_para = (A-B).magnitude - para
    local st = CFrame.new(B, A); local za = CFrame.Angles(pi/2,0,0); local cf0 = st; local TL = (cf0*za).lookVector
    local MP = A + CFrame.new(A,B).lookVector * para; local NL = CFrame.new(MP, C).lookVector
    local dot = TL.x*NL.x + TL.y*NL.y + TL.z*NL.z; local acv = CFrame.Angles(0,0,acos(dot)); cf0 = cf0*acv
    if ((cf0*za).lookVector - NL).magnitude > 0.01 then cf0 = cf0 * CFrame.Angles(0,0,-2*acos(dot)) end
    cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))
    local cf1 = st * acv * CFrame.Angles(0,pi,0)
    if ((cf1*za).lookVector - NL).magnitude > 0.01 then cf1 = cf1 * CFrame.Angles(0,0,2*acos(dot)) end
    cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)
    if not p0 then p0 = Instance.new("Part"); p0.FormFactor = "Custom"; p0.TopSurface = 0; p0.BottomSurface = 0
        p0.Anchored = true; p0.CanCollide = false; p0.CastShadow = false; p0.Material = MTREL
        p0.Size = Vector3.new(sz,sz,sz); p0.Name = HS:GenerateGUID(true)
        local m2 = Instance.new("SpecialMesh",p0); m2.MeshType = 2; m2.Name = wedgeguid end
    p0[wedgeguid].Scale = Vector3.new(0, perp/sz, para/sz); p0.CFrame = cf0
    if not p1 then p1 = p0:clone() end; p1[wedgeguid].Scale = Vector3.new(0, perp/sz, dif_para/sz); p1.CFrame = cf1
    return p0, p1
end
local function DrawQuad(v1,v2,v3,v4,pts) pts[1],pts[2]=DrawTriangle(v1,v2,v3,pts[1],pts[2]); pts[3],pts[4]=DrawTriangle(v3,v2,v4,pts[3],pts[4]) end

local function createBlur(frame)
    local dist = 0.001; local bf = Instance.new("Folder",camera); bf.Name=HS:GenerateGUID(true)
    local conn={}; local tp={topLeft=Vector2.new(),topRight=Vector2.new(),bottomRight=Vector2.new()}
    local pt=Instance.new("Part"); pt.Color=Color3.new(0,0,0); pt.Material=Enum.Material.Glass
    pt.Size=Vector3.new(1,1,0); pt.Anchored=true; pt.CanTouch=false; pt.CanCollide=false; pt.CanQuery=false
    pt.Locked=true; pt.CastShadow=false; pt.Transparency=0.98
    local mesh=Instance.new("SpecialMesh"); mesh.MeshType=Enum.MeshType.Brick; mesh.Offset=Vector3.new(0,0,-0.000001); mesh.Parent=pt
    local dof=Instance.new("DepthOfFieldEffect",game:GetService("Lighting"))
    dof.FarIntensity=0; dof.NearIntensity=1; dof.InFocusRadius=0.1
    local function ups(sz,pos) tp.topLeft=pos; tp.topRight=pos+Vector2.new(sz.X,0); tp.bottomRight=pos+sz end
    local function rnd()
        local cam=workspace.CurrentCamera; if not cam then return end
        local tl=cam:ScreenPointToRay(tp.topLeft.X,tp.topLeft.Y).Origin+cam.CFrame.LookVector*dist
        local tr=cam:ScreenPointToRay(tp.topRight.X,tp.topRight.Y).Origin+cam.CFrame.LookVector*dist
        local br=cam:ScreenPointToRay(tp.bottomRight.X,tp.bottomRight.Y).Origin+cam.CFrame.LookVector*dist
        local w=(tr-tl).Magnitude; local h=(tr-br).Magnitude
        pt.CFrame=CFrame.fromMatrix((tl+br)/2,cam.CFrame.XVector,cam.CFrame.YVector,cam.CFrame.ZVector)
        mesh.Scale=Vector3.new(w,h,0)
    end
    local function oc(rbx) local sz=rbx.AbsoluteSize; local pos=rbx.AbsolutePosition; ups(sz,pos); task.spawn(rnd) end
    pt.Parent=bf
    pt.Destroying:Connect(function() for _,c in conn do pcall(function() c:Disconnect() end) end; pcall(function() dof:Destroy() end); pcall(function() bf:Destroy() end) end)
    local cam=workspace.CurrentCamera
    if cam then conn[#conn+1]=cam:GetPropertyChangedSignal("CFrame"):Connect(rnd); conn[#conn+1]=cam:GetPropertyChangedSignal("ViewportSize"):Connect(rnd); conn[#conn+1]=cam:GetPropertyChangedSignal("FieldOfView"):Connect(rnd) end
    frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() oc(frame) end)
    frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() oc(frame) end)
    frame.Destroying:Connect(function() pt:Destroy() end); oc(frame); task.spawn(rnd)
end

-- WINDOW PILL (Cascade exact)
local pill = Instance.new("ImageButton"); pill.Name = "WindowPill"
pill.AnchorPoint = Vector2.new(0.5, 0); pill.AutoButtonColor = false
pill.BackgroundTransparency = 1; pill.BorderSizePixel = 0
pill.Image = "rbxassetid://93520763686656"; pill.ImageTransparency = 0.5
pill.ImageColor3 = Color3.fromRGB(245,245,245)
pill.Position = UDim2.new(0.5, 0, 0, 10); pill.Size = UDim2.fromOffset(180, 5)
pill.ZIndex = 999; pill.Parent = gui
local pcor = Instance.new("UICorner"); pcor.CornerRadius = UDim.new(1,0); pcor.Parent = pill
local ti = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local ct = nil
pill.MouseEnter:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,ti,{ImageTransparency=0.15}); ct:Play() end)
pill.MouseLeave:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,ti,{ImageTransparency=0.5}); ct:Play() end)

-- NOTIFICATION
local n = Instance.new("Frame"); n.Name = "Notification"
n.Size = UDim2.fromOffset(386, 64); n.Position = UDim2.new(0.5,-193,0.5,-128)
n.BackgroundTransparency = 1; n.BorderSizePixel = 0; n.ZIndex = 10; n.Parent = gui
local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 24); nc.Parent = n

local sh = Instance.new("Frame"); sh.Name = "Shadow"
sh.Size = UDim2.new(1, 4, 1, 4); sh.Position = UDim2.fromOffset(-2, -2)
sh.BackgroundColor3 = Color3.fromRGB(0,0,0); sh.BackgroundTransparency = 0.78
sh.BorderSizePixel = 0; sh.ZIndex = -1; sh.Parent = n
local shc = Instance.new("UICorner"); shc.CornerRadius = UDim.new(0, 24); shc.Parent = sh

local cv = Instance.new("Frame"); cv.Size = UDim2.fromScale(1,1)
cv.BackgroundColor3 = Color3.fromRGB(18,20,26); cv.BackgroundTransparency = 0.08
cv.BorderSizePixel = 0; cv.ZIndex = 1; cv.Parent = n
local cvc = Instance.new("UICorner"); cvc.CornerRadius = UDim.new(0, 24); cvc.Parent = cv

local bf = Instance.new("Frame"); bf.Size = UDim2.new(1,-24,1,-24)
bf.Position = UDim2.fromOffset(12,12); bf.BackgroundTransparency = 1
bf.BorderSizePixel = 0; bf.ZIndex = 0; bf.Parent = n
local bfc = Instance.new("UICorner"); bfc.CornerRadius = UDim.new(0,24); bfc.Parent = bf; createBlur(bf)

local icon = Instance.new("ImageLabel"); icon.Size = UDim2.fromOffset(38,38); icon.Position = UDim2.fromOffset(14,13)
icon.BackgroundTransparency = 1; icon.BorderSizePixel = 0; icon.Image = icons.UnAlivelogo; icon.ZIndex = 3; icon.Parent = n
local icr = Instance.new("UICorner"); icr.CornerRadius = UDim.new(0,10); icr.Parent = icon

local title = Instance.new("TextLabel"); title.Size = UDim2.fromOffset(274,17); title.Position = UDim2.fromOffset(62,12)
title.BackgroundTransparency = 1; title.BorderSizePixel = 0
title.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold)
title.Text = "UnAlive"; title.TextSize = 15; title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left; title.TextYAlignment = Enum.TextYAlignment.Top; title.RichText = true; title.ZIndex = 3; title.Parent = n

local desc = Instance.new("TextLabel"); desc.Size = UDim2.fromOffset(274,18); desc.Position = UDim2.fromOffset(62,30)
desc.BackgroundTransparency = 1; desc.BorderSizePixel = 0; desc.FontFace = Font.new("rbxassetid://12187365364")
desc.Text = "Welcome to UnAlive"; desc.TextSize = 15; desc.TextColor3 = Color3.fromRGB(180,180,190)
desc.TextXAlignment = Enum.TextXAlignment.Left; desc.TextYAlignment = Enum.TextYAlignment.Top; desc.RichText = true; desc.ZIndex = 3; desc.Parent = n

local tx = Instance.new("TextLabel"); tx.Size = UDim2.fromOffset(26,17); tx.Position = UDim2.fromOffset(346,12)
tx.BackgroundTransparency = 1; tx.BorderSizePixel = 0; tx.FontFace = Font.new("rbxassetid://12187365364")
tx.Text = "now"; tx.TextSize = 13; tx.TextColor3 = Color3.fromRGB(140,140,150); tx.ZIndex = 3
tx.TextXAlignment = Enum.TextXAlignment.Right; tx.TextYAlignment = Enum.TextYAlignment.Top; tx.Parent = n

n.Position = UDim2.new(0.5,-193,0.5,-130)
TS:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(0.5,-193,0.5,-120) }):Play()

-- EDIT MENU
local m = Instance.new("Frame"); m.Name = "EditMenu"
m.Size = UDim2.fromOffset(488,44); m.Position = UDim2.new(0.5,-244,0.5,-22)
m.BackgroundTransparency = 1; m.BorderSizePixel = 0; m.ZIndex = 20; m.Parent = gui
local mc2 = Instance.new("UICorner"); mc2.CornerRadius = UDim.new(0,34); mc2.Parent = m

local sh2 = Instance.new("Frame"); sh2.Name = "Shadow"
sh2.Size = UDim2.new(1,4,1,4); sh2.Position = UDim2.fromOffset(-2,-2)
sh2.BackgroundColor3 = Color3.fromRGB(0,0,0); sh2.BackgroundTransparency = 0.82
sh2.BorderSizePixel = 0; sh2.ZIndex = -1; sh2.Parent = m
local sh2c = Instance.new("UICorner"); sh2c.CornerRadius = UDim.new(0,34); sh2c.Parent = sh2

local c2 = Instance.new("Frame"); c2.Size = UDim2.fromScale(1,1)
c2.BackgroundColor3 = Color3.fromRGB(15,17,22); c2.BackgroundTransparency = 0.08
c2.BorderSizePixel = 0; c2.ZIndex = 1; c2.Parent = m
local c2c = Instance.new("UICorner"); c2c.CornerRadius = UDim.new(0,34); c2c.Parent = c2

local bf2 = Instance.new("Frame"); bf2.Size = UDim2.new(1,-34,1,-34)
bf2.Position = UDim2.fromOffset(17,17); bf2.BackgroundTransparency = 1
bf2.BorderSizePixel = 0; bf2.ZIndex = 0; bf2.Parent = m
local bf2c = Instance.new("UICorner"); bf2c.CornerRadius = UDim.new(0,34); bf2c.Parent = bf2; createBlur(bf2)

local mc = Instance.new("Frame"); mc.Size = UDim2.fromScale(1,1); mc.BackgroundTransparency = 1; mc.BorderSizePixel = 0; mc.ZIndex = 3; mc.Parent = m
local ml = Instance.new("UIListLayout"); ml.FillDirection = Enum.FillDirection.Horizontal; ml.VerticalAlignment = Enum.VerticalAlignment.Center; ml.Padding = UDim.new(0,0); ml.Parent = mc
local mp = Instance.new("UIPadding"); mp.PaddingLeft = UDim.new(0,20); mp.PaddingRight = UDim.new(0,4); mp.Parent = mc

local items = {{Label="Farm"},{Label="Shop"},{Label="Steal"},{Label="Spawn",Destructive=true},{Label="Config"},{Label="Settings"}}
local dc = Color3.fromRGB(255,66,84); local nc2 = Color3.fromRGB(245,245,245)
for i, item in ipairs(items) do
    if i>1 then local sp=Instance.new("Frame"); sp.Size=UDim2.fromOffset(1,18); sp.BackgroundColor3=Color3.fromRGB(255,255,255); sp.BackgroundTransparency=0.8; sp.BorderSizePixel=0; sp.Parent=mc end
    local a=Instance.new("Frame"); a.BackgroundTransparency=1; a.BorderSizePixel=0; a.AutomaticSize=Enum.AutomaticSize.XY; a.Parent=mc
    local txl=Instance.new("TextLabel"); txl.BackgroundTransparency=1; txl.BorderSizePixel=0; txl.FontFace=Font.new("rbxassetid://12187365364"); txl.Text=item.Label; txl.TextSize=15; txl.TextColor3=item.Destructive and dc or nc2; txl.AutomaticSize=Enum.AutomaticSize.XY; txl.Size=UDim2.fromOffset(0,18); txl.Parent=a
    local ap=Instance.new("UIPadding"); ap.PaddingLeft=UDim.new(0,16); ap.PaddingRight=UDim.new(0,16); ap.Parent=a
end

local ind = Instance.new("Frame"); ind.Size = UDim2.fromOffset(36,36)
ind.BackgroundColor3 = Color3.fromRGB(18,18,18); ind.BorderSizePixel = 0; ind.Parent = mc
local ic2 = Instance.new("UICorner"); ic2.CornerRadius = UDim.new(1,0); ic2.Parent = ind

local ch = Instance.new("ImageLabel")
ch.Size = UDim2.fromOffset(26,26); ch.Position = UDim2.fromOffset(7,5)
ch.BackgroundTransparency = 1; ch.BorderSizePixel = 0
ch.Image = "rbxassetid://103603118195781"; ch.ImageColor3 = Color3.fromRGB(245,245,245)
ch.ScaleType = Enum.ScaleType.Fit; ch.Parent = ind

TS:Create(m, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(0.5,-244,0.5,-22) }):Play()
print("=== UnaliveUI Final Demo ===")
return { Notification = n, EditMenu = m }