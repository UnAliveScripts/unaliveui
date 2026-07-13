local TweenService = game:GetService("TweenService")

local Animation = {}

function Animation.Minimize(target, uiScale, isMinimized)
	local targetY = isMinimized and target.AbsoluteSize.Y * 2 or 0
	TweenService:Create(
		target,
		TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0.5, 0, 0.5, targetY) }
	):Play()
	TweenService:Create(
		uiScale,
		TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		{ Scale = isMinimized and 0 or 1 }
	):Play()
end

function Animation.PillGlow(pill, hovering)
	local targetTransparency = hovering and 0.15 or 0.5
	TweenService:Create(
		pill,
		TweenInfo.new(0.4, Enum.EasingStyle.Exponential),
		{ ImageTransparency = targetTransparency }
	):Play()
end

function Animation.ButtonPress(button, scale)
	TweenService:Create(
		button,
		TweenInfo.new(0.15, Enum.EasingStyle.Back),
		{ Scale = scale or 0.92 }
	):Play()
end

function Animation.ButtonRelease(button)
	TweenService:Create(
		button,
		TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Scale = 1 }
	):Play()
end

function Animation.FadeIn(instance, duration)
	TweenService:Create(
		instance,
		TweenInfo.new(duration or 0.3),
		{ BackgroundTransparency = 0 }
	):Play()
end

function Animation.FadeOut(instance, duration)
	TweenService:Create(
		instance,
		TweenInfo.new(duration or 0.3),
		{ BackgroundTransparency = 1 }
	):Play()
end

function Animation.SlideIn(frame, targetPosition, duration)
	TweenService:Create(
		frame,
		TweenInfo.new(duration or 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		{ Position = targetPosition }
	):Play()
end

return Animation
