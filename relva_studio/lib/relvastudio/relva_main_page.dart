import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/relva_home_page.dart';
import 'package:relva_studio/relvastudio/relva_product_page.dart';

class RelvaMainPage extends StatefulWidget {
  const RelvaMainPage({super.key});

  @override
  State<RelvaMainPage> createState() => _RelvaMainPageState();
}

class _RelvaMainPageState extends State<RelvaMainPage> {
  int selectedIndex = 0;

  void _onMenuTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildNavigation(),
            Expanded(
              child: selectedIndex == 0 ? const RelvaHomePage() : const RelvaProductPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            Row(
              children: [
                _buildNavItem('Home', 0),
                const SizedBox(width: 20),
                _buildNavItem('Products', 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onMenuTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D8E) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}