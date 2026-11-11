# UI Design System & Component Guidelines

## Absolute Golden Rule: Zero External UI Libraries
- Do not import external UI component packages (no getwidget, bootstrap, shadcn, etc.).
- The only permitted external dependencies are strictly functional engines: Maps (`google_maps_flutter`, `flutter_map`) and Payments (`midtrans`, `stripe`).
- Any new UI component must be built custom from scratch in Dart/Flutter.

## Design Aesthetic (REV Palette)
- **Palette**: Use `AppSettingsProvider.of(context)` for colors (light purple/lavender in light mode, deep violet-black in dark mode).
- **Cards**: `BorderRadius.circular(20)`, subtle 1-1.5px border with alpha 0.1-0.2, soft drop shadow (`blurRadius: 15-32`).
- **Effects**: Glassmorphism with `BackdropFilter(sigma: 18)`, `BreathingBlob` background spheres.
- **Animations**: `FadeInSlide` for entrances, `HoverCard` for hover elevation/scale, `AnimatedCounter` for statistics.
- **Responsive**: `ResponsiveLayout` with breakpoints at 600px and 1024px.
- **Localization**: Support EN (`AppLanguage.en`) and ID (`AppLanguage.id`).

