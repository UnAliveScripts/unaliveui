-- UnaliveUI Figma Demo
loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"))()

local TS=game:GetService("TweenService");local RS=game:GetService("RunService");local HS=game:GetService("HttpService")
local camera=workspace.CurrentCamera;local icons={UnAlivelogo="rbxassetid://127922205331150"}
local plr=game:GetService("Players").LocalPlayer;local gui=Instance.new("ScreenGui")
gui.Name="UnaliveUIDemo";gui.ResetOnSpawn=false;gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.DisplayOrder=200;gui.IgnoreGuiInset=true;gui.Parent=plr:WaitForChild("PlayerGui")

local function IsNotNaN(x)return x==x end
local G="Glass";local wg=HS:GenerateGUID(true);local rt=Instance.new("Folder",camera);rt.Name=HS:GenerateGUID(true)
local DOF
for _,v in pairs(game:GetService("Lighting"):GetChildren())do
    if not v:IsA("DepthOfFieldEffect")and v:HasTag(".")then
        DOF=Instance.new("DepthOfFieldEffect",game:GetService("Lighting"))
        DOF.FarIntensity=0;DOF.NearIntensity=1;DOF.InFocusRadius=0.1;DOF.Name=HS:GenerateGUID(true);DOF:AddTag(".")
    elseif v:IsA("DepthOfFieldEffect")and v:HasTag(".")then DOF=v end end
if not DOF then
    DOF=Instance.new("DepthOfFieldEffect",game:GetService("Lighting"))
    DOF.FarIntensity=0;DOF.NearIntensity=1;DOF.InFocusRadius=0.1;DOF.Name=HS:GenerateGUID(true);DOF:AddTag(".") end
while not IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x)do RS.RenderStepped:Wait()end

local acos,max,pi,sqrt=math.acos,math.max,math.pi,math.sqrt;local sz=0.2
local function DT(v1,v2,v3,p0,p1)
    local s1=(v1-v2).magnitude;local s2=(v2-v3).magnitude;local s3=(v3-v1).magnitude
    local smax=max(s1,s2,s3);local A,B,C
    if s1==smax then A,B,C=v1,v2,v3 elseif s2==smax then A,B,C=v2,v3,v1 else A,B,C=v3,v1,v2 end
    local para=((B-A).x*(C-A).x+(B-A).y*(C-A).y+(B-A).z*(C-A).z)/(A-B).magnitude
    local perp=sqrt((C-A).magnitude^2-para*para);local dif_para=(A-B).magnitude-para
    local st=CFrame.new(B,A);local za=CFrame.Angles(pi/2,0,0);local cf0=st;local TL=(cf0*za).lookVector
    local MP=A+CFrame.new(A,B).lookVector*para;local NL=CFrame.new(MP,C).lookVector
    local dot=TL.x*NL.x+TL.y*NL.y+TL.z*NL.z;local acv=CFrame.Angles(0,0,acos(dot));cf0=cf0*acv
    if((cf0*za).lookVector-NL).magnitude>0.01 then cf0=cf0*CFrame.Angles(0,0,-2*acos(dot))end
    cf0=cf0*CFrame.new(0,perp/2,-(dif_para+para/2))
    local cf1=st*acv*CFrame.Angles(0,pi,0)
    if((cf1*za).lookVector-NL).magnitude>0.01 then cf1=cf1*CFrame.Angles(0,0,2*acos(dot))end
    cf1=cf1*CFrame.new(0,perp/2,dif_para/2)
    if not p0 then p0=Instance.new("Part");p0.FormFactor="Custom";p0.TopSurface=0;p0.BottomSurface=0
        p0.Anchored=true;p0.CanCollide=false;p0.CastShadow=false;p0.Material=G
        p0.Size=Vector3.new(sz,sz,sz);p0.Name=HS:GenerateGUID(true)
        local m2=Instance.new("SpecialMesh",p0);m2.MeshType=2;m2.Name=wg end
    p0[wg].Scale=Vector3.new(0,perp/sz,para/sz);p0.CFrame=cf0
    if not p1 then p1=p0:clone()end;p1[wg].Scale=Vector3.new(0,perp/sz,dif_para/sz);p1.CFrame=cf1
    return p0,p1 end
