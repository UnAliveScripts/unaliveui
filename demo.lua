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
gui.DisplayOrder = 200; gui.Parent = playerGui

-- BLUR
local MTREL = "Glass"; local wedgeguid = HS:GenerateGUID(true)
local root = Instance.new("Folder", camera); root.Name = HS:GenerateGUID(true)
local DepthOfField
for _,v in pairs(game:GetService("Lighting"):GetChildren()) do
    if not v:IsA("DepthOfFieldEffect") and v:HasTag(".") then
        DepthOfField = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
        DepthOfField.FarIntensity = 0; DepthOfField.FocusDistance = 51.6; DepthOfField.InFocusRadius = 50
        DepthOfField.NearIntensity = 1; DepthOfField.Name = HS:GenerateGUID(true); DepthOfField:AddTag(".")
    elseif v:IsA("DepthOfFieldEffect") and v:HasTag(".") then DepthOfField = v end
end
if not DepthOfField then
    DepthOfField = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
    DepthOfField.FarIntensity = 0; DepthOfField.FocusDistance = 51.6; DepthOfField.InFocusRadius = 50
    DepthOfField.NearIntensity = 1; DepthOfField.Name = HS:GenerateGUID(true); DepthOfField:AddTag(".")
end
while not IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x) do RS.RenderStepped:Wait() end
local function IsNotNaN(x) return x == x end

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
local function applyBlur(fo)
    local pts={}; local f=Instance.new("Folder",root); f.Name=HS:GenerateGUID(true)
    local pars={}; (function() local function ad(c) if c:IsA("GuiObject") then table.insert(pars,c); ad(c.Parent) end end; ad(fo) end)()
    local function vis(i) while i do if i:IsA("GuiObject") and not i.Visible then return false end; if i:IsA("ScreenGui") and not i.Enabled then return false end; i=i.Parent end; return true end
    local function up(fp)
        if not vis(fo) then for _,pt in pairs(pts) do pt.Parent=nil end; return end
        local tl,br = fo.AbsolutePosition, fo.AbsolutePosition+fo.AbsoluteSize; local tr,bl = Vector2.new(br.x,tl.y), Vector2.new(tl.x,br.y); local rot=0
        for _,v in ipairs(pars) do rot=rot+v.Rotation end
        if rot~=0 and rot%180~=0 then local mid=tl:lerp(br,0.5); local s,c2=math.sin(math.rad(rot)),math.cos(math.rad(rot))
            tl=Vector2.new(c2*(tl.x-mid.x)-s*(tl.y-mid.y),s*(tl.x-mid.x)+c2*(tl.y-mid.y))+mid; tr=Vector2.new(c2*(tr.x-mid.x)-s*(tr.y-mid.y),s*(tr.x-mid.x)+c2*(tr.y-mid.y))+mid; bl=Vector2.new(c2*(bl.x-mid.x)-s*(bl.y-mid.y),s*(bl.x-mid.x)+c2*(bl.y-mid.y))+mid; br=Vector2.new(c2*(br.x-mid.x)-s*(br.y-mid.y),s*(br.x-mid.x)+c2*(br.y-mid.y))+mid end
        local z=1-0.05*fo.ZIndex
        DrawQuad(camera:ScreenPointToRay(tl.x,tl.y,z).Origin,camera:ScreenPointToRay(tr.x,tr.y,z).Origin,camera:ScreenPointToRay(bl.x,bl.y,z).Origin,camera:ScreenPointToRay(br.x,br.y,z).Origin,pts)
        if fp then for _,pt in pairs(pts) do pt.Parent=f end; for _,pt in pairs(pts) do pt.Transparency=0.98; pt.BrickColor=BrickColor.new("Institutional white") end end
    end; up(true); RS:BindToRenderStep(HS:GenerateGUID(true),2000,up); return f
end

