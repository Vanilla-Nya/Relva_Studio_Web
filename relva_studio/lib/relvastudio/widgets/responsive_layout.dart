import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/global_settings_fab.dart';
import 'package:relva_studio/relvastudio/widgets/custom_animations.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 600 &&
      MediaQuery.sizeOf(context).width <= 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 1024;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1024) return desktop;
    if (width > 600) return tablet ?? desktop;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return desktop;
        } else if (constraints.maxWidth > 600) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}

class ResponsivePageTemplate extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final bool showFooter;
  final bool showFAB;
  final Widget? header;
  final bool isScrollable;
  final double? maxContentWidth;
  final EdgeInsetsGeometry? padding;
  /// When true, the child fills the full width without Center/ConstrainedBox/Padding.
  /// Use this for pages that manage their own section-level layouts (e.g. full-bleed hero sections).
  final bool fullWidth;

  const ResponsivePageTemplate({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.showFooter = true,
    this.showFAB = true,
    this.header,
    this.isScrollable = true,
    this.maxContentWidth = 1200.0,
    this.padding,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        // Custom back button widget
        final backButton = SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                backgroundColor: settings.cardColor.withValues(alpha: 0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: settings.textColor,
                size: 20,
              ),
            ),
          ),
        );

        // Core content laid out inside responsive constraints
        Widget content = Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxContentWidth ?? 1200.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: padding ?? EdgeInsets.symmetric(
                  horizontal: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 24.0,
                    desktop: 40.0,
                  ),
                  vertical: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 24.0,
                    desktop: 32.0,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        );

        Widget mainBody;
        if (isScrollable) {
          // Build the scrollable child widget (with or without full-width mode)
          Widget scrollChild;
          if (fullWidth) {
            // Full-width mode: no Center/ConstrainedBox/Padding wrapper —
            // sections manage their own widths.
            scrollChild = showFooter
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      child,
                      const ResponsiveFooter(),
                    ],
                  )
                : child;
          } else {
            scrollChild = showFooter
                ? Column(
                    children: [
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: maxContentWidth ?? 1200.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: padding ?? EdgeInsets.fromLTRB(
                                ResponsiveLayout.value(
                                  context,
                                  mobile: 16.0,
                                  tablet: 24.0,
                                  desktop: 40.0,
                                ),
                                header != null ? 30.0 : 76.0,
                                ResponsiveLayout.value(
                                  context,
                                  mobile: 16.0,
                                  tablet: 24.0,
                                  desktop: 40.0,
                                ),
                                32.0,
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                      const ResponsiveFooter(),
                    ],
                  )
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxContentWidth ?? 1200.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: padding ?? EdgeInsets.fromLTRB(
                            ResponsiveLayout.value(
                              context,
                              mobile: 16.0,
                              tablet: 24.0,
                              desktop: 40.0,
                            ),
                            header != null ? 30.0 : 76.0,
                            ResponsiveLayout.value(
                              context,
                              mobile: 16.0,
                              tablet: 24.0,
                              desktop: 40.0,
                            ),
                            32.0,
                          ),
                          child: child,
                        ),
                      ),
                    ),
                  );
          }

          mainBody = SingleChildScrollView(
            padding: EdgeInsets.only(
              top: header != null ? 80.0 : 0.0,
            ),
            child: scrollChild,
          );
        } else {
          if (showFooter) {
            mainBody = Column(
              children: [
                Expanded(child: content),
                const ResponsiveFooter(),
              ],
            );
          } else {
            mainBody = content;
          }
        }

        return Scaffold(
          backgroundColor: settings.backgroundColor,
          floatingActionButton: showFAB ? const GlobalSettingsFAB() : null,
          body: Container(
            decoration: BoxDecoration(gradient: settings.backgroundGradient),
            child: Stack(
              children: [
                // Floating breathing background blobs
                Positioned(
                  top: -150,
                  left: -150,
                  child: BreathingBlob(
                    color: settings.primaryColor,
                    size: 450,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: -200,
                  child: BreathingBlob(
                    color: settings.accentColor,
                    size: 550,
                  ),
                ),
                Positioned(
                  top: 350,
                  right: 150,
                  child: BreathingBlob(
                    color: settings.primaryColor,
                    size: 350,
                  ),
                ),
                Positioned(
                  bottom: -100,
                  left: 100,
                  child: BreathingBlob(
                    color: settings.accentColor,
                    size: 400,
                  ),
                ),

                // Main Page Content
                Positioned.fill(child: mainBody),

                // Header / App Bar
                if (header != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: header!,
                  ),

                // Back Button
                if (showBackButton)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: backButton,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveFooter extends StatelessWidget {
  const ResponsiveFooter({super.key});

  Widget _footerBtn(
      BuildContext context, AppSettings settings, String label, String route) {
    return TextButton(
      onPressed: () {
        final currentRoute = ModalRoute.of(context)?.settings.name;
        if (currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: settings.textColor.withValues(alpha: 0.6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    final isEn = settings.language == AppLanguage.en;
    final teal = settings.primaryColor;

    return Container(
      color: settings.backgroundColor.withValues(alpha: 0.85),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.local_hospital_rounded,
                  color: teal,
                  size: 20,
                ),
              ),
              Text(
                'MAPOTECH',
                style: TextStyle(
                  color: settings.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'by RELVA Studio',
            style: TextStyle(
              color: settings.textColor.withValues(alpha: 0.4),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _footerBtn(
                context,
                settings,
                isEn ? 'Privacy Policy' : 'Kebijakan Privasi',
                '/mapotech/privacy',
              ),
              _footerBtn(
                context,
                settings,
                isEn ? 'Terms & Conditions' : 'Syarat & Ketentuan',
                '/mapotech/terms',
              ),
              _footerBtn(
                context,
                settings,
                isEn ? 'Contact' : 'Kontak',
                '/mapotech/contact',
              ),
              _footerBtn(
                context,
                settings,
                isEn ? 'Customers' : 'Pelanggan',
                '/mapotech/customers',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            '© 2026 MAPOTECH by RELVA Studio. All rights reserved.',
            style: TextStyle(
              color: settings.textColor.withValues(alpha: 0.35),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
