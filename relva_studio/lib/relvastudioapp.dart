import 'package:flutter/material.dart';
import 'package:relva_studio/feature.dart';

void main() {
  runApp(const RelvaApp());
}

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
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      // Add routes to connect to MAPOTEK pages
      routes: {
        '/feature': (context) => const FeaturesPage(),
      },
    );
  }
}

// Create a simple landing page for MAPOTEK that can link back to the full app
class MapotekLandingPage extends StatelessWidget {
  const MapotekLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.medical_services, color: Colors.white, size: 32),
            const SizedBox(width: 12),
            const Text(
              "MAPOTEK",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D8E),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.medical_services,
                size: 120,
                color: Color(0xFF2E7D8E),
              ),
              const SizedBox(height: 32),
              const Text(
                'Welcome to MAPOTEK',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D8E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Solusi Cerdas untuk Praktik Dokter di Rumah',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'This is a preview page. In a real app, this would connect to your full MAPOTEK application.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D8E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Back to Relva'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Here you could navigate to the full MAPOTEK app
                      // For now, just show a message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Full MAPOTEK app would open here'),
                          backgroundColor: Color(0xFF2E7D8E),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Open Full App'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              child: selectedIndex == 0 ? const HomePage() : const ProductPage(),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildHeroSection(context),
          const SizedBox(height: 40),
          _buildContentGrid(),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Text(
            'Welcome to Relva',
            style: TextStyle(
              fontSize: 56,
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
          const SizedBox(height: 16),
          const Text(
            'Your trusted partner in digital innovation and creative solutions. We transform ideas into powerful digital experiences.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Navigate to products page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D8E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
            ),
            child: const Text(
              'Explore Our Products',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentGrid() {
    final features = [
      {
        'icon': '🚀',
        'title': 'Innovation First',
        'description': 'We stay ahead of technology trends to deliver cutting-edge solutions that give your business a competitive advantage in the digital landscape.',
      },
      {
        'icon': '💡',
        'title': 'Creative Solutions',
        'description': 'Our team combines technical expertise with creative thinking to solve complex problems and bring your vision to life with elegant, user-friendly applications.',
      },
      {
        'icon': '🎯',
        'title': 'Results Driven',
        'description': 'Every project is focused on delivering measurable results that help your business grow, improve efficiency, and enhance user satisfaction.',
      },
      {
        'icon': '🤝',
        'title': 'Partnership Approach',
        'description': 'We work closely with our clients as true partners, understanding your goals and providing ongoing support to ensure long-term success.',
      },
      {
        'icon': '⚡',
        'title': 'Fast & Reliable',
        'description': 'Our development process is optimized for speed without compromising quality, ensuring your projects are delivered on time and perform flawlessly.',
      },
      {
        'icon': '🛡️',
        'title': 'Secure & Scalable',
        'description': 'We build applications with security and scalability in mind, ensuring your digital assets can grow with your business while staying protected.',
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
            childAspectRatio: 1.2,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return _buildFeatureCard(
              feature['icon']!,
              feature['title']!,
              feature['description']!,
            );
          },
        );
      },
    );
  }

  Widget _buildFeatureCard(String icon, String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D8E),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

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
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
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
                          // Navigate to MAPOTEK preview page
                          Navigator.pushNamed(context, '/mapotek');
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