import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          maxContentWidth: 900.0,
          child: Column(
            children: [
              Text(
                isEn
                    ? '✨ MAPOTECH Highlights'
                    : '✨ Fitur Unggulan MAPOTECH',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 26.0,
                    tablet: 32.0,
                    desktop: 36.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: settings.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Medical Application Platform for Operations, Technology & Connected Healthcare',
                style: TextStyle(
                  fontSize: 16,
                  color: settings.textColor.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.login_rounded,
                title: isEn
                    ? '🔐 Multi-Role Login & Access Control'
                    : '🔐 Login Multi-Role & Hak Akses',
                description: isEn
                    ? 'Encrypted login system with dynamic role-based access for Owner, Admin, and Doctor. Each role has a customized set of features and access panels.'
                    : 'Sistem login terenkripsi dengan pembagian hak akses untuk Owner, Admin, dan Dokter. Setiap role memiliki fitur dan panel akses yang disesuaikan secara dinamis.',
                features: isEn
                    ? [
                        'Owner: Full system access, financial statistics, and periodic reports',
                        'Admin: Patient registration, cashier, clinic data management, and daily logs',
                        'Doctor: Medical examination, electronic medical records (EMR), ICD-10 diagnosis, and prescriptions',
                      ]
                    : [
                        'Owner: Akses penuh ke seluruh sistem, statistik finansial, dan laporan berkala',
                        'Admin: Pendaftaran pasien, kasir, pengelolaan data faskes, dan log harian',
                        'Dokter: Pemeriksaan medis, input rekam medis elektronik (EMR), diagnosa ICD-10, dan resep',
                      ],
              ),
              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.people_alt_rounded,
                title: isEn
                    ? 'Patient History & Digital Records'
                    : 'Riwayat & Data Pasien Digital',
                description: isEn
                    ? 'A comprehensive digital patient recording system to replace conventional manual books. Enables instant medical history searches.'
                    : 'Sistem pencatatan pasien digital yang komprehensif untuk menggantikan buku manual konvensional. Memungkinkan pencarian riwayat medis instan.',
                features: isEn
                    ? [
                        'Complete patient demographic & contact data recording',
                        'Integrated visit history, vital signs, and medical notes',
                        'Fast patient data search using name or medical record number',
                        'Locally encrypted data storage and regular backup',
                      ]
                    : [
                        'Pencatatan data demografis & kontak pasien secara lengkap',
                        'Riwayat kunjungan, tanda-tanda vital, dan catatan medis terintegrasi',
                        'Pencarian data pasien secara cepat menggunakan nama atau nomor rekam medis',
                        'Penyimpanan data yang terenkripsi lokal dan backup teratur',
                      ],
              ),
              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.health_and_safety_rounded,
                title: isEn
                    ? '🧠 Smart EMR & ICD-10/9 Diagnosis'
                    : '🧠 Smart EMR & Diagnosa ICD-10/9',
                description: isEn
                    ? 'An intelligent electronic medical records module supporting modern medical writing standards and disease code integration.'
                    : 'Modul rekam medis elektronik cerdas yang mendukung standar penulisan medis modern dan integrasi kodefikasi penyakit.',
                features: isEn
                    ? [
                        'Automatic electronic prescription (e-prescription) recording',
                        'Support for standard ICD-10 disease database for accurate diagnosis',
                        'Medical action recording and customizable EMR templates',
                        'Easy printing of EMR documents when required by patients',
                      ]
                    : [
                        'Pencatatan resep elektronik (e-prescription) secara otomatis',
                        'Dukungan database penyakit berstandar ICD-10 untuk diagnosa akurat',
                        'Pencatatan tindakan medis dan kustomisasi template rekam medis',
                        'Kemudahan cetak dokumen rekam medis jika diperlukan oleh pasien',
                      ],
              ),
              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.inventory_2_rounded,
                title: isEn
                    ? '💊 Medicine Stock & Smart Pharmacy'
                    : '💊 Pemantauan Stok Obat & Smart Pharmacy',
                description: isEn
                    ? 'An integrated pharmacy management system that monitors stock in real-time to prevent shortages or overstock.'
                    : 'Sistem manajemen apotek terintegrasi yang melakukan pemantauan stok secara real-time untuk mencegah penimbunan maupun kekurangan stok.',
                features: isEn
                    ? [
                        'Direct prescription reception (auto-routing) from doctor\'s room to pharmacy',
                        'First Expired First Out (FEFO) stock management method',
                        'Automatic alerts when medicine stock falls below minimum threshold',
                        'Periodic medicine expiry date notifications',
                      ]
                    : [
                        'Penerimaan resep langsung (auto-routing) dari ruang dokter ke apotek',
                        'Metode pengelolaan stok First Expired First Out (FEFO)',
                        'Alert otomatis saat persediaan obat menipis di bawah batas minimum',
                        'Pemberitahuan tanggal kedaluwarsa obat secara berkala',
                      ],
              ),
              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.qr_code_scanner_rounded,
                title: isEn
                    ? '🕒 Attendance & Staff Management'
                    : '🕒 Absensi & Manajemen Staf',
                description: isEn
                    ? 'An integrated digital attendance system to track presence, work time compliance, and staff operational hours.'
                    : 'Sistem pencatatan kehadiran digital terintegrasi untuk mendata kehadiran, kepatuhan waktu kerja, dan jam operasional staf.',
                features: isEn
                    ? [
                        'Independent digital attendance for nurses, admins, and doctors',
                        'Automatic monthly attendance recap reports',
                        'Monitoring of staff tardiness and overtime hours',
                        'User activity log system (Audit Trail) for work transparency',
                      ]
                    : [
                        'Absensi digital mandiri untuk perawat, admin, dan dokter',
                        'Laporan rekapitulasi kehadiran bulanan otomatis',
                        'Pemantauan keterlambatan dan jam kerja lembur staf',
                        'Sistem log aktivitas pengguna (Audit Trail) untuk transparansi kerja',
                      ],
              ),
              _buildFeatureCard(
                settings: settings,
                isEn: isEn,
                icon: Icons.query_stats_rounded,
                title: isEn
                    ? '💰 Financial Reports & Integrated Cashier'
                    : '💰 Laporan Finansial & Kasir Terintegrasi',
                description: isEn
                    ? 'A healthcare point-of-sale (POS) system that automatically records all medicine payment and medical action transactions.'
                    : 'Sistem point-of-sale (POS) kesehatan yang mencatat seluruh transaksi pembayaran obat dan tindakan medis secara otomatis.',
                features: isEn
                    ? [
                        'Fast cashier transactions for cash and non-cash payments',
                        'Daily, weekly, and monthly cash flow reports',
                        'Automatic medicine and medical service profit margin calculations',
                        'Business performance dashboard graphics for Owners',
                      ]
                    : [
                        'Transaksi kasir cepat untuk pembayaran tunai maupun non-tunai',
                        'Laporan arus kas masuk dan keluar secara harian, mingguan, dan bulanan',
                        'Perhitungan margin keuntungan obat dan jasa medis otomatis',
                        'Dashboard grafik performa bisnis faskes untuk Owner',
                      ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required AppSettings settings,
    required bool isEn,
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      child: Card(
        color: settings.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: settings.primaryColor.withValues(alpha: 0.2)),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: settings.primaryColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon,
                        color: settings.accentColor, size: 32),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: settings.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: settings.textColor.withValues(alpha: 0.65),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Divider(color: settings.primaryColor.withValues(alpha: 0.15)),
              const SizedBox(height: 10),
              ...features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: settings.accentColor,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 14,
                            color: settings.textColor
                                .withValues(alpha: 0.75),
                            height: 1.4,
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
