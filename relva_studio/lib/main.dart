import 'package:flutter/material.dart';
import 'package:relva_studio/contact.dart';
import 'package:relva_studio/costumer.dart';
import 'package:relva_studio/demo.dart';
import 'package:relva_studio/feature.dart';
import 'package:relva_studio/home.dart';
import 'package:relva_studio/image_detail.dart';
import 'package:relva_studio/pricing.dart';
import 'package:relva_studio/privacy_policy.dart';
import 'package:relva_studio/relvastudioapp.dart' as relva;
import 'package:relva_studio/terms.dart';

void main() {
  runApp(const relva.RelvaApp()); 
}

class MapotekApp extends StatelessWidget {
  const MapotekApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAPOTEK - Solusi Cerdas untuk Praktik Dokter di Rumah',
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/features': (context) => const FeaturesPage(),
        '/pricing': (context) => const PricingPage(),
        '/demo': (context) => const DemoPage(),
        '/contact': (context) => const ContactPage(),
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/terms': (context) => const TermsPage(),
        '/customers': (context) => const EnhancedCustomerPage(),
        '/relva': (context) => const relva.RelvaApp(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/imageDetail') {
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