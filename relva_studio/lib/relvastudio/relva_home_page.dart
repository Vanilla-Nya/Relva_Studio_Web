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
          const SizedBox(height: 60),
          _buildAboutSection(),
          const SizedBox(height: 60),
          _buildServicesSection(),
          const SizedBox(height: 60),
          _buildProductPreview(context),
          const SizedBox(height: 60),
          _buildContactSection(),
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
            'Your trusted partner in digital innovation and creative solutions',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              height: 1.4,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (onNavigateToProducts != null) {
                onNavigateToProducts!();
              }
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'About Relva',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D8E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'Relva is a innovative technology company specializing in creating cutting-edge digital solutions. We transform ideas into powerful applications that drive business growth and enhance user experiences. Our team combines technical expertise with creative thinking to deliver exceptional results for our clients.',
            style: TextStyle(fontSize: 18, color: Colors.black87, height: 1.8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('5+', 'Years Experience'),
              _buildStatCard('50+', 'Projects Delivered'),
              _buildStatCard('100%', 'Client Satisfaction'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D8E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    final services = [
      {
        'icon': '🌐',
        'title': 'Web Applications',
        'description':
            'Custom web solutions built with modern frameworks like Flutter Web and React',
      },
      {
        'icon': '📱',
        'title': 'Mobile Applications',
        'description':
            'Cross-platform mobile apps for iOS and Android using Flutter and Dart',
      },
      {
        'icon': '💻',
        'title': 'Desktop Applications',
        'description':
            'Professional desktop software solutions for business and productivity',
      },
      {
        'icon': '⚙️',
        'title': 'Custom Software',
        'description':
            'Tailored software development to meet your specific business needs',
      },
    ];

    return Column(
      children: [
        const Text(
          'Our Services',
          style: TextStyle(
            fontSize: 42,
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
          'We offer comprehensive application development services',
          style: TextStyle(fontSize: 18, color: Colors.white, height: 1.6),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 800 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.5,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return _buildServiceCard(
                  service['icon']!,
                  service['title']!,
                  service['description']!,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(String icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D8E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Featured Product',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D8E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('🏥', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                const Text(
                  'MAPOTEK',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Smart solution for home-based medical practice management',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ProductFeature(icon: '👥', text: 'Patient\nManagement'),
                    _ProductFeature(icon: '💊', text: 'Medicine\nInventory'),
                    _ProductFeature(icon: '📊', text: 'Financial\nReports'),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (onNavigateToProducts != null) {
                      onNavigateToProducts!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'See More Products',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D8E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Ready to bring your ideas to life? Contact us today!',
            style: TextStyle(fontSize: 18, color: Colors.black87, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;
              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildContactCard(
                          '👤',
                          'Contact Person',
                          'Alfon Soetanto\nProject Manager',
                        ),
                        _buildContactCard(
                          '📧',
                          'Email',
                          'Fontaro990@gmail.com\n alvinmiha289@gmail.com',
                        ),
                        _buildContactCard(
                          '📱',
                          'Phone',
                          '+62 821-3241-1163\n+62 812-1638-225',
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildContactCard(
                          '👤',
                          'Contact Person',
                          'Fulan - Project Manager',
                        ),
                        const SizedBox(height: 16),
                        _buildContactCard('📧', 'Email', 'Fontaro990@gmail.com'),
                        const SizedBox(height: 16),
                        _buildContactCard('📱', 'Phone', '+62 821-3241-1163'),
                      ],
                    );
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Add contact action here
            },
            icon: const Icon(Icons.mail_outline),
            label: const Text(
              'Send Message',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D8E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(String icon, String title, String info) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minWidth: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D8E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D8E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            info,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProductFeature extends StatelessWidget {
  final String icon;
  final String text;

  const _ProductFeature({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