local function DQ(v1,v2,v3,v4,pts)pts[1],pts[2]=DT(v1,v2,v3,pts[1],pts[2]);pts[3],pts[4]=DT(v3,v2,v4,pts[3],pts[4])end
local function blur(fr)
    local d=0.001;local bf=Instance.new("Folder",camera);bf.Name=HS:GenerateGUID(true)
    local cn={};local tp={topLeft=Vector2.new(),topRight=Vector2.new(),bottomRight=Vector2.new()}
    local pt=Instance.new("Part");pt.Color=Color3.new(0,0,0);pt.Material=G;pt.Size=Vector3.new(1,1,0)
    pt.Anchored=true;pt.CanTouch=false;pt.CanCollide=false;pt.CanQuery=false;pt.Locked=true;pt.CastShadow=false;pt.Transparency=0.98
    local ms=Instance.new("SpecialMesh");ms.MeshType=Enum.MeshType.Brick;ms.Offset=Vector3.new(0,0,-0.000001);ms.Parent=pt
    local df=Instance.new("DepthOfFieldEffect",game:GetService("Lighting"));df.FarIntensity=0;df.NearIntensity=1;df.InFocusRadius=0.1
    local function us(sz,po)tp.topLeft=po;tp.topRight=po+Vector2.new(sz.X,0);tp.bottomRight=po+sz end
    local function rn()local cm=workspace.CurrentCamera;if not cm then return end
        local tl=cm:ScreenPointToRay(tp.topLeft.X,tp.topLeft.Y).Origin+cm.CFrame.LookVector*d
        local tr=cm:ScreenPointToRay(tp.topRight.X,tp.topRight.Y).Origin+cm.CFrame.LookVector*d
        local br=cm:ScreenPointToRay(tp.bottomRight.X,tp.bottomRight.Y).Origin+cm.CFrame.LookVector*d
        local w=(tr-tl).magnitude;local h=(tr-br).magnitude
        pt.CFrame=CFrame.fromMatrix((tl+br)/2,cm.CFrame.XVector,cm.CFrame.YVector,cm.CFrame.ZVector);ms.Scale=Vector3.new(w,h,0)end
    local function oc(rx)local sz=rx.AbsoluteSize;local po=rx.AbsolutePosition;us(sz,po);task.spawn(rn)end
    pt.Parent=bf
    pt.Destroying:Connect(function()for _,c in cn do pcall(function()c:Disconnect()end)end;pcall(function()df:Destroy()end);pcall(function()bf:Destroy()end)end)
    local cm=workspace.CurrentCamera
    if cm then cn[#cn+1]=cm:GetPropertyChangedSignal("CFrame"):Connect(rn);cn[#cn+1]=cm:GetPropertyChangedSignal("ViewportSize"):Connect(rn);cn[#cn+1]=cm:GetPropertyChangedSignal("FieldOfView"):Connect(rn)end
    fr:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()oc(fr)end)
    fr:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()oc(fr)end)
    fr.Destroying:Connect(function()pt:Destroy()end);oc(fr);task.spawn(rn)end

