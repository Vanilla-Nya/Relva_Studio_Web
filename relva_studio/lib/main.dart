import 'package:flutter/material.dart';
import 'package:relva_studio/MAPOTECH/home.dart';
import 'package:relva_studio/MAPOTECH/contact.dart' as tech_contact;
import 'package:relva_studio/MAPOTECH/customer.dart' as tech_customer;
import 'package:relva_studio/MAPOTECH/demo.dart' as tech_demo;
import 'package:relva_studio/MAPOTECH/feature.dart' as tech_feature;
import 'package:relva_studio/MAPOTECH/image_detail.dart' as tech_image_detail;
import 'package:relva_studio/MAPOTECH/pricing.dart' as tech_pricing;
import 'package:relva_studio/MAPOTECH/privacy_policy.dart' as tech_privacy_policy;
import 'package:relva_studio/MAPOTECH/terms.dart' as tech_terms;
import 'package:relva_studio/Mapotek/contact.dart';
import 'package:relva_studio/Mapotek/costumer.dart';
import 'package:relva_studio/Mapotek/demo.dart';
import 'package:relva_studio/Mapotek/feature.dart';
import 'package:relva_studio/Mapotek/home.dart';
import 'package:relva_studio/Mapotek/image_detail.dart';
import 'package:relva_studio/Mapotek/pricing.dart';
import 'package:relva_studio/Mapotek/privacy_policy.dart';
import 'package:relva_studio/Mapotek/terms.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/relva_main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppSettings _appSettings = AppSettings();

  @override
  void dispose() {
    _appSettings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSettingsProvider(
      settings: _appSettings,
      child: ListenableBuilder(
        listenable: _appSettings,
        builder: (context, _) {
          return MaterialApp(
            title: 'Relva Studio',
            theme: _appSettings.themeData,
            initialRoute: '/',
            routes: {
              // Relva Studio Website Routes
              '/': (context) => const RelvaMainPage(),

              // MAPOTECH Product Page (new comprehensive page)
              '/mapotech': (context) => const MapotechHomePage(),
              '/mapotech/features': (context) => const tech_feature.FeaturesPage(),
              '/mapotech/pricing': (context) => const tech_pricing.PricingPage(),
              '/mapotech/demo': (context) => const tech_demo.DemoPage(),
              '/mapotech/contact': (context) => const tech_contact.ContactPage(),
              '/mapotech/privacy': (context) => const tech_privacy_policy.PrivacyPolicyPage(),
              '/mapotech/terms': (context) => const tech_terms.TermsPage(),
              '/mapotech/customers': (context) => const tech_customer.EnhancedCustomerPage(),

              // MAPOTEK App Routes (kept for backward compatibility)
              '/mapotek': (context) => const MapotekApp(),
              '/mapotek/home': (context) => const HomePage(),
              '/mapotek/features': (context) => const FeaturesPage(),
              '/mapotek/pricing': (context) => const PricingPage(),
              '/mapotek/demo': (context) => const DemoPage(),
              '/mapotek/contact': (context) => const ContactPage(),
              '/mapotek/privacy': (context) => const PrivacyPolicyPage(),
              '/mapotek/terms': (context) => const TermsPage(),
              '/mapotek/customers': (context) => const EnhancedCustomerPage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/mapotech/imageDetail') {
                final args = settings.arguments as Map<String, dynamic>?;
                final imagePath = args?['imagePath'] ?? 'assets/mapotek_1.jpg';
                final tag = args?['tag'] ?? 'mapotechHero_0';
                return MaterialPageRoute(
                  builder: (context) => tech_image_detail.ImageDetailPage(
                    imagePath: imagePath,
                    tag: tag,
                  ),
                );
              }
              if (settings.name == '/mapotek/imageDetail') {
                final args = settings.arguments as Map<String, dynamic>?;
                final imagePath = args?['imagePath'] ?? 'assets/mapotek_1.jpg';
                final tag = args?['tag'] ?? 'mapotechHero_0';
                return MaterialPageRoute(
                  builder: (context) => ImageDetailPage(
                    imagePath: imagePath,
                    tag: tag,
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

// MAPOTEK App as a separate widget
class MapotekApp extends StatelessWidget {
  const MapotekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
