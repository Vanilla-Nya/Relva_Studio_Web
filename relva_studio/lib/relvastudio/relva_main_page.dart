import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/relva_home_page.dart';
import 'package:relva_studio/relvastudio/relva_product_page.dart';

class RelvaMainPage extends StatefulWidget {
  const RelvaMainPage({super.key});

  @override
  State<RelvaMainPage> createState() => _RelvaMainPageState();
}

class _RelvaMainPageState extends State<RelvaMainPage> {
  void _navigateToProducts() {
    // Get the tab controller from DefaultTabController
    DefaultTabController.of(context).animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
          ),
          child: Column(
            children: [
              _buildNavigation(),
              Expanded(
                child: TabBarView(
                  children: [
                    RelvaHomePage(onNavigateToProducts: _navigateToProducts),
                    const RelvaProductPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Relva',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D8E),
              ),
            ),
            TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFF2E7D8E),
              labelColor: const Color(0xFF2E7D8E),
              unselectedLabelColor: Colors.black87,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Home'),
                Tab(text: 'Products'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
