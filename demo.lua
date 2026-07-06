-- UnaliveUI Figma Demo
loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"))()

local T=game:GetService("TweenService");local RS=game:GetService("RunService");local HS=game:GetService("HttpService");local cam=workspace.CurrentCamera;local G="Glass";local wg=HS:GenerateGUID(true)
local gui=Instance.new("ScreenGui");gui.Name="UnaliveUIDemo";gui.ResetOnSpawn=false;gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;gui.DisplayOrder=200;gui.IgnoreGuiInset=true;gui.Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local dof
for _,v in pairs(game:GetService("Lighting"):GetChildren())do if v:IsA("DepthOfFieldEffect")and v:HasTag(".")then dof=v end end
if not dof then dof=Instance.new("DepthOfFieldEffect",game:GetService("Lighting"));dof.FarIntensity=0;dof.NearIntensity=1;dof.InFocusRadius=0.1;dof.Name=HS:GenerateGUID(true);dof:AddTag(".")end

local function blur(fr)
    local d=0.001;local bf=Instance.new("Folder",cam);bf.Name=HS:GenerateGUID(true)
    local cn={};local tp={topLeft=Vector2.new(),topRight=Vector2.new(),bottomRight=Vector2.new()}
    local pt=Instance.new("Part");pt.Color=Color3.new(0,0,0);pt.Material=G;pt.Size=Vector3.new(1,1,0);pt.Anchored=true;pt.CanTouch=false;pt.CanCollide=false;pt.CanQuery=false;pt.Locked=true;pt.CastShadow=false;pt.Transparency=0.98
    local ms=Instance.new("SpecialMesh");ms.MeshType=Enum.MeshType.Brick;ms.Offset=Vector3.new(0,0,-0.000001);ms.Parent=pt
    local function us(sz,po)tp.topLeft=po;tp.topRight=po+Vector2.new(sz.X,0);tp.bottomRight=po+sz end
    local function rn()local cm=workspace.CurrentCamera;if not cm then return end
        local ok1,tl=pcall(function()return cm:ScreenPointToRay(tp.topLeft.X,tp.topLeft.Y).Origin+cm.CFrame.LookVector*d end)
        local ok2,tr=pcall(function()return cm:ScreenPointToRay(tp.topRight.X,tp.topRight.Y).Origin+cm.CFrame.LookVector*d end)
        local ok3,br=pcall(function()return cm:ScreenPointToRay(tp.bottomRight.X,tp.bottomRight.Y).Origin+cm.CFrame.LookVector*d end)
        if not ok1 or not ok2 or not ok3 then return end
        pt.CFrame=CFrame.fromMatrix((tl+br)/2,cm.CFrame.XVector,cm.CFrame.YVector,cm.CFrame.ZVector);ms.Scale=Vector3.new((tr-tl).magnitude,(tr-br).magnitude,0)end
    local function oc(rx)us(rx.AbsoluteSize,rx.AbsolutePosition);task.spawn(rn)end
    pt.Parent=bf;pt.Destroying:Connect(function()for _,c in cn do pcall(function()c:Disconnect()end)end;pcall(function()bf:Destroy()end)end)
    local cm=workspace.CurrentCamera
    if cm then cn[#cn+1]=cm:GetPropertyChangedSignal("CFrame"):Connect(rn);cn[#cn+1]=cm:GetPropertyChangedSignal("ViewportSize"):Connect(rn);cn[#cn+1]=cm:GetPropertyChangedSignal("FieldOfView"):Connect(rn)end
    fr:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()oc(fr)end);fr:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()oc(fr)end);fr.Destroying:Connect(function()pt:Destroy()end);oc(fr);task.spawn(rn)end

