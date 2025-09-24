import 'package:flutter/material.dart';

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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/pricing'),
                        icon: const Icon(
                          Icons.price_check,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Lihat Harga',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
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
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 2
                        : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.5,
                    children: [
                      _buildProblemCard(
                        icon: Icons.book,
                        title: "Pencatatan Manual",
                        description:
                            "Data pasien masih dicatat di buku, sering hilang atau sulit dicari",
                        color: Colors.red[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.inventory_2,
                        title: "Stok Obat Kacau",
                        description:
                            "Pengecekan stok obat manual, sering kehabisan tanpa disadari",
                        color: Colors.orange[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.assignment_ind,
                        title: "Absensi Kertas",
                        description:
                            "Absensi staf masih pakai kertas, mudah hilang dan tidak akurat",
                        color: Colors.purple[600]!,
                      ),
                      _buildProblemCard(
                        icon: Icons.account_balance_wallet,
                        title: "Laporan Keuangan Berantakan",
                        description:
                            "Pencatatan keuangan sering terlupakan, laporan tidak terstruktur",
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
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D8E),
                    ),
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
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 3
                        : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _buildBenefitCard(
                        icon: Icons.speed,
                        title: "Praktik Lebih Profesional",
                        description:
                            "Kesan profesional untuk pasien dengan sistem terorganisir",
                        color: Colors.green[600]!,
                      ),
                      _buildBenefitCard(
                        icon: Icons.trending_up,
                        title: "Efisiensi Waktu",
                        description:
                            "Selesaikan urusan administratif dalam satu aplikasi",
                        color: Colors.blue[600]!,
                      ),
                      _buildBenefitCard(
                        icon: Icons.security,
                        title: "Data Terorganisir",
                        description:
                            "Semua data tersimpan rapi dan mudah diakses kapan saja",
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 48,
                      ),
                    ),
                    child: const Text(
                      'Dapatkan MAPOTEK Sekarang',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/privacy'),
                        child: const Text(
                          "Kebijakan Privasi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/terms'),
                        child: const Text(
                          "Syarat & Ketentuan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/contact'),
                        child: const Text(
                          "Kontak",
                          style: TextStyle(color: Colors.white),
                        ),
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

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.login,
        'title': 'Login Multi-Role',
        'desc': 'Owner, Admin, dan Dokter dengan hak akses berbeda',
      },
      {
        'icon': Icons.people,
        'title': 'Manajemen Data Pasien',
        'desc': 'Pencatatan pasien digital yang praktis dan aman',
      },
      {
        'icon': Icons.medical_services,
        'title': 'Pemantauan Stok Obat',
        'desc': 'Monitoring stok obat otomatis dengan alert',
      },
      {
        'icon': Icons.access_time,
        'title': 'Absensi Staf Digital',
        'desc': 'Sistem absensi yang efisien dan akurat',
      },
      {
        'icon': Icons.analytics,
        'title': 'Pencatatan Keuangan',
        'desc': 'Laporan keuangan rapi dan terstruktur',
      },
      {
        'icon': Icons.design_services,
        'title': 'Antarmuka User-Friendly',
        'desc': 'Desain simpel, clean, dan mudah digunakan',
      },
    ];

    return Column(
      children: features
          .map(
            (feature) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2E7D8E),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: Text(
                  feature['title'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  feature['desc'] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
