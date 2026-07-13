export type Component = {
	Type: string,
	__instance: Instance,
	Parent: (self: Component, parent: Instance) -> (),
	Destroy: (self: Component) -> (),
}

export type App = {
	Window: (self: App, properties: WindowProperties?) -> Component,
	Notify: (self: App, properties: NotificationProperties?) -> Component,
	Destroy: (self: App) -> (),
}

export type WindowProperties = {
	Title: string?,
	Size: Vector2?,
	TitleBar: boolean?,
	Minimize: boolean?,
	Close: boolean?,
}

export type ToggleProperties = {
	Label: string?,
	Value: boolean?,
	OnChange: ((value: boolean) -> ())?,
}

export type SliderProperties = {
	Label: string?,
	Min: number?,
	Max: number?,
	Value: number?,
	OnChange: ((value: number) -> ())?,
}

export type ButtonProperties = {
	Label: string?,
	State: "Primary" | "Secondary" | "Destructive"?,
	Pushed: ((self: Component) -> ())?,
}

export type TextFieldProperties = {
	Placeholder: string?,
	Text: string?,
	Width: number?,
	OnSubmit: ((text: string) -> ())?,
}

export type NotificationProperties = {
	Title: string?,
	Text: string?,
	Duration: number?,
	Type: "info" | "success" | "warning" | "error"?,
}

export type Theme = {
	_id: string,
	Body: { Color3, number },
	TitleBar: { Color3, number },
	Content: { Color3, number },
	Text: {
		Primary: { Color3, number },
		Secondary: { Color3, number },
		Selection: { Color3, number },
	},
	Accent: Color3,
	Card: Color3,
	Border: Color3,
}
