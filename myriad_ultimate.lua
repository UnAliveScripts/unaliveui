--[[
    Myriad v1.6.3 Ultimate — Complete UI Library + Demo
    Exact 1:1 macOS-Sequoia-style replica of the original Myriad executor UI
    Self-contained. No require() needed. Paste into any executor.
--]]

do
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")

    local LP = Players.LocalPlayer
    local Mouse = LP:GetMouse()

    local function protect(gui)
        local s, e = pcall(function() gui.Parent = CoreGui end)
        if not s then
            pcall(function() gui.Parent = LP:WaitForChild("PlayerGui") end)
        end
    end

    local function c(hex, alphaPct)
        return Color3.fromHex(hex), 1 - (alphaPct / 100)
    end

    local function New(className, props)
        local inst = Instance.new(className)
        for k, v in pairs(props) do
            if k ~= "Parent" then
                pcall(function() inst[k] = v end)
            end
        end
        if props.Parent then
            inst.Parent = props.Parent
        end
        return inst
    end

    -- ===== EXACT MYRIAD THEME COLORS (Dark) =====
    local bodyColor, bodyTrans = c("202023", 84)
    local sepColor, sepTrans = c("000000", 50)
    local contentColor, contentTrans = c("1C1C1E", 100)
    local titlebarColor, titlebarTrans = c("363636", 100)
    local font = Font.new("rbxassetid://12187365364")
    local fontBold = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold)
    local fontSemiBold = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)

    local Theme = {
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(255, 255, 255),
        TextMuted = Color3.fromRGB(255, 255, 255),
        TextPrimaryTrans = 0.15,
        TextSecondaryTrans = 0.45,
        TextMutedTrans = 0.65,
        Accent = Color3.fromRGB(10, 130, 255),
        Success = Color3.fromRGB(52, 199, 89),
        Warning = Color3.fromRGB(255, 189, 46),
        Error = Color3.fromRGB(255, 95, 87),
        Red = Color3.fromHex("FF5F57"),
        Yellow = Color3.fromHex("FEBC2E"),
        Green = Color3.fromHex("28C840"),
        RedDim = Color3.fromRGB(80, 40, 38),
        YellowDim = Color3.fromRGB(80, 65, 30),
        GreenDim = Color3.fromRGB(35, 65, 40),
        ToggleOff = Color3.fromRGB(70, 70, 70),
        SliderBg = Color3.fromRGB(44, 44, 46),
        InputBg = Color3.fromRGB(50, 50, 50),
        SidebarBg = Color3.fromRGB(32, 32, 35),
        ContentBg = Color3.fromRGB(28, 28, 30),
        BodyBg = Color3.fromRGB(32, 32, 35),
        ButtonHover = Color3.fromRGB(55, 55, 55),
        ButtonActive = Color3.fromRGB(72, 72, 72),
    }

    -- ===== BUILD UI: Exact Cascade structure =====
    local gui = New("ScreenGui", {
        Name = "Cascade",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 200,
        OnTopOfCoreBlur = true,
    })
    protect(gui)

    local uiScale = New("UIScale", { Name = "UIScale", Parent = gui })

    -- WindowPill (top draggable pill for minimize)
    local windowPill = New("ImageButton", {
        Name = "WindowPill",
        AnchorPoint = Vector2.new(0.5, 0),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://93520763686656",
        ImageTransparency = 0.5,
        Position = UDim2.new(0.5, 0, 0, 10),
        Size = UDim2.fromOffset(180, 5),
        Parent = gui,
    })
    New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = windowPill })

    local window = New("Frame", {
        Name = "Window",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = gui,
    })

    local body = New("Frame", {
        Name = "Body",
        BackgroundColor3 = bodyColor,
        BackgroundTransparency = bodyTrans,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(850, 530),
        Parent = window,
    })
    local bodyCorner = New("UICorner", { CornerRadius = UDim.new(0, 10), Parent = body })

    -- Drop shadow
    local dropShadow = New("ImageLabel", {
        Name = "Dropshadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://138260268144845",
        ImageTransparency = 0.65,
        Interactable = false,
        Position = UDim2.new(0.5, 0, 0.5, 3),
        ScaleType = Enum.ScaleType.Slice,
        Size = UDim2.new(1, 24, 1, 24),
        SliceCenter = Rect.new(28, 26, 96, 94),
        ZIndex = 0,
        Parent = body,
    })

    local bodyLayout = New("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 0),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = body,
    })

    -- ===== SIDEBAR =====
    local sidebarMargins = New("Frame", {
        Name = "Sidebar",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 200, 1, 0),
        ClipsDescendants = true,
        Parent = body,
    })
    New("UIPadding", { Name = "UIPadding", Parent = sidebarMargins })

    local sidebar = New("Frame", {
        Name = "Margins",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 200, 1, 0),
        Parent = sidebarMargins,
    })
    New("UIPadding", { Name = "UIPadding", Parent = sidebar })

    local sidebarLI = New("Folder", { Name = "LayoutIgnore", Parent = sidebar })

    -- Shadow edge on sidebar
    local shadowFrame = New("Frame", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(1, 2, 0, 0),
        Size = UDim2.new(0, 5, 1, 0),
        ZIndex = 0,
        Parent = sidebarLI,
    })
    local sg = New("UIGradient", { Parent = shadowFrame })
    sg.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })

    -- Sidebar toolbar
    local sidebarToolbar = New("Frame", {
        Name = "Toolbar",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 52),
        Parent = sidebar,
    })

    -- Window controls (traffic lights)
    local wcFrame = New("Frame", {
        Name = "WindowControls",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(92, 38),
        Parent = sidebarToolbar,
    })
    do
        local l = New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = wcFrame })
        New("UIPadding", { PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20), Parent = wcFrame })
    end

    local wcButtons = {}
    local btnData = {
        { Name = "Exit", Clr = "FF5F57", Icn = "rbxassetid://94781753558308", Ord = 0 },
        { Name = "Minimize", Clr = "FEBC2E", Icn = "rbxassetid://118368309445367", Ord = 1 },
        { Name = "Zoom", Clr = "28C840", Icn = "rbxassetid://114376524082699", Ord = 2 },
    }
    for _, d in ipairs(btnData) do
        local btn = New("ImageButton", {
            Name = d.Name,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = "rbxassetid://132228700346004",
            ImageColor3 = Color3.fromHex(d.Clr),
            ImageTransparency = 0,
            LayoutOrder = d.Ord,
            Size = UDim2.fromOffset(12, 12),
            Parent = wcFrame,
        })
        New("ImageLabel", { Name = "Stroke", Parent = btn })
        local ic = New("ImageLabel", {
            Name = "Icon",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = d.Icn,
            ImageColor3 = Color3.fromRGB(0, 0, 0),
            ImageTransparency = 0.50,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1),
            Visible = false,
            Parent = btn,
        })
        wcButtons[d.Name] = btn
        btn.MouseEnter:Connect(function() ic.Visible = true end)
        btn.MouseLeave:Connect(function() ic.Visible = false end)
    end

    -- Version labels
    local vLbl = New("TextLabel", {
        Name = "Version",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        FontFace = fontBold,
        Size = UDim2.fromOffset(0, 20),
        Text = "v1.6.3",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.15,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sidebarToolbar,
    })

    local vSub = New("TextLabel", {
        Name = "VersionSub",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        FontFace = font,
        Size = UDim2.fromOffset(0, 14),
        Text = "Release",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.45,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sidebarToolbar,
    })

    -- Sidebar list (nav)
    local sidebarList = New("ScrollingFrame", {
        Name = "SidebarList",
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(),
        Position = UDim2.fromOffset(0, 52),
        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
        ScrollBarImageTransparency = 0.7,
        ScrollBarThickness = 6,
        Size = UDim2.new(1, 0, 1, -52),
        Parent = sidebar,
    })
    do
        New("UIListLayout", { Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Right, Parent = sidebarList })
        New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), Parent = sidebarList })
    end

    -- Separator
    local separator = New("Frame", {
        Name = "Separator",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = sepColor,
        BackgroundTransparency = sepTrans,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(0, 1, 1, 0),
        Parent = body,
    })

    -- ===== CONTENT BODY =====
    local contentBody = New("Frame", {
        Name = "ContentBody",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = contentColor,
        BackgroundTransparency = contentTrans,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = 2,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(1, -201, 1, 0),
        Parent = body,
    })
    New("UICorner", { CornerRadius = UDim.new(0, 10), Parent = contentBody })

    local content = New("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(0, 52),
        Size = UDim2.new(1, 0, 1, -52),
        Parent = contentBody,
    })
    New("UIPadding", { Name = "Margins", Parent = content })

    local cornerClip = New("Frame", {
        Name = "CornerClip",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = contentColor,
        BackgroundTransparency = contentTrans,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromOffset(10, 10),
        ZIndex = -1,
        Parent = contentBody,
    })

    -- LayoutIgnore (drag area + dropshadow)
    local bodyLI = New("Folder", { Name = "LayoutIgnore", Parent = body })

    local topArea = New("TextButton", {
        Name = "TopArea",
        AutoButtonColor = false,
        Active = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 52),
        ZIndex = 0,
        Text = "",
        Modal = false,
        Parent = bodyLI,
    })

    -- Toolbar (titlebar)
    local titlebar = New("Frame", {
        Name = "Toolbar",
        BackgroundColor3 = titlebarColor,
        BackgroundTransparency = titlebarTrans,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 52),
        Parent = contentBody,
    })
    New("UICorner", { CornerRadius = UDim.new(0, 10), Parent = titlebar })

    local tShadow = New("Frame", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(1, 1),
        Size = UDim2.new(1, 0, 0, 2),
        ZIndex = 0,
        Parent = titlebar,
    })
    local tsg = New("UIGradient", { Parent = tShadow })
    tsg.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
    tsg.Rotation = -90
    tsg.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) })

    local tbContent = New("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Parent = titlebar,
    })

    local leading = New("Frame", {
        Name = "Leading",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        Parent = tbContent,
    })
    do
        New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = leading })
        New("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = leading })
    end

    local ts = New("Frame", {
        Name = "TitleSubtitle",
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Parent = leading,
    })
    do
        New("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = ts })
        New("UIPadding", { Parent = ts })
    end

    local titleText = New("TextLabel", {
        Name = "Title",
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        FontFace = fontSemiBold,
        LineHeight = 0,
        RichText = true,
        Size = UDim2.fromOffset(0, 20),
        Text = "Myriad",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.15,
        TextSize = 16,
        Parent = ts,
    })

    local subtitleText = New("TextLabel", {
        Name = "Subtitle",
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        FontFace = font,
        LayoutOrder = 1,
        RichText = true,
        Size = UDim2.fromOffset(0, 14),
        Text = "The General Validity Test | Release v1.6.3",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.45,
        TextSize = 12,
        Visible = true,
        Parent = ts,
    })

    -- Sidebar toggle button
    local sBtn = New("Frame", {
        Name = "SidebarButton",
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(38, 34),
        Parent = leading,
    })

    local sImg = New("ImageButton", {
        Name = "Image",
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://74380920233260",
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ImageTransparency = 0.45,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(20, 16),
        Parent = sBtn,
    })

    local trailing = New("Frame", {
        Name = "Trailing",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        Parent = tbContent,
    })
    do
        New("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = trailing })
        New("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = trailing })
    end

    -- Corner clips for toolbar
    local ccR = New("Frame", { Name = "CornerClipRight", AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = titlebarColor, BackgroundTransparency = titlebarTrans, BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.new(0, 10, 0.5, 0), ZIndex = -1, Parent = titlebar })
    local ccL = New("Frame", { Name = "CornerClipLeft", AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = titlebarColor, BackgroundTransparency = titlebarTrans, BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(0, 10, 1, 0), ZIndex = -1, Parent = titlebar })

    -- ===== INTERACTIONS =====
    -- Drag
    local dragging = false
    local ds, bp
    topArea.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            ds = i.Position
            bp = body.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            body.Position = UDim2.new(bp.X.Scale, bp.X.Offset + d.X, bp.Y.Scale, bp.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Close
    wcButtons.Exit.MouseButton1Click:Connect(function()
        local tY = body.AbsoluteSize.Y * 2
        TweenService:Create(body, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, tY) }):Play()
        task.delay(0.25, function() gui:Destroy() end)
    end)

    -- Zoom
    local maxed = false
    local pSz, pPos
    wcButtons.Zoom.MouseButton1Click:Connect(function()
        maxed = not maxed
        if maxed then
            pSz = body.Size
            pPos = body.Position
            TweenService:Create(body, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0.5, 0.5) }):Play()
            TweenService:Create(bodyCorner, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { CornerRadius = UDim.new(0, 0) }):Play()
        else
            TweenService:Create(body, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = pSz or UDim2.fromOffset(850, 530), Position = pPos or UDim2.fromScale(0.5, 0.5) }):Play()
            TweenService:Create(bodyCorner, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { CornerRadius = UDim.new(0, 10) }):Play()
        end
    end)

    -- Minimize
    local mined = false
    wcButtons.Minimize.MouseButton1Click:Connect(function()
        mined = not mined
        local tY = mined and body.AbsoluteSize.Y * 2 or 0
        TweenService:Create(body, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, tY) }):Play()
        TweenService:Create(uiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Scale = mined and 0 or 1 }):Play()
    end)

    -- WindowPill click
    windowPill.MouseButton1Click:Connect(function()
        mined = not mined
        local tY = mined and body.AbsoluteSize.Y * 2 or 0
        TweenService:Create(body, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, tY) }):Play()
        TweenService:Create(uiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Scale = mined and 0 or 1 }):Play()
    end)

    local ct
    windowPill.MouseEnter:Connect(function()
        if ct then ct:Cancel() end
        ct = TweenService:Create(windowPill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { ImageTransparency = 0.15 })
        ct:Play()
    end)
    windowPill.MouseLeave:Connect(function()
        if ct then ct:Cancel() end
        ct = TweenService:Create(windowPill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { ImageTransparency = 0.5 })
        ct:Play()
    end)

    -- Sidebar toggle
    local sbVis = true
    sImg.MouseButton1Click:Connect(function()
        sbVis = not sbVis
        sep.Visible = sbVis
        local sSize = sbVis and UDim2.new(0, 200, 1, 0) or UDim2.new(0, 0, 1, 0)
        local cSize = sbVis and UDim2.new(1, -201, 1, 0) or UDim2.new(1, 0, 1, 0)
        local cSize2 = sbVis and UDim2.new(0, 10, 0.5, 0) or UDim2.new(0, 10, 0, 0)
        TweenService:Create(contentBody, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = cSize }):Play()
        TweenService:Create(sidebarMargins:FindFirstChild("UIPadding"), TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { PaddingLeft = sbVis and UDim.new(0, 0) or UDim.new(0, -200) }):Play()
        local t1 = TweenService:Create(sidebarMargins, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = sSize })
        TweenService:Create(ccL, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = cSize2 }):Play()
        t1:Play()
        if not sbVis then t1.Completed:Connect(function() cornerClip.Visible = false end) end
    end)

    -- Resize handles
    local hF = New("Folder", { Name = "Handles", Parent = gui })
    local hC = {
        { "E", Vector2.new(1, 0.5), UDim2.fromScale(1, 0.5), UDim2.new(0, 6, 1, 0), 8 },
        { "N", Vector2.new(0.5, 0), UDim2.fromScale(0.5, 0), UDim2.new(1, 0, 0, 6), 8 },
        { "NE", Vector2.new(1, 0), UDim2.fromScale(1, 0), UDim2.fromOffset(10, 10), 9 },
        { "NW", Vector2.new(0, 0), UDim2.fromScale(0, 0), UDim2.fromOffset(10, 10), 9 },
        { "S", Vector2.new(0.5, 1), UDim2.fromScale(0.5, 1), UDim2.new(1, 0, 0, 6), 8 },
        { "SE", Vector2.new(1, 1), UDim2.fromScale(1, 1), UDim2.fromOffset(10, 10), 9 },
        { "SW", Vector2.new(0, 1), UDim2.fromScale(0, 1), UDim2.fromOffset(10, 10), 9 },
        { "W", Vector2.new(0, 0.5), UDim2.fromScale(0, 0.5), UDim2.new(0, 6, 1, 0), 8 },
    }
    local mW = 350
    local mH = 250
    local sA, sO
    for _, h in ipairs(hC) do
        local f = New("Frame", { Name = h[1], AnchorPoint = h[2], BackgroundTransparency = 1, BorderSizePixel = 0, Position = h[3], Size = h[4], ZIndex = h[5], Parent = hF })
        local d = New("UIDragDetector", { Name = "UIDragDetector", ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset, SelectionModeDragSpeed = UDim2.new(), SelectionModeRotateSpeed = 0, Parent = f })
        d.DragStart:Connect(function() sA = body.AbsoluteSize; sO = Vector2.new(body.Position.X.Offset, body.Position.Y.Offset) end)
        d.DragContinue:Connect(function()
            local dV = Vector2.new(d.DragUDim2.X.Offset, d.DragUDim2.Y.Offset)
            local dn = h[1]
            local dv = Vector2.new(dn:find("E") and 1 or (dn:find("W") and -1 or 0), dn:find("S") and 1 or (dn:find("N") and -1 or 0))
            local n = Vector2.new(dv.X ~= 0 and dV.X * dv.X or 0, dv.Y ~= 0 and dV.Y * dv.Y or 0)
            local o = sA + n; o = Vector2.new(math.max(mW, o.X), math.max(mH, o.Y))
            local p = o - sA
            local q = Vector2.new(dv.X < 0 and -p.X * 0.5 or p.X * 0.5, dv.Y < 0 and -p.Y * 0.5 or p.Y * 0.5)
            local r = sO + q; body.Size = UDim2.fromOffset(o.X, o.Y); body.Position = UDim2.new(0.5, r.X, 0.5, r.Y)
        end)
    end

    -- ===== UI LIBRARY FUNCTIONS =====
    local pages = {}
    local currentPage = nil
    local pageMap = {}

    local function addPage(name, iconId)
        local pageId = HttpService:GenerateGUID(false)
        local btn = New("TextButton", {
            Name = name,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(10, 130, 255),
            BorderSizePixel = 0,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
            Size = UDim2.new(0, 180, 0, 28),
            Text = "",
            TextSize = 14,
            Parent = sidebarList,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 5), Parent = btn })
        local t = New("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            FontFace = font,
            Size = UDim2.new(1, -22, 0, 20),
            Text = name,
            TextSize = 15,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = btn,
        })

        -- Page content frame (hidden by default)
        local pageFrame = New("ScrollingFrame", {
            Name = name .. "Page",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            Visible = false,
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
            CanvasSize = UDim2.fromScale(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Parent = content,
        })
        New("UIPadding", { PaddingTop = UDim.new(0, 16), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), Parent = pageFrame })
        local pageLayout = New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Left, Parent = pageFrame })

        local page = { id = pageId, name = name, btn = btn, label = t, frame = pageFrame, layout = pageLayout, icon = iconId }
        table.insert(pages, page)
        pageMap[pageId] = page
        pageMap[name] = page

        btn.MouseButton1Click:Connect(function()
            switchToPage(pageId)
        end)
        btn.MouseEnter:Connect(function()
            if currentPage ~= pageId then
                btn.BackgroundTransparency = 0
            end
        end)
        btn.MouseLeave:Connect(function()
            if currentPage ~= pageId then
                btn.BackgroundTransparency = 1
            end
        end)

        if #pages == 1 then
            switchToPage(pageId)
        end

        return pageId
    end

    function switchToPage(pageId)
        local page = pageMap[pageId]
        if not page then return end
        currentPage = pageId
        for _, p in ipairs(pages) do
            p.frame.Visible = (p.id == pageId)
            p.btn.BackgroundTransparency = (p.id == pageId) and 0 or 1
            p.label.TextColor3 = (p.id == pageId) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        end
        titleText.Text = page.name
    end

    function findPage(pageId)
        if pageMap[pageId] then return pageMap[pageId] end
        return pageMap[pageId]
    end

    -- ===== SECTION =====
    local function addSection(pageId, title, subtitle)
        local page = pageMap[pageId]
        if not page then return end
        local section = New("Frame", {
            Name = "Section",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = page.frame,
        })
        New("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = section })
        local titleLbl = New("TextLabel", {
            Name = "Title",
            Text = title,
            FontFace = fontSemiBold,
            TextSize = 16,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 24),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = section,
        })
        if subtitle then
            New("TextLabel", {
                Name = "Subtitle",
                Text = subtitle,
                FontFace = font,
                TextSize = 12,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextTransparency = 0.55,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 18),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = section,
            })
        end
        return section
    end

    -- ===== LABEL =====
    local function addLabel(pageId, text, value, valueColor)
        local page = pageMap[pageId]
        if not page then return end
        local frame = New("Frame", {
            Name = "LabelRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 38),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        local lbl = New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0.6, -16, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        if value then
            local val = New("TextLabel", {
                Name = "Value",
                Text = value,
                FontFace = fontBold,
                TextSize = 13,
                TextColor3 = valueColor or Color3.fromRGB(10, 130, 255),
                TextTransparency = 0.15,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(0.4, -12, 1, 0),
                Position = UDim2.new(0.6, 4, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Parent = frame,
            })
        end
        return frame
    end

    -- ===== BUTTON =====
    local function addButton(pageId, text, btnText, callback)
        local page = pageMap[pageId]
        if not page then return end
        local frame = New("Frame", {
            Name = "ButtonRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        local lbl = New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -90, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        local btn = New("TextButton", {
            Name = "Button",
            Size = UDim2.fromOffset(70, 28),
            Position = UDim2.new(1, -82, 0.5, -14),
            BackgroundColor3 = Color3.fromRGB(0, 122, 255),
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Text = btnText or "Run",
            FontFace = fontSemiBold,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            AutoButtonColor = false,
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
        btn.MouseButton1Click:Connect(callback)
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(10, 132, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
        end)
        return frame
    end

    -- ===== TOGGLE =====
    local function addToggle(pageId, text, default, callback)
        local page = pageMap[pageId]
        if not page then return end
        local state = default or false

        local frame = New("Frame", {
            Name = "ToggleRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -70, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })

        local toggleBg = New("ImageButton", {
            Name = "Toggle",
            Size = UDim2.fromOffset(44, 24),
            Position = UDim2.new(1, -56, 0.5, -12),
            BackgroundColor3 = state and Color3.fromRGB(71, 140, 246) or Color3.fromRGB(58, 58, 60),
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = toggleBg })

        local knob = New("Frame", {
            Name = "Knob",
            Size = UDim2.fromOffset(20, 20),
            Position = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Parent = toggleBg,
        })
        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

        local updateToggle
        updateToggle = function(newState)
            state = newState
            toggleBg.BackgroundColor3 = state and Color3.fromRGB(71, 140, 246) or Color3.fromRGB(58, 58, 60)
            local target = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
            TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = target }):Play()
            if callback then callback(state) end
        end

        toggleBg.MouseButton1Click:Connect(function()
            updateToggle(not state)
        end)

        return { Frame = frame, Set = updateToggle, Get = function() return state end }
    end

    -- ===== SLIDER =====
    local function addSlider(pageId, text, min, max, default, suffix, callback)
        local page = pageMap[pageId]
        if not page then return end
        local value = default or min
        min = min or 0
        max = max or 100
        suffix = suffix or ""

        local frame = New("Frame", {
            Name = "SliderRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 56),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })

        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -70, 0, 22),
            Position = UDim2.fromOffset(12, 6),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })

        local valueLabel = New("TextLabel", {
            Name = "Value",
            Text = tostring(value) .. suffix,
            FontFace = font,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.45,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(60, 22),
            Position = UDim2.new(1, -72, 0, 5),
            TextXAlignment = Enum.TextXAlignment.Right,
            Parent = frame,
        })

        local track = New("Frame", {
            Name = "Track",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -28, 0, 4),
            Position = UDim2.fromOffset(14, 44),
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

        local fill = New("Frame", {
            Name = "Fill",
            BackgroundColor3 = Color3.fromRGB(0, 122, 255),
            BorderSizePixel = 0,
            Size = UDim2.fromScale((value - min) / (max - min), 1),
            Parent = track,
        })
        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })

        local dragging = false
        local function updateSlider(inputPos)
            local absPos = track.AbsolutePosition
            local absSize = track.AbsoluteSize.X
            local relX = math.clamp(inputPos.X - absPos.X, 0, absSize)
            local pct = relX / absSize
            value = math.floor(min + (max - min) * pct)
            fill.Size = UDim2.fromScale(pct, 1)
            valueLabel.Text = tostring(value) .. suffix
            if callback then callback(value) end
        end

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                updateSlider(input.Position)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input.Position)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        return { Frame = frame, Set = function(v) value = v; local p = (v - min) / (max - min); fill.Size = UDim2.fromScale(p, 1); valueLabel.Text = tostring(v) .. suffix end }
    end

    -- ===== DROPDOWN (PopUpButton style) =====
    local function addDropdown(pageId, text, options, default, callback)
        local page = pageMap[pageId]
        if not page then return end
        local selected = default or options[1] or ""

        local frame = New("Frame", {
            Name = "DropdownRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Parent = page.frame,
            ClipsDescendants = false,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -140, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })

        local dropdownBtn = New("TextButton", {
            Name = "Dropdown",
            Size = UDim2.fromOffset(120, 28),
            Position = UDim2.new(1, -132, 0.5, -14),
            BackgroundColor3 = Color3.fromRGB(55, 55, 58),
            BorderSizePixel = 0,
            Text = selected,
            FontFace = font,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            AutoButtonColor = false,
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = dropdownBtn })

        return { Frame = frame, Button = dropdownBtn }
    end

    -- ===== TEXTBOX =====
    local function addTextBox(pageId, text, placeholder, callback)
        local page = pageMap[pageId]
        if not page then return end

        local frame = New("Frame", {
            Name = "TextBoxRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -160, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })

        local box = New("TextBox", {
            Name = "TextBox",
            Size = UDim2.fromOffset(140, 28),
            Position = UDim2.new(1, -152, 0.5, -14),
            BackgroundColor3 = Color3.fromRGB(55, 55, 58),
            BorderSizePixel = 0,
            PlaceholderText = placeholder or "Enter...",
            PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
            FontFace = font,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            ClearTextOnFocus = false,
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = box })

        if callback then
            box.FocusLost:Connect(function(enterPressed)
                if enterPressed then callback(box.Text) end
            end)
        end

        return { Frame = frame, Box = box }
    end

    -- ===== KEYBIND =====
    local function addKeybind(pageId, text, default, callback)
        local page = pageMap[pageId]
        if not page then return end
        local keys = default or {"RightControl"}

        local frame = New("Frame", {
            Name = "KeybindRow",
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = frame })
        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -140, 1, 0),
            Position = UDim2.fromOffset(12, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })

        local keyBtn = New("TextButton", {
            Name = "Keybind",
            Size = UDim2.fromOffset(120, 28),
            Position = UDim2.new(1, -132, 0.5, -14),
            BackgroundColor3 = Color3.fromRGB(55, 55, 58),
            BorderSizePixel = 0,
            Text = table.concat(keys, " + "),
            FontFace = font,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            AutoButtonColor = false,
            Parent = frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = keyBtn })

        return { Frame = frame, Button = keyBtn }
    end

    -- ===== NOTIFICATION =====
    local notifStack = {}

    local function addNotification(title, text, duration, notifType)
        duration = duration or 4
        notifType = notifType or "info"
        local colors = {
            info = Color3.fromRGB(0, 122, 255),
            success = Color3.fromRGB(52, 199, 89),
            warning = Color3.fromRGB(255, 189, 46),
            error = Color3.fromRGB(255, 95, 87),
        }
        local color = colors[notifType] or colors.info

        local notif = New("Frame", {
            Name = "Notification",
            AnchorPoint = Vector2.new(1, 1),
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -20, 1, -20),
            Size = UDim2.fromOffset(325, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 100,
            ClipsDescendants = true,
            Parent = content,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 12), Parent = notif })

        -- Accent bar
        local accentBar = New("Frame", {
            Name = "Accent",
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 3),
            Parent = notif,
        })

        -- Content
        local notifContent = New("Frame", {
            Name = "Content",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -24, 0, 0),
            Position = UDim2.fromOffset(12, 12),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = notif,
        })
        New("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = notifContent })
        New("TextLabel", {
            Name = "Title",
            Text = title,
            FontFace = fontBold,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 20),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
            Parent = notifContent,
        })
        New("TextLabel", {
            Name = "Text",
            Text = text,
            FontFace = font,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.45,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 18),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            RichText = true,
            Parent = notifContent,
        })

        -- Close button
        local closeBtn = New("ImageButton", {
            Name = "Exit",
            AnchorPoint = Vector2.new(1, 0),
            AutoButtonColor = false,
            BackgroundColor3 = Color3.fromRGB(44, 44, 46),
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -4, 0, 4),
            Size = UDim2.fromOffset(18, 18),
            ZIndex = 101,
            Parent = notif,
        })
        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = closeBtn })
        New("ImageLabel", {
            Name = "Icon",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = "rbxassetid://72660323302468",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 0.5,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(12, 12),
            Parent = closeBtn,
        })

        -- Entry animation
        notif.Position = UDim2.new(1, -20, 1, 50)
        notif.BackgroundTransparency = 1
        for _, v in pairs(notif:GetDescendants()) do
            if v:IsA("TextLabel") then v.TextTransparency = 1 end
            if v:IsA("ImageLabel") then v.ImageTransparency = 1 end
        end

        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { BackgroundTransparency = 0.1, Position = UDim2.new(1, -20, 1, -20) }):Play()
        task.delay(0.1, function()
            for _, v in pairs(notif:GetDescendants()) do
                if v:IsA("TextLabel") then TweenService:Create(v, TweenInfo.new(0.3), { TextTransparency = v.Name == "Title" and 0.15 or 0.45 }):Play() end
                if v:IsA("ImageLabel") then TweenService:Create(v, TweenInfo.new(0.3), { ImageTransparency = 0.5 }):Play() end
            end
        end)

        closeBtn.MouseButton1Click:Connect(function()
            local out = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), { BackgroundTransparency = 1, Position = UDim2.new(1, -20, 1, 50) })
            out:Play()
            out.Completed:Connect(function() notif:Destroy() end)
        end)

        task.delay(duration, function()
            if notif.Parent then
                local out = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), { BackgroundTransparency = 1, Position = UDim2.new(1, -20, 1, 50) })
                out:Play()
                out.Completed:Connect(function() notif:Destroy() end)
            end
        end)

        return notif
    end

    -- ===== SEPARATOR =====
    local function addSeparator(pageId)
        local page = pageMap[pageId]
        if not page then return end
        return New("Frame", {
            Name = "Separator",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -20, 0, 1),
            Position = UDim2.fromOffset(10, 0),
            Parent = page.frame,
        })
    end

    -- ===== NAV BUTTONS =====
    local function addNavButton(pageId, text, iconId)
        local page = pageMap[pageId]
        if not page then return end
        local btn = New("TextButton", {
            Name = text,
            AutoButtonColor = false,
            BackgroundColor3 = Color3.fromRGB(60, 60, 62),
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 36),
            Parent = page.frame,
        })
        New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
        if iconId then
            New("ImageLabel", {
                Name = "Icon",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromOffset(16, 16),
                Position = UDim2.fromOffset(10, 10),
                Image = iconId,
                ImageColor3 = Color3.fromRGB(255, 255, 255),
                ImageTransparency = 0.45,
                Parent = btn,
            })
        end
        New("TextLabel", {
            Name = "Label",
            Text = text,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.15,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -36, 1, 0),
            Position = UDim2.fromOffset(36, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = btn,
        })
        return btn
    end

    -- ===== DEMO: POPULATE PAGES =====
    local pStandards = addPage("Standards", "rbxassetid://91422740186540")
    local pInfo = addPage("Info", "rbxassetid://119759031878732")
    local pSettings = addPage("Settings", "rbxassetid://80354232922163")
    local pComponents = addPage("Components", "rbxassetid://127198494730912")
    local pNotifs = addPage("Notifications", "rbxassetid://89160897049902")

    -- STANDARDS PAGE
    addSection(pStandards, "Executor Validation", "Run standards compliance tests against your executor")
    addLabel(pStandards, "Myriad Version", "v1.6.3")
    addLabel(pStandards, "Executor", identifyexecutor and identifyexecutor() or "Unknown")
    addLabel(pStandards, "Identity", tostring(getthreadidentity and getthreadidentity() or "N/A"))
    addButton(pStandards, "Run All Standards", "Run", function()
        addNotification("Running Tests", "Starting Myriad standards validation...", 2, "info")
        local p = 0
        for i = 1, 10 do
            task.wait(0.2)
            p = i * 10
        end
        addNotification("Complete", "All 10/10 standards tests passed!", 4, "success")
    end)
    addButton(pStandards, "Quick Test", "Test", function()
        addNotification("Quick Test", "Basic validation passed.", 3, "success")
    end)

    addSection(pStandards, "Quick Stats")
    addLabel(pStandards, "Game", game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown")
    addLabel(pStandards, "Place ID", tostring(game.PlaceId))
    addLabel(pStandards, "Player", LP.DisplayName .. " (" .. LP.Name .. ")")

    -- INFO PAGE
    addSection(pInfo, "About Myriad")
    addLabel(pInfo, "A general standardization compliance test suite for Robluau executors.")
    addLabel(pInfo, "Tests include: identity, closures, instances, HTTP, crypto, WebSocket, virtual input, and more.")

    addSection(pInfo, "System Information")
    addLabel(pInfo, "Version", "v1.6.3")
    addLabel(pInfo, "Build", "Release")
    addLabel(pInfo, "Accent", "Blue")

    addSection(pInfo, "Text Input Demo")
    addTextBox(pInfo, "Username", "Enter username...", function(text)
        addNotification("Username", "Set to: " .. text, 3, "info")
    end)
    addTextBox(pInfo, "API Endpoint", "https://myriad.tools", function(text)
        addNotification("API", "Endpoint updated!", 3, "success")
    end)

    -- SETTINGS PAGE
    addSection(pSettings, "Appearance", "Customize the look and feel of Myriad")
    local themeToggle = addToggle(pSettings, "Dark Mode", true, function(state)
        addNotification("Theme", state and "Dark mode enabled" or "Light mode enabled", 2, "info")
    end)
    addDropdown(pSettings, "Accent Color", {"Blue", "Purple", "Pink", "Red", "Orange", "Yellow", "Green", "Graphite"}, "Blue", function(opt)
        addNotification("Accent", "Changed to " .. opt, 2, "info")
    end)

    addSection(pSettings, "Display", "Configure UI display settings")
    addToggle(pSettings, "Show Grid", false, function(state)
        addNotification("Grid", state and "Grid shown" or "Grid hidden", 2, "info")
    end)
    addSlider(pSettings, "UI Scale", 50, 150, 100, "%", function(v)
        uiScale.Scale = v / 100
    end)
    addSlider(pSettings, "Test Timeout", 1, 30, 10, "s")

    addSection(pSettings, "Input", "Configure keyboard shortcuts")
    addKeybind(pSettings, "Toggle Menu", {"RightControl"}, function(keys)
        addNotification("Keybind", "Set to " .. table.concat(keys, " + "), 2, "info")
    end)

    addSection(pSettings, "Advanced")
    addToggle(pSettings, "Window Pill", true, function(state)
        windowPill.Visible = state
    end)
    addToggle(pSettings, "Resizable", true)
    addToggle(pSettings, "Background Blur", false)
    addButton(pSettings, "Reset All Settings", "Reset", function()
        addNotification("Reset", "All settings restored to defaults.", 3, "warning")
    end)

    -- COMPONENTS PAGE - Show every UI element
    addSection(pComponents, "Buttons", "Various button styles")
    addButton(pComponents, "Primary Action", "Go", function()
        addNotification("Button", "Primary action clicked!", 2, "success")
    end)
    addButton(pComponents, "Secondary Action", "Stop", function()
        addNotification("Button", "Secondary action clicked!", 2, "error")
    end)

    addSection(pComponents, "Toggles", "On/off switches")
    local t1 = addToggle(pComponents, "Wi-Fi", true, function(s) print("Wi-Fi:", s) end)
    local t2 = addToggle(pComponents, "Bluetooth", false, function(s) print("Bluetooth:", s) end)
    local t3 = addToggle(pComponents, "AirDrop", false, function(s) print("AirDrop:", s) end)
    addButton(pComponents, "Toggle All On", "On", function()
        t1:Set(true); t2:Set(true); t3:Set(true)
        addNotification("Toggles", "All toggled ON", 2, "success")
    end)
    addButton(pComponents, "Toggle All Off", "Off", function()
        t1:Set(false); t2:Set(false); t3:Set(false)
        addNotification("Toggles", "All toggled OFF", 2, "warning")
    end)

    addSection(pComponents, "Sliders", "Draggable range controls")
    addSlider(pComponents, "Volume", 0, 100, 75, "%", function(v)
        print("Volume:", v)
    end)
    addSlider(pComponents, "Brightness", 0, 100, 50, "%", function(v)
        print("Brightness:", v)
    end)
    addSlider(pComponents, "Speed", 0.1, 10, 2.5, "x", function(v)
        print("Speed:", v)
    end)

    addSection(pComponents, "Dropdowns", "Selection menus")
    addDropdown(pComponents, "Mode", {"Normal", "Turbo", "Stealth", "Eco"}, "Normal", function(opt)
        print("Mode:", opt)
    end)
    addDropdown(pComponents, "Resolution", {"720p", "1080p", "1440p", "4K"}, "1080p", function(opt)
        print("Resolution:", opt)
    end)
    addDropdown(pComponents, "Theme Preset", {"System", "Dark", "Light"}, "Dark", function(opt)
        print("Theme:", opt)
    end)

    addSection(pComponents, "Text Input", "Text entry fields")
    addTextBox(pComponents, "Search", "Type to search...", function(text)
        addNotification("Search", "Searching for: " .. text, 2, "info")
    end)
    addTextBox(pComponents, "Command", "Enter command...", function(text)
        addNotification("Command", "Executing: " .. text, 2, "info")
    end)

    addSection(pComponents, "Keybinds", "Keyboard shortcut capture")
    addKeybind(pComponents, "Run Test", {"Control", "Shift", "S"})
    addKeybind(pComponents, "Quick Action", {"Control", "Shift", "Q"})
    addKeybind(pComponents, "Toggle UI", {"RightControl"})

    addSection(pComponents, "Labels & Info", "Information display")
    addLabel(pComponents, "Status", "Online", Color3.fromRGB(52, 199, 89))
    addLabel(pComponents, "Ping", "24ms", Color3.fromRGB(0, 122, 255))
    addLabel(pComponents, "Data", "1.2 GB used", Color3.fromRGB(255, 189, 46))

    -- NOTIFICATIONS PAGE
    addSection(pNotifs, "Notification Types", "Test all notification styles")
    addButton(pNotifs, "Info Notification", "Show", function()
        addNotification("Info Title", "This is an informational message that provides details about an operation.", 4, "info")
    end)
    addButton(pNotifs, "Success Notification", "Show", function()
        addNotification("Success!", "Operation completed successfully with no errors.", 4, "success")
    end)
    addButton(pNotifs, "Warning Notification", "Show", function()
        addNotification("Warning", "Something requires your attention. Please review.", 4, "warning")
    end)
    addButton(pNotifs, "Error Notification", "Show", function()
        addNotification("Error", "Something went wrong. Please try again.", 4, "error")
    end)
    addButton(pNotifs, "Show All At Once", "Show", function()
        addNotification("Info", "First notification.", 3, "info")
        task.wait(0.2)
        addNotification("Success", "Second notification.", 3, "success")
        task.wait(0.2)
        addNotification("Warning", "Third notification.", 3, "warning")
        task.wait(0.2)
        addNotification("Error", "Fourth notification.", 3, "error")
    end)

    addSection(pNotifs, "Duration Test")
    addButton(pNotifs, "Short (2s)", "Show", function()
        addNotification("Quick", "This will auto-close in 2s.", 2, "info")
    end)
    addButton(pNotifs, "Long (8s)", "Show", function()
        addNotification("Longer", "This notification stays for 8 seconds.", 8, "warning")
    end)
    addButton(pNotifs, "Persistent (30s)", "Show", function()
        addNotification("Persistent", "This stays for 30 seconds or until closed.", 30, "info")
    end)

    -- Window pill update
    addNotification("Myriad v1.6.3", "Complete UI demo loaded. Press RightControl to toggle.", 5, "info")

    -- Keybind to toggle window
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            window.Visible = not window.Visible
        end
    end)

    -- Layout fix (like original)
    task.spawn(function()
        task.wait(0.1)
        for _, d in ipairs(body:GetDescendants()) do
            pcall(function()
                if d:IsA("Frame") or d:IsA("ScrollingFrame") then
                    local s = d.Size; d.Size = UDim2.fromOffset(0, 0); d.Size = s
                end
            end)
        end
    end)

    print("Myriad v1.6.3 Ultimate UI loaded. Press RightControl to toggle visibility.")
end
