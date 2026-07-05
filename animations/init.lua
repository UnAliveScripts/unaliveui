local TweenService = game:GetService("TweenService")

local presets = {
    iOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Release = function(d) return TweenInfo.new(d or 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
    },
    iPadOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Release = function(d) return TweenInfo.new(d or 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
    },
    macOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Release = function(d) return TweenInfo.new(d or 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) end,
    },
}

local Animate = { Presets = presets, Platform = "iOS26", StyleFidelity = 1.0 }

function Animate:Tween(obj, props, style, d)
    style = style or "Smooth"
    local info = (presets[self.Platform][style] or presets.iOS26.Smooth)(d)
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

function Animate:Spring(obj, props, d) return self:Tween(obj, props, "Spring", d) end
function Animate:Slide(obj, props, d) return self:Tween(obj, props, "Slide", d) end
function Animate:PressIn(obj) return self:Tween(obj, { BackgroundTransparency = 0.75 }, "Press") end
function Animate:PressOut(obj) return self:Tween(obj, { BackgroundTransparency = 1 }, "Release") end
function Animate:ScaleIn(obj, d) obj.Scale = 0.85; return self:Tween(obj, { Scale = 1 }, "Spring", d) end
function Animate:ScaleOut(obj, d) obj.Scale = 1; return self:Tween(obj, { Scale = 0.85 }, "Smooth", d) end
function Animate:FadeIn(obj, d) obj.BackgroundTransparency = 1; return self:Tween(obj, { BackgroundTransparency = 0 }, "Smooth", d) end
function Animate:FadeOut(obj, d) return self:Tween(obj, { BackgroundTransparency = 1 }, "Smooth", d) end

return Animate