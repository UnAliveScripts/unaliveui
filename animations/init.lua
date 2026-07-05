local TweenService = game:GetService("TweenService")

local presets = {
    iOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
    },
    iPadOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
    },
    macOS26 = {
        Spring = function(d) return TweenInfo.new(d or 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) end,
        Smooth = function(d) return TweenInfo.new(d or 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) end,
        Slide = function(d) return TweenInfo.new(d or 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out) end,
        Press = function(d) return TweenInfo.new(d or 0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end,
    },
}

local Animate = { Presets = presets, Platform = "iOS26" }

function Animate:Tween(obj, props, style, d)
    style = style or "Smooth"
    local p = presets[self.Platform]
    local info = (p[style] or p.Smooth)(d)
    local t = TweenService:Create(obj, info, props)
    t:Play(); return t
end

function Animate:Spring(o, p, d) return self:Tween(o, p, "Spring", d) end
function Animate:Slide(o, p, d) return self:Tween(o, p, "Slide", d) end

return Animate