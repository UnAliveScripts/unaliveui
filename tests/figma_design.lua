--[[
    UnAliveUI — Figma Design Reference
    
    Complete UI design exported from Figma.
    All dimensions, colors, and positions documented per page.
    
    Figma: https://www.figma.com/design/iLqZemyfJ3MD86tZsgfWS0/
--]]

return {
    Window = {
        Width = 540,
        Height = 400,
        Background = "#0C0C0E",
        CornerRadius = 16,
        Border = "#222228",
        BorderThickness = 1,
        Shadow = { Enabled = true, Transparency = 0.65 },
        
        TitleBar = {
            Height = 34,
            Background = "#101013",
            Hairline = "#24242A",
            Text = "UnAlive",
            TextColor = "#BEBEC6",
            TextSize = 14,
            TextLeft = 14,
            Dots = {
                { Name = "Exit", Color = "#FF5F57", X = 512, Y = 11, Size = 12 },
                { Name = "Minimize", Color = "#FEBC2E", X = 494, Y = 11, Size = 12 },
            },
        },
        
        Card = {
            Width = 496,
            Height = 280,
            X = 22,
            Y = 52,
            Background = "#141418",
            Border = "#26262E",
            BorderThickness = 1,
            CornerRadius = 16,
        },
        
        SearchBar = {
            Width = 122,
            Height = 26,
            X = 365,
            Y = 10,
            Background = "#12141A",
            CornerRadius = 13,
            Icon = "rbxassetid://117204739779559",
            Placeholder = "Search",
        },
        
        Pages = {
            Width = 496,
            Height = 200,
            X = 0,
            Y = 50,
            Items = {
                { Name = "Farm", Desc = "Manage your farm resources and crops" },
                { Name = "Shop", Desc = "Browse items available for purchase" },
                { Name = "Steal", Desc = "Steal resources from other players" },
                { Name = "Spawn", Desc = "Spawn vehicles, items, and more" },
                { Name = "Config", Desc = "Configure your settings and preferences" },
                { Name = "Settings", Desc = "Adjust your application settings and preferences" },
            },
        },
        
        EditMenu = {
            Width = 488,
            Height = 44,
            X = 4,
            Y = 276,
            Background = "#0C0E12",
            CornerRadius = 34,
            GlassBorder = "#FFFFFF",
            GlassBorderTransparency = 0.88,
            Tabs = {
                { Name = "Farm", X = 20, Width = 50, Selected = true },
                { Name = "Shop", X = 87, Width = 68, Separator = true },
                { Name = "Steal", X = 155, Width = 67, Separator = true },
                { Name = "Spawn", X = 222, Width = 78, Separator = true },
                { Name = "Config", X = 300, Width = 77, Separator = true },
                { Name = "Settings", X = 377, Width = 88, Separator = true },
            },
            SelectedTextColor = "#FF4254",
            NormalTextColor = "#F5F5F5",
        },
        
        WindowPill = {
            Width = 180,
            Height = 5,
            X = 180,
            Y = 10,
            Color = "#F5F5F5",
            Transparency = 0.5,
            CornerRadius = 2.5,
        },
    },
    
    -- Individual page screens
    Screens = {
        Farm = {
            Title = "Farm",
            Description = "Manage your farm resources and crops",
            Gag2Controls = {
                TopToggleLabels = { "Expand", "Daily", "Pot" },
                Sections = {
                    "PLANT / HARVEST / SELL",
                    "BOOSTS",
                    "PETS & OPEN",
                },
            },
        },
        Shop = {
            Title = "Shop",
            Description = "Browse items available for purchase",
        },
        Steal = {
            Title = "Steal",
            Description = "Steal resources from other players",
        },
        Spawn = {
            Title = "Spawn",
            Description = "Spawn vehicles, items, and more",
        },
        Config = {
            Title = "Config",
            Description = "Configure your settings and preferences",
        },
        Settings = {
            Title = "Settings",
            Description = "Adjust your application settings and preferences",
        },
    },
    
    -- Color palette (matches Roblox Color3 values)
    Colors = {
        Background = Color3.fromRGB(12, 12, 14),
        TitleBar = Color3.fromRGB(16, 16, 19),
        Card = Color3.fromRGB(20, 20, 24),
        CardBorder = Color3.fromRGB(38, 38, 46),
        Text = Color3.fromRGB(245, 245, 245),
        Muted = Color3.fromRGB(180, 180, 190),
        Accent = Color3.fromRGB(255, 66, 84),
        Selected = Color3.fromRGB(255, 66, 84),
        Dark = Color3.fromRGB(18, 20, 26),
        White = Color3.fromRGB(255, 255, 255),
        Exit = Color3.fromHex("FF5F57"),
        Minimize = Color3.fromHex("FEBC2E"),
    },
}