-- NOTIFICATION
local n = Instance.new("Frame"); n.Name = "Notification"
n.Size = UDim2.fromOffset(386, 64); n.Position = UDim2.new(0.5,-193,0.5,-120)
n.BackgroundTransparency = 1; n.ClipsDescendants = true; n.BorderSizePixel = 0; n.ZIndex = 10; n.Parent = gui
local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 24); nc.Parent = n

-- Shadow y=8
local sh = Instance.new("Frame"); sh.Size = UDim2.fromScale(1,1); sh.Position = UDim2.fromOffset(0,8)
sh.BackgroundColor3 = Color3.fromRGB(0,0,0); sh.BackgroundTransparency = 0.75; sh.BorderSizePixel = 0; sh.ZIndex = -1; sh.Parent = n
local shc = Instance.new("UICorner"); shc.CornerRadius = UDim.new(0, 24); shc.Parent = sh

-- Dark base
local db = Instance.new("Frame"); db.Size = UDim2.fromScale(1,1)
db.BackgroundColor3 = Color3.fromRGB(12,14,20); db.BackgroundTransparency = 0.35
db.BorderSizePixel = 0; db.ZIndex = 1; db.Parent = n
local dbc = Instance.new("UICorner"); dbc.CornerRadius = UDim.new(0, 24); dbc.Parent = db

-- Glass SCREEN 7%
local g = Instance.new("Frame"); g.Size = UDim2.fromScale(1,1)
g.BackgroundColor3 = Color3.fromRGB(255,255,255); g.BackgroundTransparency = 0.93
g.BorderSizePixel = 0; g.ZIndex = 2; g.Parent = n
local gc = Instance.new("UICorner"); gc.CornerRadius = UDim.new(0, 24); gc.Parent = g

-- **FIGMA: strokeWeight=6.44 INSIDE (thick white border)**
local gs = Instance.new("UIStroke")
gs.Color = Color3.fromRGB(255,255,255); gs.Transparency = 0.82
gs.Thickness = 6; gs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; gs.Parent = g

-- Blur exact size
local bf = Instance.new("Frame"); bf.Size = UDim2.fromScale(1,1)
bf.BackgroundTransparency = 1; bf.BorderSizePixel = 0; bf.ZIndex = 0; bf.Parent = n; applyBlur(bf)

-- Content auto-layout
local ct = Instance.new("Frame"); ct.Size = UDim2.fromScale(1,1)
ct.BackgroundTransparency = 1; ct.BorderSizePixel = 0; ct.ZIndex = 4; ct.Parent = n
local hl = Instance.new("UIListLayout")
hl.FillDirection = Enum.FillDirection.Horizontal; hl.VerticalAlignment = Enum.VerticalAlignment.Center
hl.Padding = UDim.new(0,10); hl.Parent = ct
local hp = Instance.new("UIPadding")
hp.PaddingLeft = UDim.new(0,14); hp.PaddingRight = UDim.new(0,14)
hp.PaddingTop = UDim.new(0,12); hp.PaddingBottom = UDim.new(0,12); hp.Parent = ct

local icon = Instance.new("ImageLabel"); icon.Size = UDim2.fromOffset(38,38)
icon.BackgroundTransparency = 1; icon.BorderSizePixel = 0; icon.Image = icons.UnAlivelogo
icon.LayoutOrder = 1; icon.Parent = ct
local icr = Instance.new("UICorner"); icr.CornerRadius = UDim.new(0,10); icr.Parent = icon

local ttf = Instance.new("Frame"); ttf.BackgroundTransparency = 1; ttf.BorderSizePixel = 0
ttf.Size = UDim2.new(1,-48,1,0); ttf.LayoutOrder = 2; ttf.Parent = ct
local ttl = Instance.new("UIListLayout")
ttl.FillDirection = Enum.FillDirection.Horizontal; ttl.VerticalAlignment = Enum.VerticalAlignment.Top
ttl.Padding = UDim.new(0,10); ttl.Parent = ttf

