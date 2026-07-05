local TweenService = game:GetService("TweenService")

local presets = {
    iOS26 = {
        Spring = function(duration)
            return TweenInfo.new(duration or 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end,
        Smooth = function(duration)
            return TweenInfo.new(duration or 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        end,
        Slide = function(duration)
            return TweenInfo.new(duration or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        end,
        Press = function(duration)
            return TweenInfo.new(duration or 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        end,
        Release = function(duration)
            return TweenInfo.new(duration or 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end,
    },
    iPadOS26 = {
        Spring = function(duration)
            return TweenInfo.new(duration or 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end,
        Smooth = function(duration)
            return TweenInfo.new(duration or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        end,
        Slide = function(duration)
            return TweenInfo.new(duration or 0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        end,
        Press = function(duration)
            return TweenInfo.new(duration or 0.12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        end,
        Release = function(duration)
            return TweenInfo.new(duration or 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end,
    },
    macOS26 = {
        Spring = function(duration)
            return TweenInfo.new(duration or 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        end,
        Smooth = function(duration)
            return TweenInfo.new(duration or 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        end,
        Slide = function(duration)
            return TweenInfo.new(duration or 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        end,
        Press = function(duration)
            return TweenInfo.new(duration or 0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        end,
        Release = function(duration)
            return TweenInfo.new(duration or 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        end,
    },
}

local Animate = {
    Presets = presets,
    Platform = "iOS26",
    StyleFidelity = 1.0,
}

function Animate:Tween(obj, props, style, duration)
    style = style or "Smooth"
    local platform = presets[self.Platform]
    local info = platform[style] and platform[style](duration)
        or TweenInfo.new(duration or 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

function Animate:Spring(obj, props, duration)
    return self:Tween(obj, props, "Spring", duration)
end

function Animate:Slide(obj, props, duration)
    return self:Tween(obj, props, "Slide", duration)
end

function Animate:PressIn(obj)
    return self:Tween(obj, { BackgroundTransparency = 0.75 }, "Press")
end

function Animate:PressOut(obj)
    return self:Tween(obj, { BackgroundTransparency = 1 }, "Release")
end

function Animate:ScaleIn(obj, duration)
    obj.Scale = 0.85
    return self:Tween(obj, { Scale = 1 }, "Spring", duration)
end

function Animate:ScaleOut(obj, duration)
    obj.Scale = 1
    return self:Tween(obj, { Scale = 0.85 }, "Smooth", duration)
end

function Animate:FadeIn(obj, duration)
    obj.BackgroundTransparency = 1
    return self:Tween(obj, { BackgroundTransparency = 0 }, "Smooth", duration)
end

function Animate:FadeOut(obj, duration)
    return self:Tween(obj, { BackgroundTransparency = 1 }, "Smooth", duration)
end

return Animate