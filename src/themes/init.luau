local Themes = {
	Dark = require(script.Dark),
	Light = require(script.Light),
	Accents = require(script.accents),
}

function Themes.Get(name)
	return Themes[name] or Themes.Dark
end

function Themes.ApplyAccent(theme, accent)
	theme = table.clone(theme)
	theme.Accent = accent or theme.Accent
	return theme
end

return Themes
