import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/app_strings.dart';
import 'package:relva_studio/relvastudio/widgets/custom_animations.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class RelvaProductPage extends StatelessWidget {
  final AppSettings settings;
  final AppStrings strings;

  const RelvaProductPage({
    super.key,
    required this.settings,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = EdgeInsets.symmetric(
      horizontal: ResponsiveLayout.value(
        context,
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 110, bottom: 40),
      child: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: FadeInSlide(
                delay: Duration.zero,
                child: Padding(
                  padding: horizontalPadding,
                  child: _buildHeroSection(context),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: horizontalPadding,
                child: _buildProductGrid(context),
              ),
            ),
          ),
          const SizedBox(height: 80), // space for FAB
          const ResponsiveFooter(),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Text(
            strings.productsTitle,
            style: TextStyle(
              fontSize: ResponsiveLayout.value(
                context,
                mobile: 32.0,
                tablet: 42.0,
                desktop: 48.0,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -1,
              shadows: const [
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
          Text(
            strings.productsSubtitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final products = [
      {
        'icon': '🏥',
        'title': 'MAPOTECH',
        'description': strings.language == AppLanguage.id
            ? 'Medical Application Platform for Operations, Technology & Connected Healthcare — 1 Ekosistem, 3 Solusi Kesehatan Digital'
            : 'Medical Application Platform for Operations, Technology & Connected Healthcare — 1 Ecosystem, 3 Digital Health Solutions',
        'features': strings.language == AppLanguage.id
            ? [
                'Smart EMR System (Rekam Medis Elektronik)',
                'Manajemen Antrean & Pendaftaran Pasien',
                'Resep Elektronik & Auto E-Prescription',
                'Smart Pharmacy POS & Manajemen Stok Obat',
                'Integrasi SATUSEHAT & BPJS',
                'Role-Based Access (Dokter, Admin, Perawat)',
              ]
            : [
                'Smart EMR System (Electronic Medical Records)',
                'Queue Management & Patient Registration',
                'E-Prescription & Auto E-Prescription',
                'Smart Pharmacy POS & Medicine Stock Management',
                'SATUSEHAT & BPJS Integration',
                'Role-Based Access (Doctor, Admin, Nurse)',
              ],
        'isMain': true,
      },
      {
        'icon': '🌐',
        'title': strings.service1Title,
        'description': strings.service1Desc,
        'features': strings.language == AppLanguage.id
            ? [
                'Desain responsif',
                'Framework modern (Flutter Web, React)',
                'Integrasi API',
                'Optimasi performa',
              ]
            : [
                'Responsive design',
                'Modern frameworks (Flutter Web, React)',
                'API integration',
                'Performance optimization',
              ],
        'isMain': false,
      },
      {
        'icon': '📱',
        'title': strings.service2Title,
        'description': strings.service2Desc,
        'features': strings.language == AppLanguage.id
            ? [
                'Kompatibilitas iOS & Android',
                'Performa native',
                'Desain UI/UX modern',
                'Fungsionalitas offline',
              ]
            : [
                'iOS & Android compatibility',
                'Native performance',
                'Modern UI/UX design',
                'Offline functionality',
              ],
        'isMain': false,
      },
      {
        'icon': '🔧',
        'title': strings.service4Title,
        'description': strings.service4Desc,
        'features': strings.language == AppLanguage.id
            ? [
                'Analisis bisnis',
                'Pengembangan kustom',
                'Integrasi sistem',
                'Dukungan berkelanjutan',
              ]
            : [
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
        int crossAxisCount = ResponsiveLayout.value(
          context,
          mobile: 1,
          tablet: 2,
          desktop: 3,
        );
        double aspectRatio = ResponsiveLayout.value(
          context,
          mobile: 0.7,
          tablet: 0.72,
          desktop: 0.75,
        );

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: aspectRatio,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return FadeInSlide(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 600),
              child: HoverCard(
                hoverOffset: -8,
                hoverScale: 1.025,
                child: _buildProductCard(
                  context,
                  product['icon']! as String,
                  product['title']! as String,
                  product['description']! as String,
                  product['features']! as List<String>,
                  isMainProduct: product['isMain'] as bool? ?? false,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String icon,
    String title,
    String description,
    List<String> features, {
    bool isMainProduct = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(20),
        border: isMainProduct
            ? Border.all(color: settings.primaryColor, width: 2.5)
            : Border.all(
                color: settings.primaryColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: isMainProduct
                ? settings.primaryColor.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header gradient banner
          Container(
            width: double.infinity,
            height: isMainProduct ? 140 : 120,
            decoration: BoxDecoration(
              gradient: isMainProduct
                  ? const LinearGradient(
                      colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                    )
                  : LinearGradient(
                      colors: [
                        settings.primaryColor.withValues(alpha: 0.8),
                        settings.primaryColor,
                      ],
                    ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isMainProduct)
                  Image.asset(
                    'assets/logo_MAPOTECH.png',
                    height: 56,
                    errorBuilder: (context, error, stackTrace) => Text(
                      icon,
                      style: const TextStyle(fontSize: 56),
                    ),
                  )
                else
                  Text(
                    icon,
                    style: const TextStyle(fontSize: 48),
                  ),
                if (isMainProduct)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      strings.flagship,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isMainProduct ? 22 : 18,
                      fontWeight: FontWeight.bold,
                      color: settings.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                        color: settings.subTextColor, height: 1.4, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: features
                            .take(isMainProduct ? 6 : 4)
                            .map(
                              (feature) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      '✓ ',
                                      style: TextStyle(
                                        color: settings.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: TextStyle(
                                          color: settings.subTextColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isMainProduct) {
                          Navigator.pushNamed(context, '/mapotech');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '$title – ${strings.comingSoon}'),
                              backgroundColor: settings.primaryColor,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMainProduct
                            ? Colors.orange[600]
                            : settings.primaryColor,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        isMainProduct ? strings.tryMapotech : strings.learnMore,
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
