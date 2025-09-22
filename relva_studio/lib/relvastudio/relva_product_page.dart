import 'package:flutter/material.dart';

class RelvaProductPage extends StatelessWidget {
  const RelvaProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildHeroSection(),
          const SizedBox(height: 40),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: const Column(
        children: [
          Text(
            'Our Products',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Discover our range of innovative digital solutions designed to transform your business operations and enhance user experiences.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = [
      // Main Product - MAPOTEK (featured)
      {
        'icon': '🏥',
        'title': 'MAPOTEK',
        'description': 'Solusi Cerdas untuk Praktik Dokter di Rumah - Desktop application for home-based medical practice management',
        'features': [
          'Login Multi-Role (Owner, Admin, Dokter)',
          'Manajemen Data Pasien Digital',
          'Pemantauan Stok Obat Otomatis',
          'Absensi Staf Digital',
          'Pencatatan Keuangan Terstruktur',
          'Antarmuka User-Friendly',
        ],
        'isMain': true,
      },
      // Future products can be added here
      {
        'icon': '🌐',
        'title': 'Web Applications',
        'description': 'Custom web solutions tailored to your business needs',
        'features': [
          'Responsive design',
          'Modern frameworks (Flutter Web, React)',
          'API integration',
          'Performance optimization',
        ],
        'isMain': false,
      },
      {
        'icon': '📱',
        'title': 'Mobile Applications',
        'description': 'Cross-platform mobile apps using Flutter and Dart',
        'features': [
          'iOS & Android compatibility',
          'Native performance',
          'Modern UI/UX design',
          'Offline functionality',
        ],
        'isMain': false,
      },
      {
        'icon': '🔧',
        'title': 'Custom Software',
        'description': 'Tailored software solutions for your specific business needs',
        'features': [
          'Business analysis',
          'Custom development',
          'System integration',
          'Ongoing support',
        ],
        'isMain': false,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1200 ? 3 : constraints.maxWidth > 800 ? 2 : 1;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(
              context,
              product['icon']! as String,
              product['title']! as String,
              product['description']! as String,
              product['features']! as List<String>,
              isMainProduct: product['isMain'] as bool? ?? false,
            );
          },
        );
      },
    );
  }

  Widget _buildProductCard(BuildContext context, String icon, String title, String description, List<String> features, {bool isMainProduct = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: isMainProduct ? Border.all(color: const Color(0xFF2E7D8E), width: 3) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Icon/Image
          Container(
            width: double.infinity,
            height: isMainProduct ? 140 : 120,
            decoration: BoxDecoration(
              gradient: isMainProduct 
                ? const LinearGradient(colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)])
                : const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  icon,
                  style: TextStyle(fontSize: isMainProduct ? 56 : 48),
                ),
                if (isMainProduct)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'FLAGSHIP PRODUCT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Product Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isMainProduct ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D8E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Features List
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: features.take(isMainProduct ? 6 : 4).map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Text(
                              '✓ ',
                              style: TextStyle(
                                color: Color(0xFF2E7D8E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                  
                  // CTA Button
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isMainProduct) {
                          // Navigate to MAPOTEK - you need to add this route
                          // Navigator.pushNamed(context, '/mapotek');
                          
                          // For now, show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('MAPOTEK app will open here'),
                              backgroundColor: Color(0xFF2E7D8E),
                            ),
                          );
                        } else {
                          // Handle other products
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Learn more about $title - Coming soon!'),
                              backgroundColor: const Color(0xFF2E7D8E),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMainProduct 
                          ? Colors.orange[600] 
                          : const Color(0xFF2E7D8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isMainProduct ? 'Try MAPOTEK' : 'Learn More',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}