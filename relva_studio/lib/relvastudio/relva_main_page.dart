import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/app_strings.dart';
import 'package:relva_studio/relvastudio/relva_home_page.dart';
import 'package:relva_studio/relvastudio/relva_product_page.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class RelvaMainPage extends StatefulWidget {
  const RelvaMainPage({super.key});

  @override
  State<RelvaMainPage> createState() => _RelvaMainPageState();
}

class _RelvaMainPageState extends State<RelvaMainPage> {
  void _navigateToProducts() {
    DefaultTabController.of(context).animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final strings = AppStrings(settings.language);

        return DefaultTabController(
          length: 2,
          child: ResponsivePageTemplate(
            isScrollable: false,
            showFooter: false,
            showBackButton: false,
            maxContentWidth: double.infinity,
            header: _buildNavigation(settings, strings),
            padding: EdgeInsets.zero,
            child: TabBarView(
              children: [
                RelvaHomePage(
                  onNavigateToProducts: _navigateToProducts,
                  settings: settings,
                  strings: strings,
                ),
                RelvaProductPage(settings: settings, strings: strings),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Navigation Bar ────────────────────────────────────────────────────────
  Widget _buildNavigation(AppSettings settings, AppStrings strings) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: settings.navBg.withValues(alpha: 0.65),
            border: Border(
              bottom: BorderSide(
                color: settings.primaryColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveLayout.value(
                context,
                mobile: 12.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand name
                Row(
                  children: [
                    Image.asset(
                      'assets/Relva_Studio_Logo_Remove_BG.png',
                      height: ResponsiveLayout.value(
                        context,
                        mobile: 30.0,
                        tablet: 34.0,
                        desktop: 38.0,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: ResponsiveLayout.value(
                            context,
                            mobile: 30.0,
                            tablet: 34.0,
                            desktop: 36.0,
                          ),
                          height: ResponsiveLayout.value(
                            context,
                            mobile: 30.0,
                            tablet: 34.0,
                            desktop: 36.0,
                          ),
                          decoration: BoxDecoration(
                            color: settings.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'R',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: ResponsiveLayout.value(
                        context,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                      ),
                    ),
                    Text(
                      'Relva',
                      style: TextStyle(
                        fontSize: ResponsiveLayout.value(
                          context,
                          mobile: 20.0,
                          tablet: 24.0,
                          desktop: 26.0,
                        ),
                        fontWeight: FontWeight.bold,
                        color: settings.primaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: settings.primaryColor,
                  labelColor: settings.primaryColor,
                  unselectedLabelColor:
                      settings.textColor.withValues(alpha: 0.7),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: ResponsiveLayout.value(
                      context,
                      mobile: 13.0,
                      tablet: 15.0,
                      desktop: 16.0,
                    ),
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ResponsiveLayout.value(
                      context,
                      mobile: 13.0,
                      tablet: 15.0,
                      desktop: 16.0,
                    ),
                  ),
                  tabs: [
                    Tab(text: strings.navHome),
                    Tab(text: strings.navProducts),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