-- WindowPill
local p=Instance.new("ImageButton");p.Name="WindowPill"
p.AnchorPoint=Vector2.new(0.5,0);p.AutoButtonColor=false;p.BackgroundTransparency=1;p.BorderSizePixel=0
p.Image="rbxassetid://93520763686656";p.ImageTransparency=0.5;p.ImageColor3=Color3.fromRGB(245,245,245)
p.Position=UDim2.new(0.5,0,0,10);p.Size=UDim2.fromOffset(180,5);p.ZIndex=999;p.Parent=gui
local pc=Instance.new("UICorner");pc.CornerRadius=UDim.new(1,0);pc.Parent=p
local ti2=TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out);local ct=nil
p.MouseEnter:Connect(function()if ct then ct:Cancel()end;ct=TS:Create(p,ti2,{ImageTransparency=0.15});ct:Play()end)
p.MouseLeave:Connect(function()if ct then ct:Cancel()end;ct=TS:Create(p,ti2,{ImageTransparency=0.5});ct:Play()end)

-- Notification
local n=Instance.new("Frame");n.Name="Notification";n.Size=UDim2.fromOffset(386,64);n.Position=UDim2.new(0.5,-193,0.5,-128)
n.BackgroundTransparency=1;n.BorderSizePixel=0;n.ZIndex=10;n.Parent=gui
local ncr=Instance.new("UICorner");ncr.CornerRadius=UDim.new(0,24);ncr.Parent=n
local ns=Instance.new("Frame");ns.Name="Shadow";ns.Size=UDim2.new(1,4,1,4);ns.Position=UDim2.fromOffset(-2,-2)
ns.BackgroundColor3=Color3.fromRGB(0,0,0);ns.BackgroundTransparency=0.78;ns.BorderSizePixel=0;ns.ZIndex=-1;ns.Parent=n
local nsc=Instance.new("UICorner");nsc.CornerRadius=UDim.new(0,24);nsc.Parent=ns
local nc=Instance.new("Frame");nc.Size=UDim2.fromScale(1,1);nc.BackgroundColor3=Color3.fromRGB(18,20,26);nc.BackgroundTransparency=0.08
nc.BorderSizePixel=0;nc.ZIndex=1;nc.Parent=n
local ncc=Instance.new("UICorner");ncc.CornerRadius=UDim.new(0,24);ncc.Parent=nc
local nb=Instance.new("Frame");nb.Size=UDim2.new(1,-24,1,-24);nb.Position=UDim2.fromOffset(12,12);nb.BackgroundTransparency=1;nb.BorderSizePixel=0;nb.ZIndex=0;nb.Parent=n;blur(nb)
local ni=Instance.new("ImageLabel");ni.Size=UDim2.fromOffset(38,38);ni.Position=UDim2.fromOffset(14,13)
ni.BackgroundTransparency=1;ni.BorderSizePixel=0;ni.Image=icons.UnAlivelogo;ni.ZIndex=3;ni.Parent=n
local nic=Instance.new("UICorner");nic.CornerRadius=UDim.new(0,10);nic.Parent=ni
local nt=Instance.new("TextLabel");nt.Size=UDim2.fromOffset(274,17);nt.Position=UDim2.fromOffset(62,12)
nt.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold);nt.Text="UnAlive";nt.TextSize=15
nt.TextColor3=Color3.fromRGB(255,255,255);nt.TextXAlignment=Enum.TextXAlignment.Left;nt.TextYAlignment=Enum.TextYAlignment.Top
nt.RichText=true;nt.BackgroundTransparency=1;nt.BorderSizePixel=0;nt.ZIndex=3;nt.Parent=n
local nd=Instance.new("TextLabel");nd.Size=UDim2.fromOffset(274,18);nd.Position=UDim2.fromOffset(62,30)
nd.FontFace=Font.new("rbxassetid://12187365364");nd.Text="Welcome to UnAlive";nd.TextSize=15
nd.TextColor3=Color3.fromRGB(180,180,190);nd.TextXAlignment=Enum.TextXAlignment.Left;nd.TextYAlignment=Enum.TextYAlignment.Top
nd.RichText=true;nd.BackgroundTransparency=1;nd.BorderSizePixel=0;nd.ZIndex=3;nd.Parent=n
local nx=Instance.new("TextLabel");nx.Size=UDim2.fromOffset(26,17);nx.Position=UDim2.fromOffset(346,12)
nx.FontFace=Font.new("rbxassetid://12187365364");nx.Text="now";nx.TextSize=13;nx.TextColor3=Color3.fromRGB(140,140,150)
nx.TextXAlignment=Enum.TextXAlignment.Right;nx.TextYAlignment=Enum.TextYAlignment.Top
nx.BackgroundTransparency=1;nx.BorderSizePixel=0;nx.ZIndex=3;nx.Parent=n
n.Position=UDim2.new(0.5,-193,0.5,-130);TS:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-193,0.5,-120)}):Play()

