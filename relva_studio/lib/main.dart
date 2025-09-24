import 'package:flutter/material.dart';
import 'package:relva_studio/Mapotek/contact.dart';
import 'package:relva_studio/Mapotek/costumer.dart';
import 'package:relva_studio/Mapotek/demo.dart';
import 'package:relva_studio/Mapotek/feature.dart';
import 'package:relva_studio/Mapotek/home.dart';
import 'package:relva_studio/Mapotek/image_detail.dart';
import 'package:relva_studio/Mapotek/pricing.dart';
import 'package:relva_studio/Mapotek/privacy_policy.dart';
import 'package:relva_studio/Mapotek/terms.dart';
import 'package:relva_studio/relvastudio/relva_main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relva Studio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2E7D8E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D8E),
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      initialRoute: '/', // This will show Relva website first
      routes: {
        // Relva Studio Website Routes
        '/': (context) => const RelvaMainPage(),

        // MAPOTEK App Routes
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
        if (settings.name == '/mapotek/imageDetail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) =>
                ImageDetailPage(imagePath: args['imagePath'], tag: args['tag']),
          );
        }
        return null;
      },
    );
  }
}

// MAPOTEK App as a separate widget
class MapotekApp extends StatelessWidget {
  const MapotekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage(); // This shows the MAPOTEK home page
  }
}