-- WindowPill
local p=Instance.new("ImageButton",gui);p.Name="WindowPill";p.AnchorPoint=Vector2.new(0.5,0);p.AutoButtonColor=false;p.BackgroundTransparency=1;p.BorderSizePixel=0
p.Image="rbxassetid://93520763686656";p.ImageTransparency=0.5;p.ImageColor3=Color3.fromRGB(245,245,245);p.Position=UDim2.new(0.5,0,0,10);p.Size=UDim2.fromOffset(180,5);p.ZIndex=999
local pc=Instance.new("UICorner",p);pc.CornerRadius=UDim.new(1,0)
local ti2=TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out);local ct=nil
p.MouseEnter:Connect(function()if ct then ct:Cancel()end;ct=T:Create(p,ti2,{ImageTransparency=0.15});ct:Play()end)
p.MouseLeave:Connect(function()if ct then ct:Cancel()end;ct=T:Create(p,ti2,{ImageTransparency=0.5});ct:Play()end)

-- Notification
local n=Instance.new("Frame",gui);n.Name="Notification";n.Size=UDim2.fromOffset(386,64);n.Position=UDim2.new(0.5,-193,0.5,-128);n.BackgroundTransparency=1;n.BorderSizePixel=0;n.ZIndex=10
Instance.new("UICorner",n).CornerRadius=UDim.new(0,24)
local ns=Instance.new("Frame",n);ns.Size=UDim2.new(1,4,1,4);ns.Position=UDim2.fromOffset(-2,-2);ns.BackgroundColor3=Color3.fromRGB(0,0,0);ns.BackgroundTransparency=0.78;ns.BorderSizePixel=0;ns.ZIndex=-1;Instance.new("UICorner",ns).CornerRadius=UDim.new(0,24)
local nc=Instance.new("Frame",n);nc.Size=UDim2.fromScale(1,1);nc.BackgroundColor3=Color3.fromRGB(18,20,26);nc.BackgroundTransparency=0.08;nc.BorderSizePixel=0;nc.ZIndex=1;Instance.new("UICorner",nc).CornerRadius=UDim.new(0,24)
local nb=Instance.new("Frame",n);nb.Size=UDim2.new(1,-24,1,-24);nb.Position=UDim2.fromOffset(12,12);nb.BackgroundTransparency=1;nb.BorderSizePixel=0;nb.ZIndex=0;blur(nb)
local ni=Instance.new("ImageLabel",n);ni.Size=UDim2.fromOffset(38,38);ni.Position=UDim2.fromOffset(14,13);ni.BackgroundTransparency=1;ni.BorderSizePixel=0;ni.Image="rbxassetid://127922205331150";ni.ZIndex=3;Instance.new("UICorner",ni).CornerRadius=UDim.new(0,10)
local nt=Instance.new("TextLabel",n);nt.Size=UDim2.fromOffset(274,17);nt.Position=UDim2.fromOffset(62,12);nt.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold);nt.Text="UnAlive";nt.TextSize=15;nt.TextColor3=Color3.fromRGB(255,255,255);nt.TextXAlignment=Enum.TextXAlignment.Left;nt.TextYAlignment=Enum.TextYAlignment.Top;nt.RichText=true;nt.BackgroundTransparency=1;nt.BorderSizePixel=0;nt.ZIndex=3
local nd=Instance.new("TextLabel",n);nd.Size=UDim2.fromOffset(274,18);nd.Position=UDim2.fromOffset(62,30);nd.FontFace=Font.new("rbxassetid://12187365364");nd.Text="Welcome to UnAlive";nd.TextSize=15;nd.TextColor3=Color3.fromRGB(180,180,190);nd.TextXAlignment=Enum.TextXAlignment.Left;nd.TextYAlignment=Enum.TextYAlignment.Top;nd.RichText=true;nd.BackgroundTransparency=1;nd.BorderSizePixel=0;nd.ZIndex=3
local nx=Instance.new("TextLabel",n);nx.Size=UDim2.fromOffset(26,17);nx.Position=UDim2.fromOffset(346,12);nx.FontFace=Font.new("rbxassetid://12187365364");nx.Text="now";nx.TextSize=13;nx.TextColor3=Color3.fromRGB(140,140,150);nx.TextXAlignment=Enum.TextXAlignment.Right;nx.TextYAlignment=Enum.TextYAlignment.Top;nx.BackgroundTransparency=1;nx.BorderSizePixel=0;nx.ZIndex=3
n.Position=UDim2.new(0.5,-193,0.5,-130);T:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-193,0.5,-120)}):Play()

