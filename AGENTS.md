# Relva Studio & MAPOTECH Workspace Guidelines (AGENTS.md)

This file defines the strict UI/UX architecture and coding guidelines for all AI agents working on the Relva Studio & MAPOTECH web codebase.

---

## 1. Zero External UI Packages Rule

- **STRICT PROHIBITION**: Never install or import third-party UI component libraries (e.g. `getwidget`, `flutter_bootstrap`, `shadcn_flutter`, `velocity_x`, `fluent_ui`, `flutter_staggered_animations`, third-party button packs, modal packages, carousel kits, or icon packs).
- **EXCEPTIONS ONLY FOR ESSENTIAL NON-UI EXTERNAL INTEGRATIONS**:
  - **Map SDKs**: (e.g. `google_maps_flutter`, `flutter_map`)
  - **Payment Gateways**: (e.g. `midtrans_snap`, `stripe_payment`, `xendit`)
- **CUSTOM COMPONENT REQUIREMENT**:
  Any new UI pattern (modals, dropdowns, segmented controls, timeline views, stats counters, badges, data tables, custom inputs) **MUST be written as custom Flutter code** inside `relva_studio/lib/relvastudio/widgets/` or local feature folders using native Flutter widgets (`StatefulWidget`, `StatelessWidget`, `CustomPainter`, `AnimationController`, etc.).

---

## 2. Design System & Aesthetic Standard (REV Palette)

All new screens, sections, and widgets must match the signature Relva Studio & MAPOTECH visual language:

### Color Tokens (Access via `AppSettingsProvider.of(context)`)
- **Light Theme**:
  - Primary: `Color(0xFF9B6DD6)` (Purple)
  - Background: `Color(0xFFF8F4FF)` (Lavender)
  - Surface: `Color(0xFFEEE6FF)`
  - Card: `Color(0xFFFFFFFF)` (White)
  - Text: `Color(0xFF3D1F7A)` (Deep Purple)
  - SubText: `Color(0xFF7A5BAD)`
  - Accent: `Color(0xFFF0C4DD)` (Soft Pink)
  - Gradients: `[#D8B4FE, #F9A8D4]`
- **Dark Theme**:
  - Primary: `Color(0xFFCBA8F0)` (Soft Light Purple)
  - Background: `Color(0xFF130D1F)` (Dark Violet-Black)
  - Surface: `Color(0xFF1E1430)`
  - Card: `Color(0xFF261A3D)`
  - Text: `Color(0xFFF0E8FF)` (Lavender White)
  - SubText: `Color(0xFFAA90D4)`
  - Accent: `Color(0xFFD4608A)` (Muted Pink)
  - Gradients: `[#1A0D2E, #2D1052]`
- **Alpha Rule**: Always use `.withValues(alpha: ...)` for transparency (never deprecated `.withOpacity`).

### Surfaces, Radii & Shadows
- **Card Radius**: `BorderRadius.circular(16)` to `BorderRadius.circular(24)` (feature cards: `20`).
- **Borders**: Translucent accent borders `settings.primaryColor.withValues(alpha: 0.12)` to `0.2`.
- **Shadows**: Soft atmospheric drop shadows (`blurRadius: 15-32`, `offset: Offset(0, 4-8)`, `alpha: 0.05-0.10`).
- **Glassmorphism**: Use `BackdropFilter` with `ImageFilter.blur(sigmaX: 18, sigmaY: 18)` for navigation and floating panels.
- **Ambient Glow**: Background breathing glow spheres (`BreathingBlob`).

### Animation & Micro-Interactions
- **Entrance Animation**: Wrap cards, hero sections, and headers with `FadeInSlide` (`duration`, `delay`, `offset`).
- **Hover Reaction**: Wrap cards and clickable elements with `HoverCard` (`hoverOffset: -6.0` to `-8.0`, `hoverScale: 1.02` to `1.04`).
- **Numbers & Metrics**: Use `AnimatedCounter` for statistics.

---

## 3. Responsive Web Layout Framework

- **Standard Template**: Wrap all full-page views with `ResponsivePageTemplate`.
- **Breakpoints**:
  - Mobile: `<= 600`
  - Tablet: `> 600 && <= 1024`
  - Desktop: `> 1024`
- **Helper**: Use `ResponsiveLayout.value(context, mobile: ..., tablet: ..., desktop: ...)`.

---

## 4. Theme & Bilingual Integration

- State: Every page must observe `AppSettingsProvider.of(context)` via `ListenableBuilder`.
- Language: Every page must support English (`AppLanguage.en`) and Indonesian (`AppLanguage.id`).