-- EditMenu
local m=Instance.new("Frame");m.Name="EditMenu";m.Size=UDim2.fromOffset(488,44);m.Position=UDim2.new(0.5,-244,0.5,-22)
m.BackgroundTransparency=1;m.BorderSizePixel=0;m.ZIndex=20;m.Parent=gui
local mcr=Instance.new("UICorner");mcr.CornerRadius=UDim.new(0,34);mcr.Parent=m
local ms=Instance.new("Frame");ms.Name="Shadow";ms.Size=UDim2.new(1,4,1,4);ms.Position=UDim2.fromOffset(-2,-2)
ms.BackgroundColor3=Color3.fromRGB(0,0,0);ms.BackgroundTransparency=0.82;ms.BorderSizePixel=0;ms.ZIndex=-1;ms.Parent=m
local msc=Instance.new("UICorner");msc.CornerRadius=UDim.new(0,34);msc.Parent=ms
local mc2=Instance.new("Frame");mc2.Size=UDim2.fromScale(1,1);mc2.BackgroundColor3=Color3.fromRGB(15,17,22);mc2.BackgroundTransparency=0.08
mc2.BorderSizePixel=0;mc2.ZIndex=1;mc2.Parent=m
local mc2c=Instance.new("UICorner");mc2c.CornerRadius=UDim.new(0,34);mc2c.Parent=mc2
local mb=Instance.new("Frame");mb.Size=UDim2.new(1,-34,1,-34);mb.Position=UDim2.fromOffset(17,17);mb.BackgroundTransparency=1;mb.BorderSizePixel=0;mb.ZIndex=0;mb.Parent=m;blur(mb)

-- SelectionPill
local sp=Instance.new("Frame");sp.Name="SelectionPill"
sp.Size=UDim2.fromOffset(50,28);sp.Position=UDim2.fromOffset(20,8)
sp.BackgroundColor3=Color3.fromRGB(40,50,70);sp.BackgroundTransparency=0.2
sp.BorderSizePixel=0;sp.ZIndex=5;sp.Parent=m
local spc=Instance.new("UICorner");spc.CornerRadius=UDim.new(1,0);spc.Parent=sp

local mc=Instance.new("Frame");mc.Size=UDim2.fromScale(1,1);mc.BackgroundTransparency=1;mc.BorderSizePixel=0;mc.ZIndex=3;mc.Parent=m
local ml=Instance.new("UIListLayout");ml.FillDirection=Enum.FillDirection.Horizontal;ml.VerticalAlignment=Enum.VerticalAlignment.Center;ml.Padding=UDim.new(0,0);ml.Parent=mc
local mp=Instance.new("UIPadding");mp.PaddingLeft=UDim.new(0,20);mp.PaddingRight=UDim.new(0,4);mp.Parent=mc

