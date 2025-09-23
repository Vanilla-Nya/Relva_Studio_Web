import 'package:flutter/material.dart';

class RelvaHomePage extends StatelessWidget {

  final VoidCallback? onNavigateToProducts; 
  
  const RelvaHomePage({super.key, this.onNavigateToProducts});

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
              // Navigate to products page - you can implement this
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