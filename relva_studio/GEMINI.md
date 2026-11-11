# Relva Studio — Project Context & Coding Rules

This repository contains the web application for **Relva Studio** and its healthcare platform **MAPOTECH**, built with Flutter Web and multiplatform support.

---

## 🚨 MANDATORY ARCHITECTURAL RULES

### 1. Zero External UI Libraries Policy
- **DO NOT IMPORT OR ADD ANY THIRD-PARTY UI LIBRARIES** (e.g. `getwidget`, `flutter_bootstrap`, `shadcn_flutter`, `velocity_x`, `fluent_ui`, `flutter_staggered_animations`, third-party button packs, modal kits, card libraries, or UI components).
- **ONLY PERMITTED EXTERNAL DEPENDENCIES**:
  - **Map SDKs / Geo** (e.g., `google_maps_flutter`, `flutter_map`, `latlong2`).
  - **Payment Gateways** (e.g., `midtrans_snap`, `stripe_payment`, `xendit`).
  - Essential utilities already present in `pubspec.yaml` (`url_launcher`, `http`, `crypto`, `carousel_slider`).
- **CUSTOM COMPONENT REQUIREMENT**:
  Whenever a new UI component, pattern, or widget is needed (cards, modals, badges, segmented buttons, tabs, accordions, toast notifications, date pickers, kanban, or dashboards), **YOU MUST BUILD IT MANUALLY** using Flutter core widgets (`StatefulWidget`, `StatelessWidget`, `CustomPainter`, `AnimationController`, `MouseRegion`, `Stack`, `Container`, etc.) in `lib/relvastudio/widgets/` or local module folders.

---

## 🎨 DESIGN SYSTEM & STYLING RULES (REV PALETTE)

Every new screen, widget, dialog, or UI component MUST perfectly match the current visual style of Relva Studio & MAPOTECH:

### 1. Colors & Tokens
Always query `AppSettingsProvider.of(context)`:
- **Light Theme**:
  - `primaryColor`: `Color(0xFF9B6DD6)` (Light Purple)
  - `backgroundColor`: `Color(0xFFF8F4FF)` (Very light lavender)
  - `surfaceColor`: `Color(0xFFEEE6FF)`
  - `cardColor`: `Color(0xFFFFFFFF)` (Card white)
  - `textColor`: `Color(0xFF3D1F7A)` (Deep Purple)
  - `subTextColor`: `Color(0xFF7A5BAD)`
  - `accentColor`: `Color(0xFFF0C4DD)` (Soft pink)
  - `backgroundGradient`: Linear gradient `[Color(0xFFD8B4FE), Color(0xFFF9A8D4)]`
- **Dark Theme**:
  - `primaryColor`: `Color(0xFFCBA8F0)` (Soft Light Purple)
  - `backgroundColor`: `Color(0xFF130D1F)` (Dark Violet-Black)
  - `surfaceColor`: `Color(0xFF1E1430)`
  - `cardColor`: `Color(0xFF261A3D)`
  - `textColor`: `Color(0xFFF0E8FF)` (Lavender White)
  - `subTextColor`: `Color(0xFFAA90D4)`
  - `accentColor`: `Color(0xFFD4608A)` (Muted pink)
  - `backgroundGradient`: Linear gradient `[Color(0xFF1A0D2E), Color(0xFF2D1052)]`
- **Transparency**: Never use `.withOpacity()`. Always use `.withValues(alpha: ...)`.

### 2. Glassmorphism, Radii & Shadows
- **Card Corners**: `BorderRadius.circular(16)` to `BorderRadius.circular(24)` (feature cards: `BorderRadius.circular(20)`).
- **Card Borders**: Subtle tinted outline: `Border.all(color: settings.primaryColor.withValues(alpha: 0.12), width: 1.5)`.
- **Shadows**: Soft atmospheric drop shadow (`blurRadius: 15-32`, `offset: Offset(0, 4-8)`, `Colors.black.withValues(alpha: 0.05-0.10)`).
- **Glass / Frosted Navigation**: Backdrop blur using `BackdropFilter(filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18))` with semi-transparent navigation background (`settings.navBg.withValues(alpha: 0.65)`).
- **Background Ambient Atmosphere**: `BreathingBlob(color: ..., size: ...)` placed in background stacks.

### 3. Motion & Micro-Interactions
- **Entrance Animation**: Wrap sections/cards with `FadeInSlide(delay: ..., duration: ..., offset: Offset(0, 30), child: ...)`.
- **Hover Feedback**: Wrap cards/buttons with `HoverCard(hoverOffset: -6.0, hoverScale: 1.02, child: ...)`.
- **Animated Numbers**: Wrap numerical statistics in `AnimatedCounter(targetText: ..., settings: ...)`.

---

## 📱 RESPONSIVE LAYOUT STANDARD

- **Standard Page Template**: Wrap full pages with `ResponsivePageTemplate` from `relvastudio/widgets/responsive_layout.dart`.
- **Breakpoints**:
  - Mobile: `<= 600`
  - Tablet: `> 600 && <= 1024`
  - Desktop: `> 1024`
- **Responsive Values**: Always use `ResponsiveLayout.value(context, mobile: ..., tablet: ..., desktop: ...)`.

---

## 🌐 LOCALIZATION & THEME REACTIVITY

- **Theme & Lang Listening**: Always wrap screens with `ListenableBuilder(listenable: settings, builder: (context, _) => ...)`.
- **Bilingual Copy**: Support both English (`AppLanguage.en`) and Indonesian (`AppLanguage.id`).

