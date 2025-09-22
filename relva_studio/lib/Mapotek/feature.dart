import 'package:flutter/material.dart';

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
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D8E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildDetailedFeatureCard(
              icon: Icons.login,
              title: "🔐 Login Multi-Role",
              description:
                  "Sistem login dengan pembagian hak akses untuk Owner, Admin, dan Dokter. Setiap role memiliki fitur dan akses yang berbeda sesuai kebutuhan.",
              features: [
                "Owner: Akses penuh ke semua fitur",
                "Admin: Manajemen data dan laporan",
                "Dokter: Fokus pada data pasien dan obat",
              ],
            ),
            _buildDetailedFeatureCard(
              icon: Icons.people,
              title: "🧾 Manajemen Data Pasien",
              description:
                  "Sistem pencatatan pasien digital yang praktis menggantikan buku manual. Data tersimpan aman dan mudah dicari.",
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
              description:
                  "Sistem monitoring stok obat real-time dengan alert otomatis ketika stok menipis atau mendekati expired.",
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
              description:
                  "Sistem absensi digital yang menggantikan pencatatan manual. Lebih akurat dan tidak mudah hilang.",
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
              description:
                  "Sistem keuangan terintegrasi yang mencatat semua transaksi secara otomatis dan menghasilkan laporan yang rapi.",
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
              description:
                  "Desain yang simpel, clean, dan mudah digunakan. Tidak rumit seperti sistem rumah sakit, sesuai kebutuhan praktik pribadi.",
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
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
              ...features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF2E7D8E),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
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