-- EditMenu
local m=Instance.new("Frame",gui);m.Name="EditMenu";m.Size=UDim2.fromOffset(488,44);m.Position=UDim2.new(0.5,-244,0.5,-22);m.BackgroundTransparency=1;m.BorderSizePixel=0;m.ZIndex=20
Instance.new("UICorner",m).CornerRadius=UDim.new(0,34)
local ms=Instance.new("Frame",m);ms.Size=UDim2.new(1,4,1,4);ms.Position=UDim2.fromOffset(-2,-2);ms.BackgroundColor3=Color3.fromRGB(0,0,0);ms.BackgroundTransparency=0.82;ms.BorderSizePixel=0;ms.ZIndex=-1;Instance.new("UICorner",ms).CornerRadius=UDim.new(0,34)
local mc2=Instance.new("Frame",m);mc2.Size=UDim2.fromScale(1,1);mc2.BackgroundColor3=Color3.fromRGB(15,17,22);mc2.BackgroundTransparency=0.08;mc2.BorderSizePixel=0;mc2.ZIndex=1;Instance.new("UICorner",mc2).CornerRadius=UDim.new(0,34)
local mb=Instance.new("Frame",m);mb.Size=UDim2.new(1,-34,1,-34);mb.Position=UDim2.fromOffset(17,17);mb.BackgroundTransparency=1;mb.BorderSizePixel=0;mb.ZIndex=0;blur(mb)

local mc=Instance.new("Frame",m);mc.Size=UDim2.fromScale(1,1);mc.BackgroundTransparency=1;mc.BorderSizePixel=0;mc.ZIndex=3
local ml=Instance.new("UIListLayout",mc);ml.FillDirection=Enum.FillDirection.Horizontal;ml.VerticalAlignment=Enum.VerticalAlignment.Center;ml.Padding=UDim.new(0,0)
Instance.new("UIPadding",mc).PaddingLeft=UDim.new(0,20);Instance.new("UIPadding",mc).PaddingRight=UDim.new(0,4)

-- Figma-exact items
local function addItem(t,w,tw,sep,dest)
    local a=Instance.new("Frame",mc);a.Size=UDim2.fromOffset(w,18);a.BackgroundTransparency=1;a.BorderSizePixel=0
    if sep then local s=Instance.new("Frame",a);s.Size=UDim2.fromOffset(1,18);s.Position=UDim2.fromOffset(0,0);s.BackgroundColor3=Color3.fromRGB(255,255,255);s.BackgroundTransparency=0.8;s.BorderSizePixel=0 end
    local l=Instance.new("TextLabel",a);l.Size=UDim2.fromOffset(tw,18);l.Position=UDim2.fromOffset(sep and 17 or 0,0);l.BackgroundTransparency=1;l.BorderSizePixel=0;l.FontFace=Font.new("rbxassetid://12187365364");l.Text=t;l.TextSize=15;l.TextColor3=dest and Color3.fromRGB(255,66,84)or Color3.fromRGB(245,245,245);l.TextXAlignment=Enum.TextXAlignment.Left
    return a,l end
addItem("Farm",50,34,false,false);addItem("Shop",68,35,true,false);addItem("Steal",67,34,true,false);addItem("Spawn",78,45,true,true);addItem("Config",77,44,true,false);addItem("Settings",88,55,true,false)

-- Indicator
local ind=Instance.new("Frame",m);ind.Size=UDim2.fromOffset(36,36);ind.Position=UDim2.fromOffset(448,4);ind.BackgroundColor3=Color3.fromRGB(18,18,18);ind.BorderSizePixel=0;ind.ZIndex=6
Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
local ch=Instance.new("ImageLabel",ind);ch.Size=UDim2.fromOffset(16,16);ch.Position=UDim2.fromOffset(10,10);ch.BackgroundTransparency=1;ch.BorderSizePixel=0;ch.Image="rbxassetid://103603118195781";ch.ImageColor3=Color3.fromRGB(245,245,245);ch.ScaleType=Enum.ScaleType.Fit
T:Create(m,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-244,0.5,-22)}):Play()

