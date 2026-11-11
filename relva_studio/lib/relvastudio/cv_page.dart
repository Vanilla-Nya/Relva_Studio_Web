import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/models/cv_profile_data.dart';
import 'package:relva_studio/relvastudio/widgets/card_media_background.dart';
import 'package:relva_studio/relvastudio/widgets/custom_animations.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

/// Relva Studio Developer Profile & Portfolio (Tabbed Pane Architecture)
/// Styled with signature REV Palette, zero external UI libraries,
/// full-width header banner, borderless avatar with blurred reflection,
/// and a sticky top bar appearing upon scrolling.
class CvPage extends StatefulWidget {
  final String? profileId;
  const CvPage({super.key, this.profileId});

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _showStickyTopBar = false;

  // Active filter inside Technical Skills tab: 0=All, 1=Mobile/Frontend, 2=Backend/Cloud, 3=Architecture/Tools
  int _activeSkillCategory = 0;

  // Configurable dynamic media background for the header card
  String? _cardMediaSource;
  late String _activeProfileId;
  late CvProfileData _profile;
  bool _profileInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _activeProfileId = widget.profileId ?? args?['profileId'] ?? 'alfon';
      _profile = CvProfileRepository.getProfile(_activeProfileId);
      _cardMediaSource = _profile.backgroundMedia;
      _profileInitialized = true;
    }
  }

  void _switchProfile(String id) {
    if (id == _activeProfileId) return;
    setState(() {
      _activeProfileId = id;
      _profile = CvProfileRepository.getProfile(id);
      _cardMediaSource = _profile.backgroundMedia;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final shouldShow = _scrollController.offset > 130;
    if (shouldShow != _showStickyTopBar) {
      setState(() {
        _showStickyTopBar = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppSettingsProvider.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showDownloadCvDialog(BuildContext context, AppSettings settings) {
    final isEn = settings.language == AppLanguage.en;
    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AlertDialog(
          backgroundColor: settings.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: settings.primaryColor.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: settings.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.file_download_outlined,
                  color: settings.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isEn ? 'Relva Studio Owner Profile' : 'Profil Pemilik Relva Studio',
                style: TextStyle(
                  color: settings.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEn
                    ? 'Download the complete profile and portfolio for ${_profile.name} (${_profile.companyBadge}).'
                    : 'Unduh ringkasan profil dan portofolio lengkap untuk ${_profile.name} (${_profile.companyBadge}).',
                style: TextStyle(
                  color: settings.subTextColor,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: settings.surfaceColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: settings.primaryColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: settings.primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_profile.name.replaceAll(' ', '_')}_CV.pdf',
                            style: TextStyle(
                              color: settings.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'PDF Document • 2.4 MB • Updated Nov 2026',
                            style: TextStyle(
                              color: settings.subTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                isEn ? 'Close' : 'Tutup',
                style: TextStyle(color: settings.subTextColor),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEn
                          ? 'Starting CV download simulation...'
                          : 'Memulai pengunduhan CV contoh...',
                      style: TextStyle(color: settings.textColor),
                    ),
                    backgroundColor: settings.cardColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: settings.primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.download_rounded, size: 18),
              label: Text(isEn ? 'Download PDF' : 'Unduh PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMediaLabel(bool isEn) {
    if (_cardMediaSource == null) return isEn ? 'Ambient Glow' : 'Gradien Ambien';
    final lower = _cardMediaSource!.toLowerCase();
    if (lower.endsWith('.mp4') || lower.endsWith('.webm') || lower.endsWith('.mov')) {
      if (lower.startsWith('http')) return isEn ? 'Video Link' : 'Tautan Video';
      return isEn ? 'Video Asset' : 'Video Aset';
    }
    if (lower.endsWith('.gif')) {
      return isEn ? 'GIF Motion' : 'Animasi GIF';
    }
    return isEn ? 'Media Active' : 'Media Aktif';
  }

  void _showMediaSettingsDialog(BuildContext context, AppSettings settings) {
    final isEn = settings.language == AppLanguage.en;
    final urlController = TextEditingController(
      text: _cardMediaSource?.startsWith('http') == true ? _cardMediaSource : '',
    );

    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AlertDialog(
          backgroundColor: settings.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: settings.primaryColor.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: settings.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.video_collection_rounded,
                  color: settings.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isEn ? 'Card Media Background' : 'Latar Media Kartu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: settings.textColor,
                  ),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEn
                      ? 'Select or insert dynamic media for the top profile card (Video Link, Manual Asset Video, or GIF):'
                      : 'Pilih atau masukkan media dinamis untuk kartu profil atas (Tautan Video, Video Aset Manual, atau GIF):',
                  style: TextStyle(
                    fontSize: 13,
                    color: settings.subTextColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Option 1: Elysia GIF Background (Active Default)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _cardMediaSource == 'assets/ElysiaBackgroundProfile.gif'
                          ? settings.primaryColor
                          : settings.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  tileColor: _cardMediaSource == 'assets/ElysiaBackgroundProfile.gif'
                      ? settings.primaryColor.withValues(alpha: 0.12)
                      : settings.surfaceColor.withValues(alpha: 0.5),
                  leading: Icon(
                    Icons.auto_awesome_motion_rounded,
                    color: settings.primaryColor,
                  ),
                  title: Text(
                    isEn ? 'Elysia GIF Background' : 'Latar Belakang Elysia GIF',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    'assets/ElysiaBackgroundProfile.gif',
                    style: TextStyle(
                      fontSize: 11,
                      color: settings.subTextColor,
                    ),
                  ),
                  trailing: _cardMediaSource == 'assets/ElysiaBackgroundProfile.gif'
                      ? Icon(Icons.check_circle_rounded, color: settings.primaryColor, size: 20)
                      : null,
                  onTap: () {
                    setState(() {
                      _cardMediaSource = 'assets/ElysiaBackgroundProfile.gif';
                    });
                    Navigator.of(ctx).pop();
                  },
                ),

                const SizedBox(height: 10),

                // Option 2: Preset Asset Video
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _cardMediaSource == 'assets/AlvinCardBackGround.mp4'
                          ? settings.primaryColor
                          : settings.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  tileColor: _cardMediaSource == 'assets/AlvinCardBackGround.mp4'
                      ? settings.primaryColor.withValues(alpha: 0.12)
                      : settings.surfaceColor.withValues(alpha: 0.5),
                  leading: Icon(
                    Icons.movie_rounded,
                    color: settings.primaryColor,
                  ),
                  title: Text(
                    isEn ? 'Manual Asset Video' : 'Video Aset Manual',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    'assets/AlvinCardBackGround.mp4',
                    style: TextStyle(
                      fontSize: 11,
                      color: settings.subTextColor,
                    ),
                  ),
                  trailing: _cardMediaSource == 'assets/AlvinCardBackGround.mp4'
                      ? Icon(Icons.check_circle_rounded, color: settings.primaryColor, size: 20)
                      : null,
                  onTap: () {
                    setState(() {
                      _cardMediaSource = 'assets/AlvinCardBackGround.mp4';
                    });
                    Navigator.of(ctx).pop();
                  },
                ),

                const SizedBox(height: 10),

                // Option 2: Ambient Gradient (No Video)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _cardMediaSource == null
                          ? settings.primaryColor
                          : settings.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  tileColor: _cardMediaSource == null
                      ? settings.primaryColor.withValues(alpha: 0.12)
                      : settings.surfaceColor.withValues(alpha: 0.5),
                  leading: Icon(
                    Icons.gradient_rounded,
                    color: settings.primaryColor,
                  ),
                  title: Text(
                    isEn ? 'Ambient Theme Glow' : 'Pendar Ambien Tema',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    isEn ? 'Signature frosted lavender/violet glow' : 'Pendar lavender/violet khas REV',
                    style: TextStyle(
                      fontSize: 11,
                      color: settings.subTextColor,
                    ),
                  ),
                  trailing: _cardMediaSource == null
                      ? Icon(Icons.check_circle_rounded, color: settings.primaryColor, size: 20)
                      : null,
                  onTap: () {
                    setState(() {
                      _cardMediaSource = null;
                    });
                    Navigator.of(ctx).pop();
                  },
                ),

                const SizedBox(height: 16),

                // Option 3: Custom Video Link or GIF URL
                Text(
                  isEn ? 'Or insert Video / GIF Link:' : 'Atau masukkan tautan Video / GIF:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: settings.textColor,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: urlController,
                  style: TextStyle(fontSize: 13, color: settings.textColor),
                  decoration: InputDecoration(
                    hintText: 'https://example.com/video.mp4 or .gif',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: settings.subTextColor.withValues(alpha: 0.6),
                    ),
                    filled: true,
                    fillColor: settings.surfaceColor.withValues(alpha: 0.5),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: settings.primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: settings.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                isEn ? 'Close' : 'Tutup',
                style: TextStyle(color: settings.subTextColor),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                final input = urlController.text.trim();
                if (input.isNotEmpty) {
                  setState(() {
                    _cardMediaSource = input;
                  });
                }
                Navigator.of(ctx).pop();
              },
              icon: const Icon(Icons.check_rounded, size: 16),
              label: Text(isEn ? 'Apply Link' : 'Terapkan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;

        return ResponsivePageTemplate(
          fullWidth: true,
          isScrollable: false, // Ensures CvPage's scrollview and NotificationListener receive scroll events
          showBackButton: false, // Handled inside full-width banner and sticky top bar
          showFooter: false,
          showFAB: true,
          child: Stack(
            children: [
              // ─── Main Scrollable Body ─────────────────────────────────────────
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  final shouldShow = notification.metrics.pixels > 60;
                  if (shouldShow != _showStickyTopBar) {
                    setState(() {
                      _showStickyTopBar = shouldShow;
                    });
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Full-Width Top Header Card
                      _buildFullWidthHeaderCard(context, settings, isEn),

                      const SizedBox(height: 28),

                      // 2. Tabbed Navigation Bar (Center Pinned Container)
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1100),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveLayout.value(
                                context,
                                mobile: 16.0,
                                tablet: 24.0,
                                desktop: 32.0,
                              ),
                            ),
                            child: _buildTabBarControl(context, settings, isEn),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 3. Tab Content Pane (No need to scroll endlessly!)
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1100),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveLayout.value(
                                context,
                                mobile: 16.0,
                                tablet: 24.0,
                                desktop: 32.0,
                              ),
                            ),
                            child: _buildActiveTabContent(context, settings, isEn),
                          ),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // 4. Responsive Footer
                      const ResponsiveFooter(),
                    ],
                  ),
                ),
              ),

              // ─── Sticky Top Bar (Appears when scrolled) ───────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  offset: _showStickyTopBar ? Offset.zero : const Offset(0, -1),
                  curve: Curves.easeInOutCubic,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _showStickyTopBar ? 1.0 : 0.0,
                    child: _buildStickyTopBar(context, settings, isEn),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Multi-Color Developer Name (Pink, Purple, Blue, Yellow, Green) ─────────
  Widget _buildMultiColorName({
    required AppSettings settings,
    required double fontSize,
    String? nameText,
    FontWeight fontWeight = FontWeight.w900,
    TextAlign textAlign = TextAlign.start,
    double letterSpacing = -1.2,
  }) {
    final isDark = settings.theme == AppThemeMode.dark;
    // Light Pastel tones only: Light Pink, Light Purple, Light Blue, Light Yellow, Little bit Light Green
    final colors = isDark
        ? const [
            Color(0xFFF472B6), // Light Pink (Pastel Rose)
            Color(0xFFC084FC), // Light Purple (Soft Lavender)
            Color(0xFF38BDF8), // Light Blue (Soft Sky Blue)
            Color(0xFFFDE047), // Light Yellow (Pastel Lemon)
            Color(0xFF4ADE80), // Little bit Light Green (Soft Mint)
          ]
        : const [
            Color(0xFFF472B6), // Light Pink (Soft Pastel Pink)
            Color(0xFFA855F7), // Light Purple (Soft Lavender Lilac)
            Color(0xFF38BDF8), // Light Blue (Light Sky Blue)
            Color(0xFFFBBF24), // Light Yellow (Soft Warm Light Yellow)
            Color(0xFF34D399), // Little bit Light Green (Soft Mint Green)
          ];

    final text = nameText ?? _profile.name;
    final List<InlineSpan> spans = [];
    int colorIdx = 0;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        spans.add(TextSpan(
          text: ' ',
          style: TextStyle(fontSize: fontSize),
        ));
      } else {
        final color = colors[colorIdx % colors.length];
        spans.add(TextSpan(
          text: char,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            height: 1.1,
            shadows: [
              Shadow(
                color: isDark
                    ? color.withValues(alpha: 0.5)
                    : settings.textColor.withValues(alpha: 0.12),
                blurRadius: isDark ? 10 : 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ));
        colorIdx++;
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ─── 1. FULL-WIDTH TOP HEADER CARD ──────────────────────────────────────────
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildFullWidthHeaderCard(
      BuildContext context, AppSettings settings, bool isEn) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return CardMediaBackground(
      mediaPath: _cardMediaSource,
      uniqueId: 'cv-header-card',
      overlayAlpha: settings.theme == AppThemeMode.dark ? 0.78 : 0.84,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: settings.primaryColor.withValues(alpha: 0.16),
              width: 1.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          ResponsiveLayout.value(
            context,
            mobile: 18.0,
            tablet: 32.0,
            desktop: 48.0,
          ),
          20.0,
          ResponsiveLayout.value(
            context,
            mobile: 18.0,
            tablet: 32.0,
            desktop: 48.0,
          ),
          36.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Nav Strip: Back to Home + Media Switcher + Studio Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back to Home
                // Top Left: Back to Home & Profile Switcher Pill
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: settings.textColor,
                      ),
                      label: Text(
                        isEn ? 'Home' : 'Beranda',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: settings.textColor,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor:
                            settings.surfaceColor.withValues(alpha: 0.6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: settings.primaryColor
                                .withValues(alpha: 0.18),
                          ),
                        ),
                      ),
                    ),

                    // Contributor Switcher Pill
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: settings.surfaceColor.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: settings.primaryColor.withValues(alpha: 0.22),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: CvProfileRepository.allProfiles.map((p) {
                          final isSelected = p.id == _profile.id;
                          return InkWell(
                            onTap: () => _switchProfile(p.id),
                            borderRadius: BorderRadius.circular(99),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? settings.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(99),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: settings.primaryColor
                                              .withValues(alpha: 0.35),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    p.id == 'alfon' ? '👑' : '💻',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    p.name.split(' ').first,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : settings.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                // Right: Media Switcher + Studio Badge
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Dynamic Media Switcher Pill (Video / URL / GIF)
                    InkWell(
                      onTap: () => _showMediaSettingsDialog(context, settings),
                      borderRadius: BorderRadius.circular(99),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: settings.surfaceColor.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: settings.primaryColor.withValues(alpha: 0.22),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.movie_filter_rounded,
                              size: 14,
                              color: settings.primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getMediaLabel(isEn),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: settings.textColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.tune_rounded,
                              size: 12,
                              color: settings.subTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Studio Dev Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: settings.primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: settings.primaryColor.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF10B981), // Emerald green
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isEn ? _profile.statusEn : _profile.statusId,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: settings.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Main Profile Row: Avatar with No Border + Blurry Reflection Halo
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                // ─── Photo Profile Default (Portrait Orientation with Blurred Reflection) ───
                _buildPortraitPhotoWithReflection(
                  settings,
                  photoAssetPath: _profile.photoAsset,
                ),

              SizedBox(
                width: isMobile ? 0 : 36,
                height: isMobile ? 24 : 0,
              ),

              // ─── Name, Position at Relva Studio & Bio ───────────────────────
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    // Multi-color Full Name (Pink, Purple, Blue, Yellow, Green)
                    _buildMultiColorName(
                      settings: settings,
                      fontSize: ResponsiveLayout.value(
                        context,
                        mobile: 30.0,
                        tablet: 38.0,
                        desktop: 44.0,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ),
                    const SizedBox(height: 8),

                    // Position in Relva Studio (highlighted badge/text)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          isEn ? _profile.roleEn : _profile.roleId,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: settings.primaryColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                settings.primaryColor,
                                settings.accentColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _profile.companyBadge,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Description for Relva Studio Dev
                    Text(
                      isEn ? _profile.bioShortEn : _profile.bioShortId,
                      style: TextStyle(
                        fontSize: 14,
                        color: settings.subTextColor,
                        height: 1.6,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ),

                    const SizedBox(height: 20),

                    // Action buttons & quick links
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _buildActionChip(
                          context: context,
                          settings: settings,
                          icon: Icons.download_rounded,
                          label: isEn ? 'Download CV (PDF)' : 'Unduh CV (PDF)',
                          isPrimary: true,
                          onTap: () => _showDownloadCvDialog(context, settings),
                        ),
                        _buildActionChip(
                          context: context,
                          settings: settings,
                          icon: Icons.location_on_rounded,
                          label: isEn ? _profile.locationEn : _profile.locationId,
                          onTap: () {},
                        ),
                        _buildActionChip(
                          context: context,
                          settings: settings,
                          icon: Icons.mail_rounded,
                          label: _profile.email,
                          onTap: () => _copyToClipboard(
                            context,
                            _profile.email,
                            isEn
                                ? 'Email copied to clipboard!'
                                : 'Email disalin ke papan klip!',
                          ),
                        ),
                        _buildActionChip(
                          context: context,
                          settings: settings,
                          icon: Icons.code_rounded,
                          label: 'GitHub',
                          onTap: () => _launchExternalUrl(_profile.githubUrl),
                        ),
                        _buildActionChip(
                          context: context,
                          settings: settings,
                          icon: Icons.work_outline_rounded,
                          label: 'LinkedIn',
                          onTap: () => _launchExternalUrl(_profile.linkedinUrl),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          Divider(color: settings.primaryColor.withValues(alpha: 0.12)),
          const SizedBox(height: 24),

          // ─── Key Metrics Strip (Under Header) ──────────────────────────────
          _buildMetricsStrip(context, settings, isEn),
        ],
      ),
    ),
  );
  }

  // ─── Default Portrait Photo with Blurred Reflection Background ────────────
  Widget _buildPortraitPhotoWithReflection(AppSettings settings,
      {String? photoAssetPath}) {
    const double photoWidth = 148;
    const double photoHeight = 192;
    final borderRadius = BorderRadius.circular(22);
    final assetToUse = photoAssetPath ?? 'assets/ElysiaMeme.gif';

    return HoverCard(
      hoverOffset: -5,
      hoverScale: 1.03,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Outside Blurry Background Reflection Glow
          Container(
            width: photoWidth + 16,
            height: photoHeight + 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: settings.primaryColor.withValues(alpha: 0.45),
                  blurRadius: 36,
                  spreadRadius: 6,
                ),
                BoxShadow(
                  color: settings.accentColor.withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(6, 8),
                ),
              ],
            ),
          ),

          // 2. Frosted Reflection Glass Aura
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                width: photoWidth + 8,
                height: photoHeight + 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: RadialGradient(
                    colors: [
                      settings.primaryColor.withValues(alpha: 0.25),
                      settings.cardColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Main Portrait Photo (Seamless & borderless)
          Container(
            width: photoWidth,
            height: photoHeight,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: settings.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Photo Profile image (AlvinPhotoProfile.jpg) with web-safe fallback
                  _buildProfilePhoto(assetToUse, settings),

                  // Subtle gradient shadow at bottom for label readability
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 52,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.55),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom frosted glass badge tag: RELVA DEV
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          color: Colors.black.withValues(alpha: 0.25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF10B981), // Emerald online dot
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _profile.badgeLabel,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildProfilePhoto(String path, AppSettings settings,
      {BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(
        path,
        fit: fit,
        errorBuilder: (ctx, err, stack) => Image.asset(
          path,
          fit: fit,
          errorBuilder: (ctx2, err2, stack2) =>
              _buildDefaultPortraitFigure(settings),
        ),
      );
    }
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (ctx, err, stack) =>
          _buildDefaultPortraitFigure(settings),
    );
  }

  Widget _buildCircleFallback(AppSettings settings) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            settings.primaryColor,
            settings.accentColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _profile.initials,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultPortraitFigure(AppSettings settings) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            settings.primaryColor,
            settings.surfaceColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          // Head with monogram / avatar icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.45),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                _profile.initials,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Shoulders / Torso silhouette
          Container(
            width: 92,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.badge_rounded,
                size: 16,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _buildActionChip({
    required BuildContext context,
    required AppSettings settings,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return HoverCard(
      hoverOffset: -3.0,
      hoverScale: 1.03,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isPrimary
                ? settings.primaryColor
                : settings.surfaceColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary
                  ? settings.primaryColor
                  : settings.primaryColor.withValues(alpha: 0.15),
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: settings.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isPrimary ? Colors.white : settings.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                  color: isPrimary ? Colors.white : settings.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Metrics Strip ──────────────────────────────────────────────────────────
  Widget _buildMetricsStrip(
      BuildContext context, AppSettings settings, bool isEn) {
    final stats = [
      {'val': _profile.experienceYears, 'lbl': isEn ? 'Years Experience' : 'Tahun Pengalaman'},
      {'val': _profile.deliveredProjects, 'lbl': isEn ? 'Delivered Projects' : 'Proyek Selesai'},
      {'val': _profile.qualityStandard, 'lbl': isEn ? 'Quality Standard' : 'Standar Kualitas'},
      {'val': _profile.techFrameworks, 'lbl': isEn ? 'Tech Frameworks' : 'Teknologi Dikuasai'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 650;

        if (isSmall) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: settings.surfaceColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: settings.primaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedCounter(
                      targetText: stats[index]['val']!,
                      settings: settings,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stats[index]['lbl']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: settings.subTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: settings.surfaceColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: settings.primaryColor.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(stats.length * 2 - 1, (index) {
              if (index.isOdd) {
                return Container(
                  height: 38,
                  width: 1,
                  color: settings.primaryColor.withValues(alpha: 0.15),
                );
              }
              final itemIndex = index ~/ 2;
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedCounter(
                      targetText: stats[itemIndex]['val']!,
                      settings: settings,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stats[itemIndex]['lbl']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: settings.subTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ─── 2. TABBED PANE NAVIGATION CONTROL ──────────────────────────────────────
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTabBarControl(
      BuildContext context, AppSettings settings, bool isEn) {
    final tabItems = [
      {'label': isEn ? 'Overview' : 'Profil & Ringkasan', 'icon': Icons.person_rounded},
      {'label': isEn ? 'Skills' : 'Keahlian Teknis', 'icon': Icons.psychology_alt_rounded},
      {'label': isEn ? 'Experience' : 'Pengalaman', 'icon': Icons.work_history_rounded},
      {'label': isEn ? 'Projects' : 'Proyek Relva', 'icon': Icons.rocket_launch_rounded},
      {'label': isEn ? 'Education' : 'Pendidikan', 'icon': Icons.school_rounded},
      {'label': isEn ? 'Contact' : 'Kontak', 'icon': Icons.send_rounded},
    ];

    return Container(
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.14),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(tabItems.length, (idx) {
            final isSelected = _tabController.index == idx;
            final item = tabItems[idx];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: HoverCard(
                hoverOffset: -2,
                hoverScale: 1.02,
                child: InkWell(
                  onTap: () {
                    _tabController.animateTo(idx);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? settings.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: settings.primaryColor.withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 16,
                          color: isSelected ? Colors.white : settings.textColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['label'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : settings.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ─── 3. ACTIVE TAB CONTENT PANE ─────────────────────────────────────────────
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildActiveTabContent(
      BuildContext context, AppSettings settings, bool isEn) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: KeyedSubtree(
        key: ValueKey<int>(_tabController.index),
        child: _getTabContentByIndex(_tabController.index, context, settings, isEn),
      ),
    );
  }

  Widget _getTabContentByIndex(
      int index, BuildContext context, AppSettings settings, bool isEn) {
    switch (index) {
      case 0:
        return _buildAboutTab(context, settings, isEn);
      case 1:
        return _buildSkillsTab(context, settings, isEn);
      case 2:
        return _buildExperienceTab(context, settings, isEn);
      case 3:
        return _buildProjectsTab(context, settings, isEn);
      case 4:
        return _buildEducationTab(context, settings, isEn);
      case 5:
        return _buildContactTab(context, settings, isEn);
      default:
        return _buildAboutTab(context, settings, isEn);
    }
  }

  // ─── TAB 0: ABOUT / EXECUTIVE SUMMARY ───────────────────────────────────────
  Widget _buildAboutTab(BuildContext context, AppSettings settings, bool isEn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          settings: settings,
          title: isEn
              ? '👑 ${_profile.name} — Profile & Vision'
              : '👑 ${_profile.name} — Profil & Visi',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEn ? _profile.bioDetailEn : _profile.bioDetailId,
                style: TextStyle(
                  fontSize: 15,
                  color: settings.textColor.withValues(alpha: 0.88),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildBadge(settings, _profile.companyBadge),
                  _buildBadge(settings, '🏥 Medical-Grade Healthcare (MAPOTECH)'),
                  _buildBadge(settings, '⚡ High-Performance Systems'),
                  _buildBadge(settings, '📐 Clean Architecture & Scalability'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Core Pillars
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 700;
            final pillarWidth = isNarrow
                ? constraints.maxWidth
                : (constraints.maxWidth - 24) / 3;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _pillarCard(
                  icon: Icons.auto_awesome_rounded,
                  title: isEn ? 'Zero-UI-Lib Craft' : 'Bebas Ketergantungan UI',
                  desc: isEn
                      ? '100% native Flutter widgets for micro-interactions, responsive layouts, and unified design tokens.'
                      : '100% widget bawaan Flutter untuk interaksi mikro, layout responsif, dan token desain konsisten.',
                  width: pillarWidth,
                  settings: settings,
                ),
                _pillarCard(
                  icon: Icons.architecture_rounded,
                  title: isEn ? 'Clean Architecture' : 'Arsitektur Bersih',
                  desc: isEn
                      ? 'Strict layer decoupling (Domain, Data, UI) guaranteeing testability, modularity, and future scalability.'
                      : 'Pemisahan layer yang tegas (Domain, Data, UI) memastikan modularitas dan kemudahan pengujian.',
                  width: pillarWidth,
                  settings: settings,
                ),
                _pillarCard(
                  icon: Icons.speed_rounded,
                  title: isEn ? 'High Performance Web' : 'Web Berkecepatan Tinggi',
                  desc: isEn
                      ? 'Fluid 60fps animations, optimized canvas rendering, and proactive state reactivity.'
                      : 'Animasi 60fps lancar, optimasi canvas rendering, dan manajemen state yang reaktif.',
                  width: pillarWidth,
                  settings: settings,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _pillarCard({
    required IconData icon,
    required String title,
    required String desc,
    required double width,
    required AppSettings settings,
  }) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: settings.cardColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: settings.primaryColor.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: settings.primaryColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: settings.primaryColor),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: settings.textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: settings.subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── TAB 1: TECHNICAL SKILLS & MATRIX ───────────────────────────────────────
  Widget _buildSkillsTab(BuildContext context, AppSettings settings, bool isEn) {
    final categories = [
      isEn ? 'All Areas' : 'Semua',
      isEn ? 'Frontend & UI/UX' : 'Frontend & UI/UX',
      isEn ? 'Backend & Systems' : 'Backend & Sistem',
      isEn ? 'Architecture & Tools' : 'Arsitektur & Alat',
    ];

    final allSkills = _profile.skills.map((s) {
      return {
        'category': (s['category'] as int?) ?? 1,
        'title': s['name'] as String,
        'level': (s['pct'] as num).toDouble(),
        'text': '${((s['pct'] as num) * 100).toInt()}%',
      };
    }).toList();

    final filteredSkills = _activeSkillCategory == 0
        ? allSkills
        : allSkills.where((s) => s['category'] == _activeSkillCategory).toList();

    return _buildSectionCard(
      settings: settings,
      title: isEn ? '🛠️ Technical Skills & Competencies' : '🛠️ Keahlian & Penguasaan Teknologi',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (idx) {
                final isSelected = _activeSkillCategory == idx;
                return Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() => _activeSkillCategory = idx),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? settings.primaryColor
                            : settings.surfaceColor.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? settings.primaryColor
                              : settings.primaryColor.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text(
                        categories[idx],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : settings.textColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth > 650;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTwoCol ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 72,
                ),
                itemCount: filteredSkills.length,
                itemBuilder: (context, index) {
                  final item = filteredSkills[index];
                  return _buildSkillProgressTile(
                    settings: settings,
                    title: item['title'] as String,
                    level: item['level'] as double,
                    percentText: item['text'] as String,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillProgressTile({
    required AppSettings settings,
    required String title,
    required double level,
    required String percentText,
  }) {
    return TweenAnimationBuilder<double>(
      key: ValueKey('$title-$_activeSkillCategory'),
      tween: Tween<double>(begin: 0.0, end: level),
      duration: const Duration(milliseconds: 1100),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, _) {
        final currentPercent = (animValue * 100).toInt();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: settings.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$currentPercent%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: settings.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: Container(
                height: 8,
                width: double.infinity,
                color: settings.surfaceColor,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: animValue.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          settings.primaryColor,
                          settings.accentColor,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─── TAB 2: WORK EXPERIENCE ─────────────────────────────────────────────────
  Widget _buildExperienceTab(
      BuildContext context, AppSettings settings, bool isEn) {
    final experiences = _profile.experiences.map((exp) {
      return {
        'role': isEn ? exp['roleEn'] : exp['roleId'],
        'company': exp['company'] as String,
        'period': exp['period'] as String,
        'location': 'Bondowoso / Remote',
        'desc': isEn ? exp['descEn'] : exp['descId'],
        'achievements': <String>[],
        'tags': exp['tags'] as List<String>,
      };
    }).toList();

    return _buildSectionCard(
      settings: settings,
      title: isEn ? '💼 Professional Journey' : '💼 Pengalaman Kerja & Kepemimpinan',
      child: Column(
        children: List.generate(experiences.length, (index) {
          final exp = experiences[index];
          final isLast = index == experiences.length - 1;
          return _buildTimelineItem(
            settings: settings,
            role: exp['role'] as String,
            company: exp['company'] as String,
            period: exp['period'] as String,
            location: exp['location'] as String,
            desc: exp['desc'] as String,
            achievements: exp['achievements'] as List<String>,
            tags: exp['tags'] as List<String>,
            isLast: isLast,
          );
        }),
      ),
    );
  }

  Widget _buildTimelineItem({
    required AppSettings settings,
    required String role,
    required String company,
    required String period,
    required String location,
    required String desc,
    required List<String> achievements,
    required List<String> tags,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Node
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: settings.primaryColor,
                  border: Border.all(
                    color: settings.cardColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: settings.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: settings.primaryColor.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 18),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: HoverCard(
                hoverOffset: -4.0,
                hoverScale: 1.01,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: settings.surfaceColor.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: settings.primaryColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  role,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: settings.textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$company • $location',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: settings.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: settings.cardColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: settings.primaryColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              period,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: settings.subTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 14,
                          color: settings.textColor.withValues(alpha: 0.8),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...achievements.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 16,
                                  color: settings.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: settings.subTextColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tags
                            .map((tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: settings.cardColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: settings.primaryColor.withValues(alpha: 0.12),
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: settings.textColor,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── TAB 3: FEATURED PROJECTS ───────────────────────────────────────────────
  Widget _buildProjectsTab(
      BuildContext context, AppSettings settings, bool isEn) {
    final projects = _profile.projects.map((proj) {
      return {
        'title': proj['title'] as String,
        'subtitle': isEn
            ? (proj['subtitleEn'] ?? proj['subtitle'] as String)
            : (proj['subtitleId'] ?? proj['subtitle'] as String),
        'badge': proj['badge'] as String,
        'desc': isEn
            ? (proj['descEn'] ?? proj['desc'] as String)
            : (proj['descId'] ?? proj['desc'] as String),
        'tags': proj['tags'] as List<String>,
        'icon': proj['icon'] as IconData,
        'actionRoute': proj['actionRoute'] as String?,
        'actionUrl': proj['actionUrl'] as String?,
        'actionLabel': isEn
            ? (proj['actionLabelEn'] ?? proj['actionLabel'] as String?)
            : (proj['actionLabelId'] ?? proj['actionLabel'] as String?) ??
                (isEn ? 'View Platform →' : 'Buka Platform →'),
      };
    }).toList();

    return _buildSectionCard(
      settings: settings,
      title: isEn ? '🚀 Key Featured Projects at Relva' : '🚀 Proyek Unggulan Terpilih di Relva',
      child: Column(
        children: projects.map((proj) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HoverCard(
              hoverOffset: -5.0,
              hoverScale: 1.02,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: settings.surfaceColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: settings.primaryColor.withValues(alpha: 0.16),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: settings.primaryColor.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            proj['icon'] as IconData,
                            color: settings.primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                proj['title'] as String,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: settings.textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                proj['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: settings.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: settings.cardColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: settings.primaryColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            proj['badge'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: settings.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      proj['desc'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: settings.textColor.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (proj['tags'] as List<String>)
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: settings.cardColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: settings.primaryColor.withValues(alpha: 0.12),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: settings.subTextColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    if (proj['actionRoute'] != null || proj['actionUrl'] != null) ...[
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          if (proj['actionRoute'] != null) {
                            Navigator.of(context).pushNamed(proj['actionRoute'] as String);
                          } else if (proj['actionUrl'] != null) {
                            _launchExternalUrl(proj['actionUrl'] as String);
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              proj['actionLabel'] != null
                                  ? (proj['actionLabel'] as String)
                                  : (isEn ? 'View Live Platform' : 'Buka Platform Langsung'),
                              style: TextStyle(
                                color: settings.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              proj['actionUrl'] != null
                                  ? Icons.open_in_new_rounded
                                  : Icons.arrow_forward_rounded,
                              size: 14,
                              color: settings.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─── TAB 4: EDUCATION & CERTIFICATIONS ──────────────────────────────────────
  Widget _buildEducationTab(
      BuildContext context, AppSettings settings, bool isEn) {
    final educations = _profile.educations.map((school) {
      return {
        'title': school['title'] as String,
        'degree': isEn
            ? (school['degreeEn'] ?? school['degree'] as String)
            : (school['degreeId'] ?? school['degree'] as String),
        'department': isEn
            ? (school['departmentEn'] ?? school['department'] as String)
            : (school['departmentId'] ?? school['department'] as String),
        'period': school['period'] as String,
        'badge': isEn
            ? (school['badgeEn'] ?? school['badge'] as String)
            : (school['badgeId'] ?? school['badge'] as String),
        'isOngoing': school['isOngoing'] as bool,
        'progress': (school['progress'] as num).toDouble(),
        'progressNote': isEn
            ? (school['progressNoteEn'] ?? school['progressNote'] as String)
            : (school['progressNoteId'] ?? school['progressNote'] as String),
        'desc': isEn
            ? (school['descEn'] ?? school['desc'] as String)
            : (school['descId'] ?? school['desc'] as String),
        'tags': school['tags'] as List<String>,
        'icon': school['icon'] as IconData,
        'asset': school['asset'] as String?,
        'acronym': school['acronym'] as String? ?? 'SCH',
        'actionUrl': school['actionUrl'] as String?,
        'actionLabel': isEn
            ? (school['actionLabelEn'] ?? school['actionLabel'] as String?)
            : (school['actionLabelId'] ?? school['actionLabel'] as String?),
      };
    }).toList();

    return _buildSectionCard(
      settings: settings,
      title: isEn ? '🎓 Education & Academic History' : '🎓 Pendidikan & Riwayat Studi',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth <= 650;
          return Column(
            children: educations.map((school) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: HoverCard(
                  hoverOffset: -5.0,
                  hoverScale: 1.015,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: settings.surfaceColor.withValues(alpha: 0.42),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: settings.primaryColor.withValues(alpha: 0.16),
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // ── 1. RIGHT-SIDE CIRCULAR BLURRY PHOTO / EMBLEM (FACING LEFT) ──
                        // "posisi nya bener di kanan cumak cirklenya menghadap kiri gitu"
                        _buildSchoolRightBadge(
                          school: school,
                          settings: settings,
                          isMobile: isMobile,
                        ),

                        // ── 2. CARD CONTENT (Main Column) ──
                        Padding(
                          padding: EdgeInsets.all(isMobile ? 18.0 : 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Row: School Icon + Title & Degree + Level Badge
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSchoolLeadingIcon(school, settings),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          school['title'] as String,
                                          style: TextStyle(
                                            fontSize: isMobile ? 16 : 18,
                                            fontWeight: FontWeight.bold,
                                            color: settings.textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          school['degree'] as String,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: settings.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${school['department']} • ${school['period']}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: settings.subTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!isMobile) ...[
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: settings.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: settings.primaryColor.withValues(alpha: 0.22),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.04),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        school['badge'] as String,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: settings.textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Description
                              Text(
                                school['desc'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: settings.textColor.withValues(alpha: 0.82),
                                  height: 1.55,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Tags
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (school['tags'] as List<String>)
                                    .map(
                                      (tag) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: settings.cardColor,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: settings.primaryColor
                                                .withValues(alpha: 0.14),
                                          ),
                                        ),
                                        child: Text(
                                          tag,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: settings.subTextColor,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 18),

                              // ── PROGRESS BAR (ON-GOING vs DONE) ──
                              _buildEducationProgressBar(
                                school: school,
                                settings: settings,
                                isEn: isEn,
                              ),

                              // ── SCHOOL WEBSITE LINK (IF AVAILABLE) ──
                              const SizedBox(height: 14),
                              _buildSchoolLink(
                                school: school,
                                settings: settings,
                                isEn: isEn,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  /// Right-side circular school emblem facing left with blurry reflection
  Widget _buildSchoolRightBadge({
    required Map<String, dynamic> school,
    required AppSettings settings,
    required bool isMobile,
  }) {
    final String? assetPath = school['asset'] as String?;
    final String acronym = school['acronym'] as String? ?? 'SCH';
    final double diameter = isMobile ? 120.0 : 168.0;

    return Positioned(
      right: isMobile ? -25 : -10,
      top: 0,
      bottom: 0,
      width: isMobile ? 160 : 260,
      child: IgnorePointer(
        child: Align(
          alignment: Alignment.centerRight,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withValues(alpha: isMobile ? 0.35 : 0.88),
                  Colors.white.withValues(alpha: isMobile ? 0.22 : 0.55),
                  Colors.white.withValues(alpha: isMobile ? 0.08 : 0.18),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.40, 0.72, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              width: diameter,
              height: diameter,
              margin: EdgeInsets.only(right: isMobile ? 8 : 22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: settings.cardColor.withValues(alpha: 0.90),
                border: Border.all(
                  color: settings.primaryColor.withValues(alpha: 0.25),
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: settings.primaryColor.withValues(alpha: 0.28),
                    blurRadius: 36,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: ClipOval(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // School emblem or crest
                    _buildSchoolEmblemContent(assetPath, acronym, settings),

                    // Gradual glassy blur & frosted gradient layer
                    // Makes the circle face left (clear on left) and increasingly blurry & translucent towards the right
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            settings.surfaceColor.withValues(alpha: 0.30),
                            settings.surfaceColor.withValues(alpha: 0.70),
                            settings.cardColor.withValues(alpha: 0.95),
                          ],
                          stops: const [0.0, 0.45, 0.78, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Leading icon for school card (top-left)
  Widget _buildSchoolLeadingIcon(
      Map<String, dynamic> school, AppSettings settings) {
    final IconData icon = school['icon'] as IconData;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: settings.primaryColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.20),
        ),
      ),
      child: Icon(
        icon,
        color: settings.primaryColor,
        size: 26,
      ),
    );
  }

  Widget _buildSchoolEmblemContent(
      String? assetPath, String acronym, AppSettings settings) {
    if (assetPath != null && assetPath.isNotEmpty) {
      final Widget img = kIsWeb
          ? Image.network(
              assetPath,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) => Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (ctx2, err2, stack2) =>
                    _buildSchoolCrestFallback(acronym, settings),
              ),
            )
          : Image.asset(
              assetPath,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) =>
                  _buildSchoolCrestFallback(acronym, settings),
            );

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Center(child: img),
      );
    }
    return _buildSchoolCrestFallback(acronym, settings);
  }

  Widget _buildSchoolCrestFallback(String acronym, AppSettings settings) {
    final bool isPetra = acronym.contains('PETRA');
    final IconData icon =
        isPetra ? Icons.school_rounded : Icons.military_tech_rounded;
    final List<Color> bgGradient = isPetra
        ? [const Color(0xFF1E3A8A), const Color(0xFF2563EB), const Color(0xFFF59E0B)]
        : [const Color(0xFF1E1B4B), const Color(0xFF4338CA), const Color(0xFF8B5CF6)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bgGradient,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 38),
          const SizedBox(height: 6),
          Text(
            acronym,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Progress bar for education: On-going (75% animated style) vs Done (100% completed checkmark)
  Widget _buildEducationProgressBar({
    required Map<String, dynamic> school,
    required AppSettings settings,
    required bool isEn,
  }) {
    final bool isOngoing = school['isOngoing'] as bool? ?? false;
    final double progress = (school['progress'] as num?)?.toDouble() ?? 1.0;
    final int percentInt = (progress * 100).toInt();

    final Color statusColor =
        isOngoing ? const Color(0xFF38BDF8) : const Color(0xFF10B981);
    final String statusLabel = isOngoing
        ? (isEn ? 'ON-GOING • ACTIVE DEGREE' : 'SEDANG MENEMPUH • AKTIF')
        : (isEn ? 'COMPLETED • GRADUATED' : 'LULUS • SELESAI');

    final List<Color> barGradient = isOngoing
        ? [
            const Color(0xFF818CF8),
            const Color(0xFFC084FC),
            const Color(0xFFF472B6),
          ]
        : [
            const Color(0xFF10B981),
            const Color(0xFF06B6D4),
            settings.primaryColor,
          ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.24),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Status Badge + Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1.5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '$percentInt% ${isEn ? "Completed" : "Pencapaian"}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // The Progress Bar Track & Fill
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 8,
              width: double.infinity,
              color: settings.primaryColor.withValues(alpha: 0.10),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: barGradient),
                    boxShadow: [
                      BoxShadow(
                        color: barGradient.last.withValues(alpha: 0.45),
                        blurRadius: 8,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Progress Milestone / Curriculum note
          Text(
            school['progressNote'] as String? ?? '',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: settings.textColor.withValues(alpha: 0.70),
            ),
          ),
        ],
      ),
    );
  }

  /// School website link button (if URL exists) or verified accreditation badge
  Widget _buildSchoolLink({
    required Map<String, dynamic> school,
    required AppSettings settings,
    required bool isEn,
  }) {
    final String? actionUrl = school['actionUrl'] as String?;
    if (actionUrl == null || actionUrl.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_outlined,
            size: 15,
            color: settings.subTextColor,
          ),
          const SizedBox(width: 6),
          Text(
            isEn
                ? 'Accredited Foundation • Bondowoso, East Java'
                : 'Yayasan Terakreditasi • Bondowoso, Jawa Timur',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: settings.subTextColor,
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () => _launchExternalUrl(actionUrl),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              school['actionLabel'] as String? ??
                  (isEn ? 'Visit School Website' : 'Kunjungi Website Sekolah'),
              style: TextStyle(
                color: settings.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.open_in_new_rounded,
              size: 14,
              color: settings.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  // ─── TAB 5: CONTACT & COLLABORATION ─────────────────────────────────────────
  Widget _buildContactTab(
      BuildContext context, AppSettings settings, bool isEn) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            settings.primaryColor,
            settings.accentColor.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: settings.primaryColor.withValues(alpha: 0.3),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(height: 16),
          Text(
            isEn
                ? 'Ready to build exceptional digital experiences with Relva Studio?'
                : 'Siap mewujudkan pengalaman digital luar biasa bersama Relva Studio?',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            isEn
                ? "Let's collaborate on multiplatform architectures, high-performance Flutter web applications, or custom design engineering projects."
                : 'Mari berkolaborasi pada arsitektur multiplatform, aplikasi Flutter web performa tinggi, atau rekayasa desain kustom.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              HoverCard(
                hoverOffset: -4.0,
                hoverScale: 1.04,
                child: ElevatedButton.icon(
                  onPressed: () => _copyToClipboard(
                    context,
                    'contact@relvastudio.com',
                    isEn
                        ? 'Email copied to clipboard!'
                        : 'Email disalin ke papan klip!',
                  ),
                  icon: Icon(
                    Icons.mail_outline_rounded,
                    color: settings.primaryColor,
                    size: 18,
                  ),
                  label: Text(
                    isEn ? 'Copy Contact Email' : 'Salin Email Kontak',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: settings.primaryColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: settings.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
              HoverCard(
                hoverOffset: -4.0,
                hoverScale: 1.04,
                child: OutlinedButton.icon(
                  onPressed: () => _launchExternalUrl('https://github.com'),
                  icon: const Icon(
                    Icons.open_in_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    isEn ? 'Explore GitHub' : 'Lihat GitHub',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ─── 4. STICKY TOP BAR (WHEN SCROLLED) ──────────────────────────────────────
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildStickyTopBar(
      BuildContext context, AppSettings settings, bool isEn) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: CardMediaBackground(
          mediaPath: _cardMediaSource,
          uniqueId: 'cv-sticky-top-bar',
          overlayAlpha: settings.theme == AppThemeMode.dark ? 0.78 : 0.84,
          child: Container(
            height: 72,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: settings.primaryColor.withValues(alpha: 0.16),
                  width: 1.2,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveLayout.value(
                context,
                mobile: 12.0,
                tablet: 20.0,
                desktop: 32.0,
              ),
            ),
            child: Row(
              children: [
              // ─── Left: Back button to home ────────────────────────────────
              IconButton(
                tooltip: isEn ? 'Back to Home' : 'Kembali ke Beranda',
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: settings.textColor,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: settings.cardColor.withValues(alpha: 0.9),
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: settings.primaryColor.withValues(alpha: 0.18),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ─── IN THE LEFT: Photo Profile (Circle One with Reflection) ───
              Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle ambient blurred reflection
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: settings.primaryColor.withValues(alpha: 0.45),
                          blurRadius: 14,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Borderless circle photo with reflection
                  ClipOval(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: kIsWeb
                          ? Image.network(
                              _profile.photoAsset,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Image.asset(
                                _profile.photoAsset,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx2, err2, stack2) =>
                                    _buildCircleFallback(settings),
                              ),
                            )
                          : Image.asset(
                              _profile.photoAsset,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) =>
                                  _buildCircleFallback(settings),
                            ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 14),

              // ─── IN THE MIDDLE: Name | AND IN THE RIGHT: The Job ───────────
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Multi-color Name in the middle
                    Flexible(
                      flex: isMobile ? 1 : 0,
                      child: _buildMultiColorName(
                        settings: settings,
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),

                    // The "|" divider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '|',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: settings.primaryColor.withValues(alpha: 0.5),
                        ),
                      ),
                    ),

                    // In the right is the job
                    Flexible(
                      child: Text(
                        isEn ? _profile.roleEn : _profile.roleId,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w700,
                          color: settings.primaryColor,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Right quick action: Download CV
              ElevatedButton.icon(
                onPressed: () => _showDownloadCvDialog(context, settings),
                icon: const Icon(Icons.download_rounded, size: 15),
                label: Text(
                  isEn ? 'CV' : 'CV',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: settings.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  // ─── REUSABLE HELPERS ───────────────────────────────────────────────────────
  Widget _buildSectionCard({
    required AppSettings settings,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: settings.cardColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.14),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 22,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: settings.textColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildBadge(AppSettings settings, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: settings.surfaceColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: settings.textColor,
        ),
      ),
    );
  }
}