local items={{Label="Farm"},{Label="Shop"},{Label="Steal"},{Label="Spawn",Destructive=true},{Label="Config"},{Label="Settings"}}
local dc=Color3.fromRGB(255,66,84);local nc2=Color3.fromRGB(245,245,245)
for i,item in ipairs(items)do
    if i>1 then local sp2=Instance.new("Frame");sp2.Size=UDim2.fromOffset(1,18);sp2.BackgroundColor3=Color3.fromRGB(255,255,255);sp2.BackgroundTransparency=0.8;sp2.BorderSizePixel=0;sp2.Parent=mc end
    local a=Instance.new("Frame");a.BackgroundTransparency=1;a.BorderSizePixel=0;a.AutomaticSize=Enum.AutomaticSize.XY;a.Parent=mc
    local txl=Instance.new("TextLabel");txl.BackgroundTransparency=1;txl.BorderSizePixel=0;txl.FontFace=Font.new("rbxassetid://12187365364");txl.Text=item.Label;txl.TextSize=15;txl.TextColor3=item.Destructive and dc or nc2;txl.AutomaticSize=Enum.AutomaticSize.XY;txl.Size=UDim2.fromOffset(0,18);txl.Parent=a
    local ap=Instance.new("UIPadding");ap.PaddingLeft=UDim.new(0,16);ap.PaddingRight=UDim.new(0,16);ap.Parent=a end

local ind=Instance.new("Frame");ind.Size=UDim2.fromOffset(36,36);ind.BackgroundColor3=Color3.fromRGB(18,18,18);ind.BorderSizePixel=0;ind.Parent=mc
local ic2=Instance.new("UICorner");ic2.CornerRadius=UDim.new(1,0);ic2.Parent=ind
local ch=Instance.new("ImageLabel");ch.Size=UDim2.fromOffset(26,26);ch.Position=UDim2.fromOffset(5,5)
ch.BackgroundTransparency=1;ch.BorderSizePixel=0;ch.Image="rbxassetid://103603118195781";ch.ImageColor3=Color3.fromRGB(245,245,245);ch.ScaleType=Enum.ScaleType.Fit;ch.Parent=ind

TS:Create(m,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-244,0.5,-22)}):Play()

-- Alert
local a=Instance.new("Frame");a.Name="Alert";a.Size=UDim2.fromOffset(260,140);a.Position=UDim2.new(0.5,-130,0.5,-70)
a.BackgroundTransparency=1;a.ZIndex=100;a.Parent=gui
local acr=Instance.new("UICorner");acr.CornerRadius=UDim.new(0,10);acr.Parent=a
local afs=Instance.new("Frame");afs.Size=UDim2.fromScale(1,1);afs.BackgroundColor3=Color3.fromRGB(18,20,26);afs.BackgroundTransparency=0.08
afs.BorderSizePixel=0;afs.ZIndex=100;afs.Parent=a
local afsc=Instance.new("UICorner");afsc.CornerRadius=UDim.new(0,26);afsc.Parent=afs
local ash2=Instance.new("Frame");ash2.Name="Shadow";ash2.Size=UDim2.new(1,4,1,4);ash2.Position=UDim2.fromOffset(-2,-2)
ash2.BackgroundColor3=Color3.fromRGB(0,0,0);ash2.BackgroundTransparency=0.78;ash2.BorderSizePixel=0;ash2.ZIndex=98;ash2.Parent=a
local ashc2=Instance.new("UICorner");ashc2.CornerRadius=UDim.new(0,26);ashc2.Parent=ash2
local abf2=Instance.new("Frame");abf2.Size=UDim2.new(1,-20,1,-20);abf2.Position=UDim2.fromOffset(10,10);abf2.BackgroundTransparency=1;abf2.BorderSizePixel=0;abf2.ZIndex=99;abf2.Parent=a;blur(abf2)
local aus=Instance.new("UIStroke");aus.Color=Color3.fromRGB(255,255,255);aus.Transparency=0.88;aus.Thickness=1;aus.Parent=afs

local at=Instance.new("TextLabel");at.Size=UDim2.fromOffset(216,16);at.Position=UDim2.fromOffset(22,20)
at.BackgroundTransparency=1;at.BorderSizePixel=0;at.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.Bold)
at.Text="UnAlive";at.TextSize=13;at.TextColor3=Color3.fromRGB(255,255,255);at.TextXAlignment=Enum.TextXAlignment.Left;at.TextYAlignment=Enum.TextYAlignment.Center;at.RichText=true;at.ZIndex=102;at.Parent=a

