import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MapotekApp());
}

class MapotekApp extends StatelessWidget {
  const MapotekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAPOTEK - Solusi Cerdas untuk Praktik Dokter di Rumah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2E7D8E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D8E),
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/features': (context) => const FeaturesPage(),
        '/pricing': (context) => const PricingPage(),
        '/demo': (context) => const DemoPage(),
        '/contact': (context) => const ContactPage(),
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/terms': (context) => const TermsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/imageDetail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ImageDetailPage(
              imagePath: args['imagePath'],
              tag: args['tag'],
            ),
          );
        }
        return null;
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/mapotek_1.jpg',
      'assets/mapotek_2.jpg',
      'assets/mapotek_3.jpg',
      'assets/mapotek_4.jpg',
      'assets/poster_mapotek.jpg',
    ];

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
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/demo'),
            child: const Text(
              'Coba Demo',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "MAPOTEK",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Solusi Cerdas untuk Praktik Dokter di Rumah",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Aplikasi desktop yang dirancang khusus untuk mempermudah manajemen praktik pribadi dokter secara menyeluruh. Simpel, intuitif, dan efisien — sesuai kebutuhan praktik pribadi Anda.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/demo'),
                        icon: const Icon(Icons.download, size: 28),
                        label: const Text(
                          'Download Gratis',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/pricing'),
                        icon: const Icon(Icons.price_check, color: Colors.white),
                        label: const Text(
                          'Lihat Harga',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Problem Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              color: Colors.red[50],
              child: Column(
                children: [
                  const Text(
                    "Masalah yang Sering Dihadapi Dokter Praktik Pribadi",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.5,
                    children: [
                      _buildProblemCard(
                        icon: Icons.book,
                        title: "Pencatatan Manual",
                        description: "Data pasien masih dicatat di buku, sering hilang atau sulit dicari",
                        color: Colors.red[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.inventory_2,
                        title: "Stok Obat Kacau",
                        description: "Pengecekan stok obat manual, sering kehabisan tanpa disadari",
                        color: Colors.orange[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.assignment_ind,
                        title: "Absensi Kertas",
                        description: "Absensi staf masih pakai kertas, mudah hilang dan tidak akurat",
                        color: Colors.purple[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.account_balance_wallet,
                        title: "Laporan Keuangan Berantakan",
                        description: "Pencatatan keuangan sering terlupakan, laporan tidak terstruktur",
                        color: Colors.indigo[600]!,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Solution Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "MAPOTEK Hadir Sebagai Solusi!",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2E7D8E)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Tinggalkan cara lama. Saatnya upgrade ke MAPOTEK.",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildFeaturesList(),
                ],
              ),
            ),

            // Screenshots Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const Text(
                    "Lihat MAPOTEK dalam Aksi",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        final imagePath = imageList[index];
                        final tag = 'imageHero_$index';
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/imageDetail',
                              arguments: {'imagePath': imagePath, 'tag': tag},
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            child: Hero(
                              tag: tag,
                              child: Card(
                                elevation: 12,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 300,
                                  ),
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
            ),

            // Benefits Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "Manfaat Menggunakan MAPOTEK",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _buildBenefitCard(
                        icon: Icons.speed,
                        title: "Praktik Lebih Profesional",
                        description: "Kesan profesional untuk pasien dengan sistem terorganisir",
                        color: Colors.green[600]!,
                      ),
                      _buildBenefitCard(
                        icon: Icons.trending_up,
                        title: "Efisiensi Waktu",
                        description: "Selesaikan urusan administratif dalam satu aplikasi",
                        color: Colors.blue[600]!,
                      ),
                      _buildBenefitCard(
                        icon: Icons.security,
                        title: "Data Terorganisir",
                        description: "Semua data tersimpan rapi dan mudah diakses kapan saja",
                        color: Colors.orange[600]!,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // CTA Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Siap Modernisasi Praktik Anda?",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Karya digital lokal untuk kemajuan praktik kesehatan di Indonesia",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    child: const Text(
                      'Dapatkan MAPOTEK Sekarang',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.grey[800],
              child: Column(
                children: [
                  const Text(
                    "Dibuat oleh RELVA",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Tim: Alfon Soetanto ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/privacy'),
                        child: const Text("Kebijakan Privasi", style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/terms'),
                        child: const Text("Syarat & Ketentuan", style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/contact'),
                        child: const Text("Kontak", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "© 2024 MAPOTEK by RELVA. All rights reserved.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String comment,
    required int rating,
  }) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  rating,
                  (index) => Icon(Icons.star, color: Colors.orange[600], size: 20),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                comment,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Text(
                "- $name",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.login, 'title': 'Login Multi-Role', 'desc': 'Owner, Admin, dan Dokter dengan hak akses berbeda'},
      {'icon': Icons.people, 'title': 'Manajemen Data Pasien', 'desc': 'Pencatatan pasien digital yang praktis dan aman'},
      {'icon': Icons.medical_services, 'title': 'Pemantauan Stok Obat', 'desc': 'Monitoring stok obat otomatis dengan alert'},
      {'icon': Icons.access_time, 'title': 'Absensi Staf Digital', 'desc': 'Sistem absensi yang efisien dan akurat'},
      {'icon': Icons.analytics, 'title': 'Pencatatan Keuangan', 'desc': 'Laporan keuangan rapi dan terstruktur'},
      {'icon': Icons.design_services, 'title': 'Antarmuka User-Friendly', 'desc': 'Desain simpel, clean, dan mudah digunakan'},
    ];

    return Column(
      children: features.map((feature) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF2E7D8E),
            child: Icon(feature['icon'] as IconData, color: Colors.white, size: 28),
          ),
          title: Text(
            feature['title'] as String,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            feature['desc'] as String,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      )).toList(),
    );
  }
}

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitur Lengkap MAPOTEK"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "✨ Fitur Unggulan MAPOTEK",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2E7D8E)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildDetailedFeatureCard(
              icon: Icons.login,
              title: "🔐 Login Multi-Role",
              description: "Sistem login dengan pembagian hak akses untuk Owner, Admin, dan Dokter. Setiap role memiliki fitur dan akses yang berbeda sesuai kebutuhan.",
              features: [
                "Owner: Akses penuh ke semua fitur",
                "Admin: Manajemen data dan laporan",
                "Dokter: Fokus pada data pasien dan obat",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.people,
              title: "🧾 Manajemen Data Pasien",
              description: "Sistem pencatatan pasien digital yang praktis menggantikan buku manual. Data tersimpan aman dan mudah dicari.",
              features: [
                "Pencatatan data pasien lengkap",
                "History kunjungan dan diagnosa",
                "Pencarian data yang cepat dan akurat",
                "Backup otomatis data pasien",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.medical_services,
              title: "💊 Pemantauan Stok Obat Otomatis",
              description: "Sistem monitoring stok obat real-time dengan alert otomatis ketika stok menipis atau mendekati expired.",
              features: [
                "Tracking stok obat real-time",
                "Alert stok minimum",
                "Notifikasi obat expired",
                "Laporan penggunaan obat",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.access_time,
              title: "🕒 Absensi Staf Digital",
              description: "Sistem absensi digital yang menggantikan pencatatan manual. Lebih akurat dan tidak mudah hilang.",
              features: [
                "Absensi digital untuk semua staf",
                "Tracking jam kerja",
                "Laporan kehadiran bulanan",
                "Riwayat absensi lengkap",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.analytics,
              title: "💰 Pencatatan Keuangan",
              description: "Sistem keuangan terintegrasi yang mencatat semua transaksi secara otomatis dan menghasilkan laporan yang rapi.",
              features: [
                "Pencatatan transaksi otomatis",
                "Laporan keuangan harian/bulanan",
                "Tracking pemasukan dan pengeluaran",
                "Analisis profit dan loss",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.design_services,
              title: "🎨 Antarmuka User-Friendly",
              description: "Desain yang simpel, clean, dan mudah digunakan. Tidak rumit seperti sistem rumah sakit, sesuai kebutuhan praktik pribadi.",
              features: [
                "Interface yang intuitif",
                "Navigasi yang mudah dipahami",
                "Desain responsif dan modern",
                "Animasi yang menarik di setiap halaman",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2E7D8E),
                    radius: 30,
                    child: Icon(icon, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF2E7D8E), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Harga MAPOTEK"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Investasi Terbaik untuk Praktik Anda",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Main pricing card
            Card(
              elevation: 16,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange[600],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text(
                          "PAKET LENGKAP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "MAPOTEK Desktop",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Rp",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "150.000",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Lisensi Seumur Hidup",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Yang Anda Dapatkan:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...[
                              "✅ Aplikasi Desktop MAPOTEK Lengkap",
                              "✅ Login Multi-Role (Owner, Admin, Dokter)",
                              "✅ Manajemen Data Pasien Digital",
                              "✅ Pemantauan Stok Obat Otomatis",
                              "✅ Absensi Staf Digital",
                              "✅ Pencatatan Keuangan Terintegrasi",
                              "✅ Interface User-Friendly",
                              "✅ Update Gratis Selamanya",
                              "✅ Panduan Instalasi & Setup",
                              "✅ Support Teknis",
                            ].map((feature) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/contact');
                          },
                          child: const Text(
                            "BELI SEKARANG",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D8E),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Comparison section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                children: [
                  const Text(
                    "Bandingkan dengan Cara Manual",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Aspek",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Manual",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "MAPOTEK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      _buildComparisonRow("Pencatatan Pasien", "Buku & Kertas", "Digital & Aman"),
                      _buildComparisonRow("Stok Obat", "Cek Manual", "Otomatis"),
                      _buildComparisonRow("Absensi", "Kertas", "Digital"),
                      _buildComparisonRow("Laporan Keuangan", "Ribet & Berantakan", "Otomatis & Rapi"),
                      _buildComparisonRow("Backup Data", "Tidak Ada", "Otomatis"),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Money back guarantee
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Icon(Icons.security, size: 64, color: Colors.blue[600]),
                  const SizedBox(height: 16),
                  const Text(
                    "Jaminan Kepuasan 100%",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Jika dalam 7 hari tidak puas, kami akan mengembalikan uang Anda 100%. Tanpa ribet, tanpa pertanyaan yang merepotkan.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildComparisonRow(String aspect, String manual, String mapotek) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            aspect,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  manual,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  mapotek,
                  style: const TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka link download')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download MAPOTEK"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.desktop_windows, size: 120, color: const Color(0xFF2E7D8E)),
              const SizedBox(height: 32),
              const Text(
                "Download MAPOTEK Desktop",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Aplikasi desktop untuk Windows yang mudah diinstall dan digunakan",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        "Persyaratan Sistem:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• Windows 7/8/10/11"),
                          Text("• RAM minimal 2GB"),
                          Text("• Storage 500MB"),
                          Text("• .NET Framework 4.5+"),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _openUrl(
                              context,
                              'https://drive.google.com/drive/folders/1aQWYkf5ulsRSFS8j5CMjvBAaWuHjgTC4?usp=drive_link',
                            );
                          },
                          icon: const Icon(Icons.download, size: 28),
                          label: const Text(
                            "Download Sekarang",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D8E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _openWhatsApp(BuildContext context, String phone) async {
    final uri = Uri.parse('https://wa.me/$phone'); // phone: e.g. 6282132411163
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak dapat membuka WhatsApp')));
    }
  }

  Future<void> _openEmail(BuildContext context, String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Pertanyaan MAPOTEK',
        'body': 'Halo, saya ingin informasi tentang MAPOTEK...'
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak dapat membuka email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kontak & Pembelian"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Hubungi Kami",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Tim RELVA siap membantu Anda mengimplementasikan MAPOTEK di praktik Anda",
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone, color: Color(0xFF2E7D8E), size: 32),
                      title: const Text("Telepon / WhatsApp", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: const Text("+62 821-3241-1163\nKontak langsung dengan tim pengembang", style: TextStyle(fontSize: 16)),
                      onTap: () {
                        _openWhatsApp(context, '6282132411163');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email, color: Color(0xFF2E7D8E), size: 32),
                      title: const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: const Text("Fontaro990@gmail.com\nRespon dalam 2-4 jam", style: TextStyle(fontSize: 16)),
                      onTap: () {
                        _openEmail(context, 'Fontaro990@gmail.com');
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Purchase steps
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E7D8E), Color(0xFF1A5F6E)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "Cara Pembelian",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPurchaseStep("1", "Hubungi kami via WhatsApp atau Email"),
                  _buildPurchaseStep("2", "Transfer Rp 150.000 ke rekening yang diberikan"),
                  _buildPurchaseStep("3", "Kirim bukti transfer"),
                  _buildPurchaseStep("4", "Terima link download + panduan instalasi"),
                  _buildPurchaseStep("5", "Tim kami akan membantu setup jika diperlukan (Kami Akan Datang Ke tempat Anda (Khusus daerah Bondowoso saja!))"),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseStep(String step, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D8E),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imagePath;
  final String tag;

  const ImageDetailPage({super.key, required this.imagePath, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screenshot MAPOTEK"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Card(
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kebijakan Privasi"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Kebijakan Privasi MAPOTEK",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "MAPOTEK menghargai privasi Anda. Semua data yang Anda input ke dalam aplikasi tersimpan secara lokal di komputer Anda dan tidak dikirim ke server manapun.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "Aplikasi desktop MAPOTEK tidak mengumpulkan, menyimpan, atau membagikan data pribadi Anda kepada pihak ketiga. Data pasien dan praktik Anda sepenuhnya berada dalam kendali Anda.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syarat & Ketentuan"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Syarat & Ketentuan MAPOTEK",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "Dengan membeli dan menggunakan MAPOTEK, Anda menyetujui:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "1. Lisensi penggunaan untuk satu praktik/klinik\n"
              "2. Dilarang mendistribusikan atau menjual ulang aplikasi\n"
              "3. Update dan support disediakan oleh tim RELVA\n"
              "4. Garansi 7 hari uang kembali jika tidak puas\n"
              "5. Tim RELVA tidak bertanggung jawab atas kehilangan data akibat kesalahan pengguna",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}