-- Alert
local a=Instance.new("Frame",gui);a.Name="Alert";a.Size=UDim2.fromOffset(260,140);a.Position=UDim2.new(0.5,-130,0,180);a.BackgroundTransparency=1;a.ZIndex=100
Instance.new("UICorner",a).CornerRadius=UDim.new(0,10)
local af=Instance.new("Frame",a);af.Size=UDim2.fromScale(1,1);af.BackgroundColor3=Color3.fromRGB(18,20,26);af.BackgroundTransparency=0.08;af.BorderSizePixel=0;af.ZIndex=100;Instance.new("UICorner",af).CornerRadius=UDim.new(0,26)
local as2=Instance.new("Frame",a);as2.Name="Shadow";as2.Size=UDim2.new(1,4,1,4);as2.Position=UDim2.fromOffset(-2,-2);as2.BackgroundColor3=Color3.fromRGB(0,0,0);as2.BackgroundTransparency=0.78;as2.BorderSizePixel=0;as2.ZIndex=98;Instance.new("UICorner",as2).CornerRadius=UDim.new(0,26)
local ab=Instance.new("Frame",a);ab.Size=UDim2.new(1,-20,1,-20);ab.Position=UDim2.fromOffset(10,10);ab.BackgroundTransparency=1;ab.BorderSizePixel=0;ab.ZIndex=99;blur(ab)
Instance.new("UIStroke",af).Color=Color3.fromRGB(255,255,255);Instance.new("UIStroke",af).Transparency=0.88;Instance.new("UIStroke",af).Thickness=1

local at2=Instance.new("TextLabel",a);at2.Size=UDim2.fromOffset(216,16);at2.Position=UDim2.fromOffset(22,20);at2.BackgroundTransparency=1;at2.BorderSizePixel=0;at2.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.Bold);at2.Text="UnAlive";at2.TextSize=13;at2.TextColor3=Color3.fromRGB(255,255,255);at2.TextXAlignment=Enum.TextXAlignment.Left;at2.TextYAlignment=Enum.TextYAlignment.Center;at2.RichText=true;at2.ZIndex=102
local ad2=Instance.new("TextLabel",a);ad2.Size=UDim2.fromOffset(216,28);ad2.Position=UDim2.fromOffset(22,46);ad2.BackgroundTransparency=1;ad2.BorderSizePixel=0;ad2.FontFace=Font.new("rbxassetid://12187365364");ad2.Text="Your Items have been saved by Anti Stealer";ad2.TextSize=11;ad2.TextColor3=Color3.fromRGB(180,180,190);ad2.TextXAlignment=Enum.TextXAlignment.Left;ad2.TextYAlignment=Enum.TextYAlignment.Top;ad2.RichText=true;ad2.ZIndex=102
local function mkB(x,t,s)
    local b=Instance.new("TextButton",a);b.AutoButtonColor=false;b.Size=UDim2.fromOffset(110,32);b.Position=UDim2.fromOffset(x,92);b.BackgroundTransparency=1;b.BorderSizePixel=0;b.Text="";b.ZIndex=102;Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
    local bg=Instance.new("Frame",b);bg.Size=UDim2.fromScale(1,1);bg.BorderSizePixel=0;bg.ZIndex=101;bg.BackgroundColor3=s=="D"and Color3.fromRGB(255,56,60)or Color3.fromRGB(230,230,230);bg.BackgroundTransparency=s=="D"and 0.77 or 0;Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
    local l=Instance.new("TextLabel",b);l.Size=UDim2.fromScale(1,1);l.BackgroundTransparency=1;l.BorderSizePixel=0;l.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium);l.Text=t;l.TextSize=13;l.TextColor3=s=="D"and Color3.fromRGB(255,56,60)or Color3.fromRGB(0,0,0);l.TextXAlignment=Enum.TextXAlignment.Center;l.TextYAlignment=Enum.TextYAlignment.Center;l.ZIndex=102 end
mkB(16,"Turn OFF","D");mkB(134,"Keep On","P")
a.Position=UDim2.new(0.5,-130,0,170);T:Create(a,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-130,0,180)}):Play()
print("=== UnaliveUI Figma Demo ===")