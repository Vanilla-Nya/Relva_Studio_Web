import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/app_strings.dart';
import 'package:relva_studio/relvastudio/widgets/custom_animations.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class RelvaHomePage extends StatelessWidget {
  final VoidCallback? onNavigateToProducts;
  final AppSettings settings;
  final AppStrings strings;

  const RelvaHomePage({
    super.key,
    this.onNavigateToProducts,
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
            child: Padding(
              padding: horizontalPadding,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: _buildHeroSection(context),
              ),
            ),
          ),
          const SizedBox(height: 60),
          FadeInSlide(
            delay: const Duration(milliseconds: 300),
            child: Center(
              child: Padding(
                padding: horizontalPadding,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: _buildAboutSection(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Padding(
              padding: horizontalPadding,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: _buildServicesSection(),
              ),
            ),
          ),
          const SizedBox(height: 60),
          FadeInSlide(
            delay: const Duration(milliseconds: 200),
            child: Center(
              child: Padding(
                padding: horizontalPadding,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: _buildProductPreview(context),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          FadeInSlide(
            delay: const Duration(milliseconds: 200),
            child: Center(
              child: Padding(
                padding: horizontalPadding,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: _buildContactSection(context),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80), // space for FAB
          const _RelvaFooter(),
        ],
      ),
    );
  }

  // ─── Hero ──────────────────────────────────────────────────────────────────
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          // Animated badge
          FadeInSlide(
            delay: Duration.zero,
            offset: const Offset(0, -20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              child: const Text(
                '✦  Digital Innovation Studio',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInSlide(
            delay: const Duration(milliseconds: 150),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Color(0xFFF0E5FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                strings.heroTitle,
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 36.0,
                    tablet: 48.0,
                    desktop: 56.0,
                  ),
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FadeInSlide(
            delay: const Duration(milliseconds: 300),
            child: Text(
              strings.heroSubtitle,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withValues(alpha: 0.88),
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 36),
          FadeInSlide(
            delay: const Duration(milliseconds: 450),
            child: HoverCard(
              hoverOffset: -5,
              hoverScale: 1.05,
              child: ElevatedButton(
                onPressed: () {
                  if (onNavigateToProducts != null) {
                    onNavigateToProducts!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: settings.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black.withValues(alpha: 0.25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      strings.heroButton,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── About ─────────────────────────────────────────────────────────────────
  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            strings.aboutTitle,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: settings.primaryColor,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            strings.aboutDesc,
            style: TextStyle(
                fontSize: 17, color: settings.subTextColor, height: 1.8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('5+', strings.stat1Label),
              _buildDivider(),
              _buildStatCard('50+', strings.stat2Label),
              _buildDivider(),
              _buildStatCard('100%', strings.stat3Label),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: settings.primaryColor.withValues(alpha: 0.2),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Column(
      children: [
        AnimatedCounter(
          targetText: number,
          settings: settings,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: settings.subTextColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ─── Services ──────────────────────────────────────────────────────────────
  Widget _buildServicesSection() {
    final services = [
      {'icon': '🌐', 'title': strings.service1Title, 'description': strings.service1Desc},
      {'icon': '📱', 'title': strings.service2Title, 'description': strings.service2Desc},
      {'icon': '💻', 'title': strings.service3Title, 'description': strings.service3Desc},
      {'icon': '⚙️', 'title': strings.service4Title, 'description': strings.service4Desc},
    ];

    return Column(
      children: [
        Text(
          strings.servicesTitle,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.8,
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
        const SizedBox(height: 12),
        Text(
          strings.servicesSubtitle,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.6),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = ResponsiveLayout.value(
              context,
              mobile: 1,
              tablet: 2,
              desktop: 4,
            );
            double aspectRatio = ResponsiveLayout.value(
              context,
              mobile: 1.25,
              tablet: 1.0,
              desktop: 0.85,
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
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return FadeInSlide(
                  delay: Duration(milliseconds: 100 * index),
                  duration: const Duration(milliseconds: 600),
                  child: HoverCard(
                    hoverOffset: -8,
                    hoverScale: 1.03,
                    child: _buildServiceCard(
                      service['icon']!,
                      service['title']!,
                      service['description']!,
                    ),
                  ),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: settings.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: settings.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: settings.subTextColor,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ─── Product Preview ───────────────────────────────────────────────────────
  Widget _buildProductPreview(BuildContext context) {
    return HoverCard(
      hoverOffset: -6,
      hoverScale: 1.015,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: settings.cardColor.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: settings.primaryColor.withValues(alpha: 0.1),
          ),
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
            Text(
              strings.featuredTitle,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: settings.primaryColor,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2E7D8E).withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo_MAPOTECH.png',
                    height: 64,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('🏥', style: TextStyle(fontSize: 64));
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MAPOTECH',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.mapotechDesc,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ProductFeature(icon: '👥', text: strings.feat1),
                      _ProductFeature(icon: '💊', text: strings.feat2),
                      _ProductFeature(icon: '📊', text: strings.feat3),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/mapotech');
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
                      elevation: 6,
                    ),
                    child: Text(
                      strings.seeMoreBtn,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Contact ───────────────────────────────────────────────────────────────
  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            strings.contactTitle,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: settings.primaryColor,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            strings.contactSubtitle,
            style: TextStyle(
                fontSize: 15, color: settings.subTextColor, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;
              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InteractiveContactCard(
                          icon: Icons.person_outline_rounded,
                          title: strings.contactPerson,
                          info: 'Alfon Soetanto\nProject Manager',
                          settings: settings,
                        ),
                        InteractiveContactCard(
                          icon: Icons.alternate_email_rounded,
                          title: 'Email',
                          info: 'Fontaro990@gmail.com\nalvinmiha289@gmail.com',
                          settings: settings,
                        ),
                        InteractiveContactCard(
                          icon: Icons.smartphone_rounded,
                          title: 'Phone',
                          info: '+62 821-3241-1163\n+62 812-1638-225',
                          settings: settings,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        InteractiveContactCard(
                          icon: Icons.person_outline_rounded,
                          title: strings.contactPerson,
                          info: 'Alfon Soetanto\nProject Manager',
                          settings: settings,
                        ),
                        const SizedBox(height: 16),
                        InteractiveContactCard(
                          icon: Icons.alternate_email_rounded,
                          title: 'Email',
                          info: 'Fontaro990@gmail.com\nalvinmiha289@gmail.com',
                          settings: settings,
                        ),
                        const SizedBox(height: 16),
                        InteractiveContactCard(
                          icon: Icons.smartphone_rounded,
                          title: 'Phone',
                          info: '+62 821-3241-1163\n+62 812-1638-225',
                          settings: settings,
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 32),
          HoverCard(
            hoverOffset: -4,
            hoverScale: 1.05,
            child: ElevatedButton.icon(
              onPressed: () async {
                const phone = '6282132411163';
                final message = Uri.encodeComponent(
                    "Hello! I'd like to ask about your services.");
                final whatsappUrl =
                    Uri.parse("https://wa.me/$phone?text=$message");
                final messenger = ScaffoldMessenger.of(context);
                if (await canLaunchUrl(whatsappUrl)) {
                  await launchUrl(whatsappUrl,
                      mode: LaunchMode.externalApplication);
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                        content: Text('Could not open WhatsApp')),
                  );
                }
              },
              icon: const Icon(Icons.chat_rounded, color: Colors.white, size: 20),
              label: Text(
                strings.contactWhatsApp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF25D366).withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String info;
  final AppSettings settings;

  const InteractiveContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    required this.settings,
  });

  @override
  State<InteractiveContactCard> createState() => _InteractiveContactCardState();
}

class _InteractiveContactCardState extends State<InteractiveContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        constraints: const BoxConstraints(minWidth: 180, maxWidth: 240),
        decoration: BoxDecoration(
          color: widget.settings.cardColor.withValues(alpha: _isHovered ? 0.98 : 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? widget.settings.primaryColor
                : widget.settings.primaryColor.withValues(alpha: 0.15),
            width: _isHovered ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.settings.primaryColor.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _isHovered
                    ? widget.settings.primaryColor.withValues(alpha: 0.2)
                    : widget.settings.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: _isHovered ? 1.15 : 1.0,
                  curve: Curves.easeOutBack,
                  child: Icon(
                    widget.icon,
                    color: widget.settings.primaryColor,
                    size: 26,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: widget.settings.textColor,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.info,
              style: TextStyle(
                fontSize: 12,
                color: widget.settings.subTextColor,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RelvaFooter extends StatelessWidget {
  const _RelvaFooter();

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    final primary = settings.primaryColor;

    return Container(
      width: double.infinity,
      color: settings.backgroundColor.withValues(alpha: 0.85),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          // Brand row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.auto_awesome_rounded, color: primary, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'Relva Studio',
                style: TextStyle(
                  color: settings.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Digital Innovation Studio',
            style: TextStyle(
              color: settings.textColor.withValues(alpha: 0.4),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          // Quick links
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/mapotech'),
                style: TextButton.styleFrom(
                  foregroundColor: settings.textColor.withValues(alpha: 0.6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: const Text('MAPOTECH', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: primary.withValues(alpha: 0.1), thickness: 1),
          const SizedBox(height: 16),
          Text(
            '© 2026 Relva Studio. All rights reserved.',
            style: TextStyle(
              color: settings.textColor.withValues(alpha: 0.35),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
