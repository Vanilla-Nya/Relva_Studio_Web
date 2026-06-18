import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class MapotechHomePage extends StatefulWidget {
  const MapotechHomePage({super.key});

  @override
  State<MapotechHomePage> createState() => _MapotechHomePageState();
}

class _MapotechHomePageState extends State<MapotechHomePage>
    with TickerProviderStateMixin {
  late TabController _featureTabController;
  late AnimationController _heroAnimController;
  late Animation<double> _heroFadeAnim;
  late Animation<Offset> _heroSlideAnim;
  int _selectedFeatureTab = 0;

  // ─── Dynamic Colors from AppSettings ───────────────────────────────────────
  AppSettings get _settings => AppSettingsProvider.of(context);
  Color get _teal => _settings.primaryColor;
  Color get _tealDark => _settings.primaryColor.withValues(alpha: 0.85);
  Color get _tealLight => _settings.accentColor;
  Color get _bgDark => _settings.backgroundColor;
  Color get _cardDark => _settings.cardColor;
  Color get _cardDark2 => _settings.surfaceColor;

  bool get _isEn => _settings.language == AppLanguage.en;

  final List<String> imageList = [
    'assets/mapotek_1.jpg',
    'assets/mapotek_2.jpg',
    'assets/mapotek_3.jpg',
    'assets/mapotek_4.jpg',
    'assets/poster_mapotek.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _featureTabController = TabController(length: 3, vsync: this);
    _featureTabController.addListener(() {
      if (!_featureTabController.indexIsChanging) {
        setState(() {
          _selectedFeatureTab = _featureTabController.index;
        });
      }
    });
    _heroAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _heroFadeAnim = CurvedAnimation(
      parent: _heroAnimController,
      curve: Curves.easeOut,
    );
    _heroSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _heroAnimController,
            curve: Curves.easeOutCubic,
          ),
        );
    _heroAnimController.forward();
  }

  @override
  void dispose() {
    _featureTabController.dispose();
    _heroAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) {
        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          isScrollable: true,
          fullWidth: true,
          child: Column(
            children: [
              _buildHeroSection(context),
              _buildEcosystemBanner(),
              _buildFeaturesSection(context),
              _buildWorkflowSection(),
              _buildScreenshotsSection(context),
              _buildPlatformSection(),
              _buildTargetSection(),
              _buildIntegrationSection(),
              _buildSecuritySection(),
              _buildStatusSection(),
              _buildCTASection(context),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openMapotechApp(BuildContext context) async {
    final uri = Uri.parse('https://mapotech.onrender.com/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEn
                  ? 'Cannot open MAPOTECH app'
                  : 'Tidak dapat membuka aplikasi MAPOTECH',
            ),
          ),
        );
      }
    }
  }

  // ─── Hero Section ───────────────────────────────────────────────────────────
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _settings.backgroundColor,
            _settings.cardColor,
            _settings.surfaceColor,
            _settings.backgroundColor,
          ],
          stops: const [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Large background circle top-right
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _teal.withValues(alpha: 0.18),
                    _teal.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Medium circle bottom-left
          Positioned(
            bottom: -60,
            left: -80,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _tealLight.withValues(alpha: 0.12),
                    _tealLight.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // MAPOTECH Logo top-left
          Positioned(
            top: 40,
            left: 32,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _cardDark.withValues(alpha: 0.85),
                border: Border.all(
                  color: _teal.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _teal.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo_MAPOTECH.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Small accent circle bottom-right
          Positioned(
            bottom: 80,
            right: 60,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _tealLight.withValues(alpha: 0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
            child: FadeTransition(
              opacity: _heroFadeAnim,
              child: SlideTransition(
                position: _heroSlideAnim,
                child: Column(
                  children: [
                    // Pill badge with glow effect
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_teal, _tealDark],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: _teal.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        _isEn
                            ? '🏥  1 Ecosystem · 3 Digital Health Solutions'
                            : '🏥  1 Ekosistem · 3 Solusi Kesehatan Digital',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Main title with enhanced gradient
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _settings.textColor,
                          _teal,
                          _tealLight,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ).createShader(bounds),
                      child: const Text(
                        'MAPOTECH',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 8,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle with better contrast
                    Text(
                      'Medical Application Platform for\nOperations, Technology & Connected Healthcare',
                      style: TextStyle(
                        fontSize: 17,
                        color: _settings.textColor.withValues(alpha: 0.7),
                        height: 1.65,
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Description with glassmorphism style
                    Container(
                      constraints: const BoxConstraints(maxWidth: 760),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: _settings.textColor.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _teal.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _teal.withValues(alpha: 0.06),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_hospital_rounded,
                            color: _teal.withValues(alpha: 0.5),
                            size: 28,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _isEn
                                ? 'A cross-platform healthcare management application connecting patients, doctors, and pharmacies in one integrated digital ecosystem.'
                                : 'Aplikasi manajemen layanan kesehatan lintas platform yang menghubungkan pasien, praktik mandiri dokter, fasilitas kesehatan, dan apotek dalam satu ekosistem digital yang terintegrasi.',
                            style: TextStyle(
                              fontSize: 16,
                              color: _settings.textColor.withValues(alpha: 0.82),
                              height: 1.75,
                              letterSpacing: 0.1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Stats row
                    Container(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _heroStat('3', _isEn ? 'User Types' : 'Tipe Pengguna'),
                          _heroDivider(),
                          _heroStat('1', _isEn ? 'Ecosystem' : 'Ekosistem'),
                          _heroDivider(),
                          _heroStat(_isEn ? 'Cross' : 'Multi', _isEn ? 'Platform' : 'Platform'),
                          _heroDivider(),
                          _heroStat('E2E', _isEn ? 'Encrypted' : 'Terenkripsi'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // CTA buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: [
                        _heroBtn(
                          context,
                          label: _isEn
                              ? '🌐  Open Web App'
                              : '🌐  Buka Aplikasi Web',
                          isPrimary: true,
                          onTap: () => _openMapotechApp(context),
                        ),
                        _heroBtn(
                          context,
                          label: _isEn
                              ? '🚀  View All Features'
                              : '🚀  Lihat Fitur Lengkap',
                          isPrimary: false,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/mapotech/features',
                          ),
                        ),
                        _heroBtn(
                          context,
                          label: _isEn ? '📞  Contact Us' : '📞  Hubungi Kami',
                          isPrimary: false,
                          onTap: () =>
                              Navigator.pushNamed(context, '/mapotech/contact'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroStat(String value, String label) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              LinearGradient(colors: [_teal, _tealLight]).createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: _settings.textColor.withValues(alpha: 0.5),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _heroDivider() {
    return Container(
      width: 1,
      height: 36,
      color: _teal.withValues(alpha: 0.25),
    );
  }

  Widget _heroBtn(
    BuildContext context, {
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    if (isPrimary) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_teal, _tealDark]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _teal.withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 0.3,
            ),
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: _settings.textColor,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        side: BorderSide(color: _teal.withValues(alpha: 0.6), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: _settings.textColor.withValues(alpha: 0.85),
        ),
      ),
    );
  }

  // ─── Ecosystem Banner ────────────────────────────────────────────────────────
  Widget _buildEcosystemBanner() {
    final items = [
      (
        '👤',
        _isEn ? 'Patient / Public' : 'Pasien / Publik',
        _isEn
            ? 'Digital registration & queue'
            : 'Pendaftaran & antrean digital',
      ),
      (
        '🩺',
        _isEn ? 'Doctor & Clinic' : 'Dokter & Faskes',
        _isEn ? 'Smart EMR & e-prescription' : 'Smart EMR & resep elektronik',
      ),
      (
        '💊',
        _isEn ? 'Pharmacy' : 'Apotek',
        _isEn ? 'Smart Pharmacy POS & e-rx' : 'Smart Pharmacy POS & e-resep',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _settings.surfaceColor.withValues(alpha: 0.7),
            _settings.cardColor.withValues(alpha: 0.4),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          Text(
            _isEn ? '3 Solutions in 1 Platform' : '3 Solusi dalam 1 Platform',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _settings.textColor.withValues(alpha: 0.92),
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_teal, _tealLight]),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _isEn
                ? 'MAPOTECH connects the entire healthcare ecosystem'
                : 'MAPOTECH menghubungkan seluruh ekosistem layanan kesehatan',
            style: TextStyle(
              fontSize: 15,
              color: _settings.textColor.withValues(alpha: 0.55),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ResponsiveLayout(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ecosystemCard(items[0].$1, items[0].$2, items[0].$3, fullWidth: true),
                _arrowConnectorDown(),
                _ecosystemCard(items[1].$1, items[1].$2, items[1].$3, fullWidth: true),
                _arrowConnectorDown(),
                _ecosystemCard(items[2].$1, items[2].$2, items[2].$3, fullWidth: true),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ecosystemCard(items[0].$1, items[0].$2, items[0].$3, fullWidth: true)),
                _arrowConnector(),
                Expanded(child: _ecosystemCard(items[1].$1, items[1].$2, items[1].$3, fullWidth: true)),
                _arrowConnector(),
                Expanded(child: _ecosystemCard(items[2].$1, items[2].$2, items[2].$3, fullWidth: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ecosystemCard(String emoji, String title, String subtitle, {bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : 200,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _teal.withValues(alpha: 0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _teal.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: _tealLight.withValues(alpha: 0.06),
            blurRadius: 40,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  _teal.withValues(alpha: 0.18),
                  _teal.withValues(alpha: 0.04),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: _teal.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: _settings.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: _settings.textColor.withValues(alpha: 0.55),
              fontSize: 12,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _arrowConnector() {
    return Icon(Icons.arrow_forward_rounded, color: _teal, size: 32);
  }

  Widget _arrowConnectorDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(
        Icons.arrow_downward_rounded,
        color: _teal,
        size: 28,
      ),
    );
  }

  // ─── Features Section ────────────────────────────────────────────────────────
  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      color: _bgDark,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🚀 MAPOTECH Key Features' : '🚀 Fitur Utama MAPOTECH',
            subtitle: _isEn
                ? 'Select a user category to see available features'
                : 'Pilih kategori pengguna untuk melihat fitur tersedia',
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              color: _cardDark,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TabBar(
              controller: _featureTabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                gradient: LinearGradient(colors: [_teal, _tealDark]),
                borderRadius: BorderRadius.circular(50),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: _settings.textColor.withValues(alpha: 0.54),
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(4),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: [
                Tab(text: _isEn ? '👤 Patient' : '👤  Pasien'),
                Tab(text: _isEn ? '🩺 Doctor/Clinic' : '🩺  Dokter/Faskes'),
                Tab(text: _isEn ? '💊 Pharmacy' : '💊  Apotek'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _selectedFeatureTab == 0
              ? _buildPatientFeatures()
              : _selectedFeatureTab == 1
                  ? _buildDoctorFeatures()
                  : _buildPharmacyFeatures(),
        ],
      ),
    );
  }

  Widget _buildPatientFeatures() {
    final features = _isEn
        ? [
            (
              '📋',
              'Digital Registration',
              'Register as a patient digitally without physical documents',
            ),
            (
              '🔢',
              'Online Queuing',
              'Take queue numbers from anywhere via the app',
            ),
            (
              '📜',
              'Visit History',
              'View all previous examination histories and visits',
            ),
            (
              '💊',
              'Digital Prescription',
              'Access electronic prescriptions directly from the doctor',
            ),
            (
              '🏥',
              'Medication History',
              'Monitor medication history in detail',
            ),
            (
              '🛒',
              'Integrated Pickup',
              'Pick up medicines at pharmacies integrated with MAPOTECH',
            ),
            (
              '🔑',
              'One Account Multi-Clinic',
              'Use one account across various MAPOTECH clinics',
            ),
          ]
        : [
            (
              '📋',
              'Pendaftaran Digital',
              'Daftar sebagai pasien secara digital tanpa dokumen fisik',
            ),
            (
              '🔢',
              'Antrean Online',
              'Ambil nomor antrean dari mana saja melalui aplikasi',
            ),
            (
              '📜',
              'Riwayat Kunjungan',
              'Lihat semua riwayat pemeriksaan dan kunjungan sebelumnya',
            ),
            (
              '💊',
              'Resep Digital',
              'Akses resep elektronik langsung dari dokter yang memeriksa',
            ),
            (
              '🏥',
              'Riwayat Pengobatan',
              'Pantau riwayat obat dan pengobatan secara lengkap',
            ),
            (
              '🛒',
              'Ambil Obat Terintegrasi',
              'Ambil obat di apotek yang terintegrasi dengan MAPOTECH',
            ),
            (
              '🔑',
              'Satu Akun Multi Faskes',
              'Gunakan satu akun di berbagai fasilitas kesehatan MAPOTECH',
            ),
          ];
    return _featureGrid(features, emoji: '👤', color: const Color(0xFF06B6D4));
  }

  Widget _buildDoctorFeatures() {
    final features = _isEn
        ? [
            (
              '🧠',
              'Smart EMR System',
              'Smart and structured electronic medical records',
            ),
            (
              '📊',
              'Digital Patient Data',
              'Record patient data and visit history digitally',
            ),
            (
              '🔍',
              'ICD-10/9 Diagnosis',
              'Record diagnoses using standard ICD-10 and ICD-9 codes',
            ),
            (
              '📝',
              'Electronic Prescription',
              'Create and send e-prescriptions directly to the pharmacy',
            ),
            (
              '⚡',
              'Auto E-Prescription',
              'Automatic creation of secure and encrypted prescriptions',
            ),
            (
              '📋',
              'Queue Management',
              'Manage patient queues efficiently and orderly',
            ),
            (
              '👥',
              'Role-Based Access',
              'Role-based access for doctors, admins, nurses, and staff',
            ),
            (
              '📄',
              'Paperless Healthcare',
              'Reduce paper usage for a more efficient system',
            ),
          ]
        : [
            (
              '🧠',
              'Smart EMR System',
              'Rekam medis elektronik yang cerdas dan terstruktur',
            ),
            (
              '📊',
              'Data Pasien Digital',
              'Pencatatan data pasien dan riwayat kunjungan secara digital',
            ),
            (
              '🔍',
              'Diagnosa ICD-10/9',
              'Pencatatan diagnosa menggunakan standar ICD-10 dan ICD-9',
            ),
            (
              '📝',
              'Resep Elektronik',
              'Buat dan kirim resep elektronik langsung ke apotek',
            ),
            (
              '⚡',
              'Auto E-Prescription',
              'Pembuatan resep otomatis yang terenkripsi dan aman',
            ),
            (
              '📋',
              'Manajemen Antrean',
              'Kelola antrean pasien secara efisien dan teratur',
            ),
            (
              '👥',
              'Role-Based Access',
              'Akses berbasis role untuk dokter, admin, perawat, dan staff',
            ),
            (
              '📄',
              'Paperless Healthcare',
              'Kurangi penggunaan kertas untuk sistem yang lebih efisien',
            ),
          ];
    return _featureGrid(features, emoji: '🩺', color: const Color(0xFF10B981));
  }

  Widget _buildPharmacyFeatures() {
    final features = _isEn
        ? [
            (
              '📨',
              'Receive E-Prescriptions',
              'Receive e-prescriptions directly from the doctor\'s system',
            ),
            (
              '🏪',
              'Smart Pharmacy POS',
              'Smart and integrated pharmacy point of sale',
            ),
            (
              '📦',
              'Stock Management',
              'Manage incoming and outgoing medicine stocks cleanly',
            ),
            (
              '📅',
              'FEFO Management',
              'First Expired First Out method for optimal stock management',
            ),
            (
              '⏰',
              'Expiry Monitor',
              'Monitor medicine expiry dates in real-time',
            ),
            (
              '💳',
              'Payment Transactions',
              'Process secure and fast payment transactions for medicines',
            ),
            (
              '🛡️',
              'Anti-Fraud System',
              'Protection against fraud in medicine transactions',
            ),
            (
              '📒',
              'Secure Ledger',
              'Transparent and trackable transaction recording system',
            ),
          ]
        : [
            (
              '📨',
              'Terima E-Resep',
              'Penerimaan resep elektronik langsung dari sistem dokter',
            ),
            (
              '🏪',
              'Smart Pharmacy POS',
              'Point of sale farmasi yang cerdas dan terintegrasi',
            ),
            (
              '📦',
              'Manajemen Stok',
              'Kelola stok obat masuk dan keluar secara terstruktur',
            ),
            (
              '📅',
              'FEFO Management',
              'First Expired First Out untuk manajemen stok optimal',
            ),
            (
              '⏰',
              'Monitor Kedaluwarsa',
              'Pantau tanggal kedaluwarsa obat secara real-time',
            ),
            (
              '💳',
              'Transaksi Pembayaran',
              'Proses transaksi pembayaran obat yang aman dan cepat',
            ),
            (
              '🛡️',
              'Anti-Fraud System',
              'Perlindungan terhadap fraud dalam transaksi obat',
            ),
            (
              '📒',
              'Secure Ledger',
              'Sistem pencatatan transaksi yang transparan dan dapat dilacak',
            ),
          ];
    return _featureGrid(features, emoji: '💊', color: const Color(0xFFF59E0B));
  }

  Widget _featureGrid(
    List<(String, String, String)> features, {
    required String emoji,
    required Color color,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: ResponsiveLayout.value(
          context,
          mobile: 350,
          tablet: 300,
          desktop: 300,
        ),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: ResponsiveLayout.value(
          context,
          mobile: 2.2,
          tablet: 2.0,
          desktop: 1.9,
        ),
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final f = features[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.18)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.07),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji icon with colored bg
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Center(
                  child: Text(f.$1, style: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      f.$2,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      f.$3,
                      style: TextStyle(
                        color: _settings.textColor.withValues(alpha: 0.55),
                        fontSize: 11,
                        height: 1.45,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Workflow Section ────────────────────────────────────────────────────────
  Widget _buildWorkflowSection() {
    final steps = _isEn
        ? [
            (
              '1',
              '📱',
              'Patient Registers',
              'Patients register and take queue numbers online via the MAPOTECH app',
            ),
            (
              '2',
              '🩺',
              'Doctor Examines',
              'Doctors examine patients and create encrypted electronic prescriptions',
            ),
            (
              '3',
              '📨',
              'Pharmacy Receives',
              'Pharmacies receive e-prescriptions directly through the MAPOTECH system',
            ),
            (
              '4',
              '💊',
              'Patient Collects',
              'Patients pay and collect medicines at the integrated pharmacy',
            ),
          ]
        : [
            (
              '1',
              '📱',
              'Pasien Mendaftar',
              'Pasien melakukan pendaftaran dan mengambil nomor antrean melalui aplikasi MAPOTECH',
            ),
            (
              '2',
              '🩺',
              'Dokter Memeriksa',
              'Dokter memeriksa pasien dan membuat resep elektronik yang terenkripsi',
            ),
            (
              '3',
              '📨',
              'Apotek Menerima',
              'Apotek menerima e-resep secara langsung melalui sistem MAPOTECH',
            ),
            (
              '4',
              '💊',
              'Pasien Ambil Obat',
              'Pasien melakukan pembayaran dan mengambil obat di apotek terintegrasi',
            ),
          ];

    return Container(
      color: _settings.surfaceColor.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🔄 MAPOTECH Workflow' : '🔄 Alur Kerja MAPOTECH',
            subtitle: _isEn
                ? 'Simple and efficient healthcare process in 4 steps'
                : 'Proses layanan kesehatan yang sederhana dan efisien dalam 4 langkah',
          ),
          const SizedBox(height: 40),
          ResponsiveLayout(
            mobile: Column(
              children: steps.asMap().entries.map((e) {
                return Column(
                  children: [
                    _workflowCard(
                      e.value.$1,
                      e.value.$2,
                      e.value.$3,
                      e.value.$4,
                    ),
                    if (e.key < steps.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: _teal,
                          size: 24,
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: steps.asMap().entries.map((e) {
                return Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _workflowCard(
                          e.value.$1,
                          e.value.$2,
                          e.value.$3,
                          e.value.$4,
                        ),
                      ),
                      if (e.key < steps.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _teal.withValues(alpha: 0.5),
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workflowCard(String step, String emoji, String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _teal.withValues(alpha: 0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _teal.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Step number badge top-right
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [_teal, _tealDark]),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_teal, _tealDark],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _teal.withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  Text(emoji, style: const TextStyle(fontSize: 30)),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _teal.withValues(alpha: 0.15),
                      _tealLight.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _teal.withValues(alpha: 0.2)),
                ),
                child: Text(
                  _isEn ? 'Step $step' : 'Langkah $step',
                  style: TextStyle(
                    color: _tealLight,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: _settings.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                desc,
                style: TextStyle(
                  color: _settings.textColor.withValues(alpha: 0.55),
                  fontSize: 12,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Screenshots Section ─────────────────────────────────────────────────────
  Widget _buildScreenshotsSection(BuildContext context) {
    return Container(
      color: _bgDark,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn
                ? '📸 See MAPOTECH in Action'
                : '📸 Lihat MAPOTECH dalam Aksi',
            subtitle: _isEn
                ? 'Modern and user-friendly interface design of MAPOTECH'
                : 'Tampilan antarmuka MAPOTECH yang modern dan user-friendly',
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                final imagePath = imageList[index];
                final tag = 'mapotechHero_$index';
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/mapotech/imageDetail',
                      arguments: {'imagePath': imagePath, 'tag': tag},
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Hero(
                      tag: tag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: 220,
                              height: 320,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 12,
                              right: 12,
                              child: Icon(
                                Icons.zoom_in_rounded,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Platform Section ────────────────────────────────────────────────────────
  Widget _buildPlatformSection() {
    final platforms = [
      ('📱', 'Mobile', 'Android & iOS'),
      ('🌐', 'Web', _isEn ? 'Any browser' : 'Browser apapun'),
      ('💻', 'Desktop', 'Windows, macOS & Linux'),
    ];

    return Container(
      color: _settings.surfaceColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🌍 Platform Support' : '🌍 Dukungan Platform',
            subtitle: _isEn
                ? 'MAPOTECH is available on all devices with a consistent experience'
                : 'MAPOTECH tersedia di semua perangkat dengan pengalaman yang konsisten',
          ),
          const SizedBox(height: 32),
          ResponsiveLayout(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: platforms
                  .map((p) => _platformCard(p.$1, p.$2, p.$3))
                  .toList(),
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: platforms.asMap().entries.map((e) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: e.key == 0 ? 0 : 10,
                      right: e.key == platforms.length - 1 ? 0 : 10,
                    ),
                    child: _platformCard(e.value.$1, e.value.$2, e.value.$3),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _teal.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flutter_dash, color: _tealLight, size: 20),
                const SizedBox(width: 10),
                Text(
                  _isEn
                      ? 'Built with Flutter — Cross-Platform by nature'
                      : 'Dibangun dengan Flutter — Cross-Platform by nature',
                  style: TextStyle(
                    color: _settings.textColor.withValues(alpha: 0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _platformCard(String emoji, String name, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _teal.withValues(alpha: 0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _teal.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: _tealLight.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _teal.withValues(alpha: 0.15),
                  _tealLight.withValues(alpha: 0.08),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: _teal.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 34)),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            name,
            style: TextStyle(
              color: _settings.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: _settings.textColor.withValues(alpha: 0.5),
              fontSize: 13,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── Target Users Section ───────────────────────────────────────────────────
  Widget _buildTargetSection() {
    final targets = _isEn
        ? [
            ('👤', 'Patient / General Public', false),
            ('👨‍⚕️', 'Independent Practice Doctor', false),
            ('💊', 'Pharmacy', false),
            ('🏥', 'Clinic', true),
            ('🏛️', 'Community Health Center', true),
            ('🏨', 'Hospital', true),
            ('🩺', 'Healthcare Worker', false),
            ('👩‍💼', 'Healthcare Facility Admin', false),
            ('⚗️', 'Pharmacy Staff', false),
          ]
        : [
            ('👤', 'Pasien / Masyarakat Umum', false),
            ('👨‍⚕️', 'Dokter Praktik Mandiri', false),
            ('💊', 'Apotek', false),
            ('🏥', 'Klinik', true),
            ('🏛️', 'Puskesmas', true),
            ('🏨', 'Rumah Sakit', true),
            ('🩺', 'Tenaga Kesehatan', false),
            ('👩‍💼', 'Admin Fasilitas Kesehatan', false),
            ('⚗️', 'Staff Farmasi', false),
          ];

    final crossAxisCount = ResponsiveLayout.value(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 3,
    );

    return Container(
      color: _bgDark,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🏥 Target Users' : '🏥 Target Pengguna',
            subtitle: _isEn
                ? 'MAPOTECH is designed for the entire healthcare ecosystem'
                : 'MAPOTECH dirancang untuk seluruh ekosistem layanan kesehatan',
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: ResponsiveLayout.value(
                context,
                mobile: 3.0,
                tablet: 4.0,
                desktop: 5.0,
              ),
            ),
            itemCount: targets.length,
            itemBuilder: (context, index) {
              final t = targets[index];
              final isSoon = t.$3;
              return Container(
                decoration: BoxDecoration(
                  color: isSoon ? _cardDark2 : _cardDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSoon
                        ? _teal.withValues(alpha: 0.12)
                        : _teal.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: isSoon
                      ? []
                      : [
                          BoxShadow(
                            color: _teal.withValues(alpha: 0.07),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(t.$1, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.$2,
                          style: TextStyle(
                            color: isSoon
                                ? _settings.textColor.withValues(alpha: 0.4)
                                : _settings.textColor.withValues(alpha: 0.88),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSoon) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.orange.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Text(
                            'Soon',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  // ─── Integration Section ─────────────────────────────────────────────────────
  Widget _buildIntegrationSection() {
    return Container(
      color: _settings.surfaceColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🔗 Integration & Ecosystem' : '🔗 Integrasi & Ekosistem',
            subtitle: _isEn
                ? 'MAPOTECH connects with Indonesia\'s national health services'
                : 'MAPOTECH terhubung dengan layanan kesehatan nasional Indonesia',
          ),
          const SizedBox(height: 32),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _integrationCard(
                  '🏥',
                  'SATUSEHAT',
                  _isEn
                      ? 'Integration with the national health data platform for managing connected electronic medical records'
                      : 'Integrasi dengan platform data kesehatan nasional untuk pengelolaan rekam medis elektronik yang terhubung',
                  const Color(0xFF3B82F6),
                ),
                const SizedBox(height: 20),
                _integrationCard(
                  '🛡️',
                  'BPJS',
                  _isEn
                      ? 'Supports BPJS Kesehatan integration for a more streamlined medical claim and service workflow'
                      : 'Mendukung integrasi dengan layanan BPJS Kesehatan untuk proses pelayanan yang lebih terintegrasi',
                  const Color(0xFF10B981),
                ),
                const SizedBox(height: 20),
                _integrationCard(
                  '📋',
                  'DFO (RME)',
                  _isEn
                      ? 'Listed on DFO to support clinics and doctors in picking and deploying compliant digital RME platforms'
                      : 'Tersedia di DFO untuk mendukung fasilitas kesehatan dalam pemilihan dan penggunaan sistem RME secara digital',
                  const Color(0xFFF59E0B),
                ),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  child: _integrationCard(
                    '🏥',
                    'SATUSEHAT',
                    _isEn
                        ? 'Integration with the national health data platform for managing connected electronic medical records'
                        : 'Integrasi dengan platform data kesehatan nasional untuk pengelolaan rekam medis elektronik yang terhubung',
                    const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _integrationCard(
                    '🛡️',
                    'BPJS',
                    _isEn
                        ? 'Supports BPJS Kesehatan integration for a more streamlined medical claim and service workflow'
                        : 'Mendukung integrasi dengan layanan BPJS Kesehatan untuk proses pelayanan yang lebih terintegrasi',
                    const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _integrationCard(
                    '📋',
                    'DFO (RME)',
                    _isEn
                        ? 'Listed on DFO to support clinics and doctors in picking and deploying compliant digital RME platforms'
                        : 'Tersedia di DFO untuk mendukung fasilitas kesehatan dalam pemilihan dan penggunaan sistem RME secara digital',
                    const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _integrationCard(
    String emoji,
    String name,
    String desc,
    Color accentColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: TextStyle(
              color: _settings.textColor.withValues(alpha: 0.6),
              fontSize: 13,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── Security Section ─────────────────────────────────────────────────────────
  Widget _buildSecuritySection() {
    final items = _isEn
        ? [
            (
              '🔒',
              'Patient Data Protection',
              'Patient health data is secured with high-grade encryption standards',
            ),
            (
              '👥',
              'Role-Based Access Control',
              'Permissions are dynamically tailored based on each user\'s role',
            ),
            (
              '🔐',
              'Secure Authentication',
              'Encrypted login system for all user categories',
            ),
            (
              '📋',
              'Controlled EMR',
              'Strict access control for managing patient electronic medical records',
            ),
            (
              '📝',
              'Encrypted Prescriptions',
              'Digital prescriptions are protected with end-to-end encryption',
            ),
            (
              '🔍',
              'Audit Trail logs',
              'Transparent and trackable recording of system transactions',
            ),
          ]
        : [
            (
              '🔒',
              'Perlindungan Data Pasien',
              'Data kesehatan pasien dilindungi dengan enkripsi tingkat tinggi',
            ),
            (
              '👥',
              'Role-Based Access',
              'Hak akses disesuaikan berdasarkan peran setiap pengguna',
            ),
            (
              '🔐',
              'Autentikasi Aman',
              'Sistem login yang aman untuk semua jenis pengguna',
            ),
            (
              '📋',
              'RME Terkontrol',
              'Pengelolaan rekam medis dengan kontrol akses ketat',
            ),
            (
              '📝',
              'Resep Terenkripsi',
              'Resep elektronik diamankan dengan enkripsi end-to-end',
            ),
            (
              '🔍',
              'Audit Trail',
              'Pencatatan transaksi yang transparan dan dapat dilacak',
            ),
          ];

    return Container(
      color: _bgDark,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '🔒 Security & Privacy' : '🔒 Keamanan & Privasi',
            subtitle: _isEn
                ? 'MAPOTECH manages health data with top-tier security standards'
                : 'MAPOTECH mengelola data kesehatan dengan standar keamanan tinggi',
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: ResponsiveLayout.value(
                context,
                mobile: 350,
                tablet: 320,
                desktop: 320,
              ),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: ResponsiveLayout.value(
                context,
                mobile: 2.0,
                tablet: 2.2,
                desktop: 2.2,
              ),
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _cardDark,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Text(item.$1, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.$2,
                            style: TextStyle(
                              color: _settings.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.$3,
                            style: TextStyle(
                              color: _settings.textColor.withValues(alpha: 0.5),
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── Status Section ───────────────────────────────────────────────────────────
  Widget _buildStatusSection() {
    return Container(
      color: _settings.surfaceColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          _sectionTitle(
            _isEn ? '📦 Project Status & Vision' : '📦 Status & Visi',
            subtitle: _isEn
                ? 'MAPOTECH development progress and long-term vision'
                : 'Perkembangan dan tujuan jangka panjang MAPOTECH',
          ),
          const SizedBox(height: 32),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _statusCard(
                  '⚡',
                  _isEn ? 'Project Status' : 'Status Project',
                  _isEn ? 'Active Development' : 'Pengembangan Aktif',
                  _isEn
                      ? 'MAPOTECH is currently in active development. Features and modules will continue to evolve according to real-world healthcare needs.'
                      : 'MAPOTECH saat ini masih dalam tahap pengembangan aktif. Fitur dan modul akan terus dikembangkan mengikuti kebutuhan nyata di lingkungan layanan kesehatan.',
                  Colors.green,
                  isActive: true,
                ),
                const SizedBox(height: 20),
                _statusCard(
                  '🎯',
                  _isEn ? 'Project Vision' : 'Visi Project',
                  _isEn
                      ? 'Digital Health Platform'
                      : 'Platform Kesehatan Digital',
                  _isEn
                      ? 'MAPOTECH aims to be an integrated, scalable, secure, and affordable digital health platform for various facilities in Indonesia.'
                      : 'MAPOTECH memiliki visi untuk menjadi platform kesehatan digital yang terintegrasi, scalable, aman, dan terjangkau bagi berbagai fasilitas kesehatan di Indonesia.',
                  _teal,
                  isActive: false,
                ),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _statusCard(
                    '⚡',
                    _isEn ? 'Project Status' : 'Status Project',
                    _isEn ? 'Active Development' : 'Pengembangan Aktif',
                    _isEn
                        ? 'MAPOTECH is currently in active development. Features and modules will continue to evolve according to real-world healthcare needs.'
                        : 'MAPOTECH saat ini masih dalam tahap pengembangan aktif. Fitur dan modul akan terus dikembangkan mengikuti kebutuhan nyata di lingkungan layanan kesehatan.',
                    Colors.green,
                    isActive: true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _statusCard(
                    '🎯',
                    _isEn ? 'Project Vision' : 'Visi Project',
                    _isEn
                        ? 'Digital Health Platform'
                        : 'Platform Kesehatan Digital',
                    _isEn
                        ? 'MAPOTECH aims to be an integrated, scalable, secure, and affordable digital health platform for various facilities in Indonesia.'
                        : 'MAPOTECH memiliki visi untuk menjadi platform kesehatan digital yang terintegrasi, scalable, aman, dan terjangkau bagi berbagai fasilitas kesehatan di Indonesia.',
                    _teal,
                    isActive: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(
    String emoji,
    String label,
    String title,
    String desc,
    Color color, {
    required bool isActive,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: _settings.textColor.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (isActive) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: TextStyle(
              color: _settings.textColor.withValues(alpha: 0.65),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ─── CTA Section ─────────────────────────────────────────────────────────────
  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _tealDark.withValues(alpha: 0.9),
            _settings.surfaceColor,
            _bgDark,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Decorative blob top-left
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _teal.withValues(alpha: 0.2),
                    _teal.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Decorative blob bottom-right
          Positioned(
            bottom: -40,
            right: -40,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _tealLight.withValues(alpha: 0.15),
                    _tealLight.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
            child: Column(
              children: [
                Text(
                  _isEn
                      ? '🚀 Ready for Digital Transformation?'
                      : '🚀 Siap Bertransformasi Digital?',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: _settings.textColor,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Text(
                  _isEn
                      ? 'Join MAPOTECH and experience true ease in digitalizing healthcare services'
                      : 'Bergabunglah dengan MAPOTECH dan rasakan kemudahan\ndigitalisasi layanan kesehatan yang sesungguhnya',
                  style: TextStyle(
                    fontSize: 17,
                    color: _settings.textColor.withValues(alpha: 0.72),
                    height: 1.65,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 16,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    // Primary CTA with gradient glow
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [_teal, _tealDark]),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: _teal.withValues(alpha: 0.5),
                            blurRadius: 28,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => _openMapotechApp(context),
                        icon: const Icon(Icons.launch_rounded),
                        label: Text(
                          _isEn
                              ? 'Open MAPOTECH Web App'
                              : 'Buka Aplikasi Web MAPOTECH',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/mapotech/contact'),
                      icon: Icon(Icons.chat_bubble_rounded, color: _tealLight),
                      label: Text(
                        _isEn ? 'Contact MAPOTECH Team' : 'Hubungi Tim MAPOTECH',
                        style: TextStyle(
                          color: _tealLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _teal, width: 1.5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/mapotech/features'),
                      icon: Icon(Icons.list_alt_rounded, color: _tealLight),
                      label: Text(
                        _isEn ? 'View All Features' : 'Lihat Semua Fitur',
                        style: TextStyle(
                          color: _tealLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _teal, width: 1.5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section Title Helper ────────────────────────────────────────────────────
  Widget _sectionTitle(String title, {String? subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _settings.textColor,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        // Gradient accent underline
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [_teal, _tealLight]),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: _settings.textColor.withValues(alpha: 0.55),
              height: 1.55,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