local ts = Instance.new("Frame"); ts.BackgroundTransparency = 1; ts.BorderSizePixel = 0
ts.Size = UDim2.new(1,-50,0,38); ts.LayoutOrder = 1; ts.Parent = ttf
local tsl = Instance.new("UIListLayout")
tsl.FillDirection = Enum.FillDirection.Vertical; tsl.VerticalAlignment = Enum.VerticalAlignment.Center; tsl.Parent = ts

local title = Instance.new("TextLabel"); title.Size = UDim2.new(1,0,0,17)
title.BackgroundTransparency = 1; title.BorderSizePixel = 0
title.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold)
title.Text = "UnAlive"; title.TextSize = 15; title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left; title.TextYAlignment = Enum.TextYAlignment.Center
title.RichText = true; title.Parent = ts

local desc = Instance.new("TextLabel"); desc.Size = UDim2.new(1,0,0,18)
desc.BackgroundTransparency = 1; desc.BorderSizePixel = 0
desc.FontFace = Font.new("rbxassetid://12187365364")
desc.Text = "Welcome to UnAlive"; desc.TextSize = 15
desc.TextColor3 = Color3.fromRGB(200,200,210)
desc.TextXAlignment = Enum.TextXAlignment.Left; desc.TextYAlignment = Enum.TextYAlignment.Center
desc.RichText = true; desc.Parent = ts

local tf = Instance.new("Frame"); tf.BackgroundTransparency = 1; tf.BorderSizePixel = 0
tf.Size = UDim2.fromOffset(40,20); tf.LayoutOrder = 2; tf.Parent = ttf
local tx = Instance.new("TextLabel"); tx.Size = UDim2.fromScale(1,1)
tx.BackgroundTransparency = 1; tx.BorderSizePixel = 0
tx.FontFace = Font.new("rbxassetid://12187365364"); tx.Text = "now"; tx.TextSize = 13
tx.TextColor3 = Color3.fromRGB(140,140,150)
tx.TextXAlignment = Enum.TextXAlignment.Right; tx.TextYAlignment = Enum.TextYAlignment.Top; tx.Parent = tf

n.Position = UDim2.new(0.5,-193,0.5,-128)
TS:Create(n, TweenInfo.new(0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Position = UDim2.new(0.5,-193,0.5,-120) }):Play()

-- EDIT MENU
local m = Instance.new("Frame"); m.Name = "EditMenu"; m.Size = UDim2.fromOffset(488,44)
m.Position = UDim2.new(0.5,-244,0.5,-22); m.BackgroundTransparency = 1
m.ClipsDescendants = true; m.BorderSizePixel = 0; m.ZIndex = 20; m.Parent = gui
local mc2 = Instance.new("UICorner"); mc2.CornerRadius = UDim.new(0, 34); mc2.Parent = m

local msh = Instance.new("Frame"); msh.Size = UDim2.fromScale(1,1)
msh.Position = UDim2.fromOffset(0,8)
msh.BackgroundColor3 = Color3.fromRGB(0,0,0); msh.BackgroundTransparency = 0.82
msh.BorderSizePixel = 0; msh.ZIndex = -1; msh.Parent = m
local mshc = Instance.new("UICorner"); mshc.CornerRadius = UDim.new(0, 34); mshc.Parent = msh

local f1 = Instance.new("Frame"); f1.Size = UDim2.fromScale(1,1)
f1.BackgroundColor3 = Color3.fromRGB(204,204,204); f1.BackgroundTransparency = 0.33
f1.BorderSizePixel = 0; f1.ZIndex = 1; f1.Parent = m
local fc1 = Instance.new("UICorner"); fc1.CornerRadius = UDim.new(0, 34); fc1.Parent = f1

local f2 = Instance.new("Frame"); f2.Size = UDim2.fromScale(1,1)
f2.BackgroundColor3 = Color3.fromRGB(0,0,0); f2.BackgroundTransparency = 0.4
f2.BorderSizePixel = 0; f2.ZIndex = 1; f2.Parent = m
local fc2 = Instance.new("UICorner"); fc2.CornerRadius = UDim.new(0, 34); fc2.Parent = f2

