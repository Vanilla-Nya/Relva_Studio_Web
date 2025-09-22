import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/relva_main_page.dart';

class RelvaApp extends StatelessWidget {
  const RelvaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relva - Digital Solutions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2E7D8E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D8E),
          brightness: Brightness.light,
        ),
        fontFamily: 'Segoe UI',
      ),
      home: const RelvaMainPage(),
      debugShowCheckedModeBanner: false,
      // Add routes to connect to MAPOTEK pages
      routes: {
        '/feature': (context) => const RelvaMainPage(),
      },
    );
  }
}