local ad2=Instance.new("TextLabel");ad2.Size=UDim2.fromOffset(216,28);ad2.Position=UDim2.fromOffset(22,46)
ad2.BackgroundTransparency=1;ad2.BorderSizePixel=0;ad2.FontFace=Font.new("rbxassetid://12187365364")
ad2.Text="Your Items have been saved by Anti Stealer";ad2.TextSize=11;ad2.TextColor3=Color3.fromRGB(180,180,190)
ad2.TextXAlignment=Enum.TextXAlignment.Left;ad2.TextYAlignment=Enum.TextYAlignment.Top;ad2.RichText=true;ad2.ZIndex=102;ad2.Parent=a

local b1=Instance.new("TextButton");b1.AutoButtonColor=false;b1.Size=UDim2.fromOffset(110,32);b1.Position=UDim2.fromOffset(16,92)
b1.BackgroundTransparency=1;b1.BorderSizePixel=0;b1.Text="";b1.ZIndex=102;b1.Parent=a
local b1c=Instance.new("UICorner");b1c.CornerRadius=UDim.new(1,0);b1c.Parent=b1
local b1g=Instance.new("Frame");b1g.Size=UDim2.fromScale(1,1);b1g.BorderSizePixel=0;b1g.ZIndex=101;b1g.Parent=b1
b1g.BackgroundColor3=Color3.fromRGB(255,56,60);b1g.BackgroundTransparency=0.77
local b1gc=Instance.new("UICorner");b1gc.CornerRadius=UDim.new(1,0);b1gc.Parent=b1g
local b1l=Instance.new("TextLabel");b1l.Size=UDim2.fromScale(1,1);b1l.BackgroundTransparency=1;b1l.BorderSizePixel=0
b1l.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium);b1l.Text="Turn OFF";b1l.TextSize=13
b1l.TextColor3=Color3.fromRGB(255,56,60);b1l.TextXAlignment=Enum.TextXAlignment.Center;b1l.TextYAlignment=Enum.TextYAlignment.Center;b1l.ZIndex=102;b1l.Parent=b1

local b2=Instance.new("TextButton");b2.AutoButtonColor=false;b2.Size=UDim2.fromOffset(110,32);b2.Position=UDim2.fromOffset(134,92)
b2.BackgroundTransparency=1;b2.BorderSizePixel=0;b2.Text="";b2.ZIndex=102;b2.Parent=a
local b2c=Instance.new("UICorner");b2c.CornerRadius=UDim.new(1,0);b2c.Parent=b2
local b2g=Instance.new("Frame");b2g.Size=UDim2.fromScale(1,1);b2g.BorderSizePixel=0;b2g.ZIndex=101;b2g.Parent=b2
b2g.BackgroundColor3=Color3.fromRGB(230,230,230);b2g.BackgroundTransparency=0
local b2gc=Instance.new("UICorner");b2gc.CornerRadius=UDim.new(1,0);b2gc.Parent=b2g
local b2l=Instance.new("TextLabel");b2l.Size=UDim2.fromScale(1,1);b2l.BackgroundTransparency=1;b2l.BorderSizePixel=0
b2l.FontFace=Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium);b2l.Text="Keep On";b2l.TextSize=13
b2l.TextColor3=Color3.fromRGB(0,0,0);b2l.TextXAlignment=Enum.TextXAlignment.Center;b2l.TextYAlignment=Enum.TextYAlignment.Center;b2l.ZIndex=102;b2l.Parent=b2

a.Position=UDim2.new(0.5,-130,0.5,-80);TS:Create(a,TweenInfo.new(0.4,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-130,0.5,-70)}):Play()
print("=== UnaliveUI Figma Demo ===")