local ge = Instance.new("Frame"); ge.Size = UDim2.fromScale(1,1)
ge.BackgroundColor3 = Color3.fromRGB(0,0,0); ge.BackgroundTransparency = 0.996
ge.BorderSizePixel = 0; ge.ZIndex = 1; ge.Parent = m
local gec = Instance.new("UICorner"); gec.CornerRadius = UDim.new(0, 34); gec.Parent = ge
local gb = Instance.new("UIStroke")
gb.Color = Color3.fromRGB(0,0,0); gb.Transparency = 0.9
gb.Thickness = 6; gb.Parent = ge

local bf2 = Instance.new("Frame"); bf2.Size = UDim2.fromScale(1,1)
bf2.BackgroundTransparency = 1; bf2.BorderSizePixel = 0; bf2.ZIndex = 0; bf2.Parent = m; applyBlur(bf2)

local mc = Instance.new("Frame"); mc.Size = UDim2.fromScale(1,1)
mc.BackgroundTransparency = 1; mc.BorderSizePixel = 0; mc.ZIndex = 3; mc.Parent = m
local ml = Instance.new("UIListLayout")
ml.FillDirection = Enum.FillDirection.Horizontal; ml.VerticalAlignment = Enum.VerticalAlignment.Center
ml.Padding = UDim.new(0,0); ml.Parent = mc
local mp = Instance.new("UIPadding")
mp.PaddingLeft = UDim.new(0,20); mp.PaddingRight = UDim.new(0,4); mp.Parent = mc

local items = {{Label="Farm"},{Label="Shop"},{Label="Steal"},{Label="Spawn",Destructive=true},{Label="Config"},{Label="Settings"}}
local dc = Color3.fromRGB(255,66,84); local nc2 = Color3.fromRGB(245,245,245)
for i, item in ipairs(items) do
    if i>1 then local sp=Instance.new("Frame"); sp.Size=UDim2.fromOffset(1,18); sp.BackgroundColor3=Color3.fromRGB(255,255,255); sp.BackgroundTransparency=0.8; sp.BorderSizePixel=0; sp.Parent=mc end
    local a=Instance.new("Frame"); a.BackgroundTransparency=1; a.BorderSizePixel=0; a.AutomaticSize=Enum.AutomaticSize.XY; a.Parent=mc
    local txl=Instance.new("TextLabel"); txl.BackgroundTransparency=1; txl.BorderSizePixel=0; txl.FontFace=Font.new("rbxassetid://12187365364"); txl.Text=item.Label; txl.TextSize=15; txl.TextColor3=item.Destructive and dc or nc2; txl.AutomaticSize=Enum.AutomaticSize.XY; txl.Size=UDim2.fromOffset(0,18); txl.Parent=a
    local ap=Instance.new("UIPadding"); ap.PaddingLeft=UDim.new(0,16); ap.PaddingRight=UDim.new(0,16); ap.Parent=a
end

local ind=Instance.new("Frame"); ind.Size=UDim2.fromOffset(36,36)
ind.BackgroundColor3 = Color3.fromRGB(18,18,18); ind.BorderSizePixel = 0; ind.Parent = mc
local ic2=Instance.new("UICorner"); ic2.CornerRadius=UDim.new(1,0); ic2.Parent=ind
local it=Instance.new("TextLabel"); it.Size=UDim2.fromScale(1,1); it.BackgroundTransparency=1; it.BorderSizePixel=0
it.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold); it.Text="??"; it.TextSize=15
it.TextColor3=Color3.fromRGB(245,245,245); it.TextXAlignment=Enum.TextXAlignment.Center; it.TextYAlignment=Enum.TextYAlignment.Center; it.Parent=ind

print("=== UnaliveUI Figma Demo Loaded ===")
print("Notification: 386x64 24px r | Edit Menu: 488x44 34px r")
print("Glass: SCREEN 7% + stroke 6px + shadow y=8 + blur")
return { Notification = n, EditMenu = m }