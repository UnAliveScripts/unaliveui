# Change Log

## v2.0.0 (Unreleased)

### Added
- Complete refactor into CascadeUI-style `src/` structure
- Full mkdocs-material documentation site with 22 pages
- GitHub Actions workflow for auto-deploying docs to Pages
- `WindowPill` component with Myriad-style minimize
- `Notification` component with title, subtitle, accent types
- `Stepper`, `StepperPill` increment/decrement controls
- `EditMenu` tabbed glass-style menu bar
- `Row` labeled info display component
- `Pulldown` dropdown menu component
- `TrailingAccessories` component for trailing UI elements
- Theme system with Dark theme
- Blur effect module with DepthOfField
- Animation module with minimize, pill glow, button press utilities

### Changed
- Codebase fully refactored with descriptive identifiers
- Components now return `{ Type, Instance, ... }` consistent interface
- All components support standalone `Parent` property
- Consistent error handling via pcall wrappers

### Fixed
- Removed all obfuscated identifier names
- Fixed syntax errors from obfuscation
- Removed dead code and unreachable paths
