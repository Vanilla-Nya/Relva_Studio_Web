import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        final teal = settings.primaryColor;
        final tealDark = settings.primaryColor.withValues(alpha: 0.85);
        final tealLight = settings.accentColor;

        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          child: Column(
            children: [
              Text(
                isEn
                    ? 'The Best Investment for Your Healthcare'
                    : 'Investasi Terbaik untuk Layanan Kesehatan Anda',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 24.0,
                    tablet: 28.0,
                    desktop: 32.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: settings.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isEn
                    ? 'Get a fully integrated digital solution at an affordable price with no hidden monthly fees'
                    : 'Dapatkan solusi digital terintegrasi dengan harga terjangkau tanpa biaya bulanan tersembunyi',
                style: TextStyle(
                  fontSize: 16,
                  color: settings.textColor.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Main pricing card
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Card(
                  color: settings.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                        color: teal.withValues(alpha: 0.35), width: 2),
                  ),
                  elevation: 12,
                  child: Padding(
                    padding: EdgeInsets.all(
                      ResponsiveLayout.value(
                        context,
                        mobile: 20.0,
                        tablet: 28.0,
                        desktop: 32.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            isEn
                                ? 'LIFETIME LICENSE COMPLETE PACKAGE'
                                : 'PAKET LENGKAP LISENSI SELAMANYA',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'MAPOTECH Desktop',
                          style: TextStyle(
                            fontSize: ResponsiveLayout.value(
                              context,
                              mobile: 24.0,
                              tablet: 28.0,
                              desktop: 32.0,
                            ),
                            fontWeight: FontWeight.bold,
                            color: settings.textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp',
                              style: TextStyle(
                                fontSize: 20,
                                color: tealLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '150.000',
                              style: TextStyle(
                                fontSize: ResponsiveLayout.value(
                                  context,
                                  mobile: 42.0,
                                  tablet: 48.0,
                                  desktop: 54.0,
                                ),
                                fontWeight: FontWeight.w900,
                                color: settings.textColor,
                                shadows: [
                                  Shadow(
                                    color: teal.withValues(alpha: 0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: settings.textColor
                                .withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: settings.textColor
                                    .withValues(alpha: 0.08)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEn
                                    ? 'Features & Services You Get:'
                                    : 'Fitur dan Layanan yang Anda Dapatkan:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: settings.textColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...(isEn
                                      ? [
                                          'Full MAPOTECH Desktop Application',
                                          'Multi-Role Login (Owner, Admin, Doctor)',
                                          'Digital Patient Data Management',
                                          'Smart EMR & Electronic Prescription',
                                          'Stock Monitoring & Pharmacy FEFO',
                                          'Digital Staff Attendance',
                                          'Financial Recording & Integrated Cashier',
                                          'Lifetime License (One-Time Payment)',
                                          'Continuous Free Updates',
                                          'Technical Support from RELVA Team',
                                        ]
                                      : [
                                          'Aplikasi Desktop MAPOTECH Lengkap',
                                          'Login Multi-Role (Owner, Admin, Dokter)',
                                          'Manajemen Data Pasien Digital',
                                          'Smart EMR & Reksep Elektronik',
                                          'Pemantauan Stok & FEFO Apotek',
                                          'Absensi Staf Digital',
                                          'Pencatatan Keuangan & Kasir Terintegrasi',
                                          'Lisensi Selamanya (One-Time Payment)',
                                          'Update Gratis Berkelanjutan',
                                          'Dukungan Teknis dari Tim RELVA',
                                        ])
                                  .map(
                                    (feature) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.check,
                                              color: tealLight, size: 18),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              feature,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: settings.textColor
                                                    .withValues(
                                                        alpha: 0.75),
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
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/mapotech/customers');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: teal.withValues(alpha: 0.4),
                            ),
                            child: Text(
                              isEn
                                  ? 'BUY LICENSE NOW'
                                  : 'BELI LISENSI SEKARANG',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Comparison section
              Container(
                padding: EdgeInsets.all(
                  ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 24.0,
                    desktop: 28.0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: settings.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: teal.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Text(
                      isEn
                          ? 'Compare with Manual Methods'
                          : 'Bandingkan dengan Cara Manual',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: tealLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1.6),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.4),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: tealDark,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                ResponsiveLayout.value(
                                  context,
                                  mobile: 6.0,
                                  tablet: 10.0,
                                  desktop: 12.0,
                                ),
                              ),
                              child: Text(
                                isEn ? 'Aspect' : 'Aspek',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                ResponsiveLayout.value(
                                  context,
                                  mobile: 6.0,
                                  tablet: 10.0,
                                  desktop: 12.0,
                                ),
                              ),
                              child: Text(
                                isEn ? 'Manual' : 'Manual',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                ResponsiveLayout.value(
                                  context,
                                  mobile: 6.0,
                                  tablet: 10.0,
                                  desktop: 12.0,
                                ),
                              ),
                              child: const Text(
                                'MAPOTECH',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        _buildRow(context, settings, tealLight, isEn ? 'Patient Recording' : 'Pencatatan Pasien',
                            isEn ? 'Books & Paper' : 'Buku & Kertas', isEn ? 'Digital & Encrypted' : 'Digital & Terenkripsi'),
                        _buildRow(context, settings, tealLight, isEn ? 'Medicine Stock' : 'Stok Obat',
                            isEn ? 'Manual Check' : 'Cek Manual', isEn ? 'Auto Real-Time' : 'Otomatis Real-Time'),
                        _buildRow(context, settings, tealLight, isEn ? 'Prescription' : 'Resep Obat',
                            isEn ? 'Paper Manual' : 'Kertas Manual', isEn ? 'Electronic Prescription' : 'Resep Elektronik'),
                        _buildRow(context, settings, tealLight, isEn ? 'Staff Attendance' : 'Absensi Staf',
                            isEn ? 'Signature Paper' : 'Kertas Tanda Tangan', isEn ? 'Digital & Log' : 'Kehadiran Digital & Log'),
                        _buildRow(context, settings, tealLight, isEn ? 'Financial Report' : 'Laporan Keuangan',
                            isEn ? 'Slow Manual Recap' : 'Rekap Manual & Lambat', isEn ? 'Auto & Neat' : 'Otomatis & Rapi'),
                        _buildRow(context, settings, tealLight, isEn ? 'Data Loss' : 'Kehilangan Data',
                            isEn ? 'Highly Vulnerable' : 'Sangat Rentan', isEn ? 'Safely Stored Locally' : 'Aman Tersimpan Lokal'),
                      ],
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

  TableRow _buildRow(BuildContext context, AppSettings settings, Color tealLight,
      String aspect, String manual, String mapotech) {
    final padding = EdgeInsets.symmetric(
      horizontal: ResponsiveLayout.value(
        context,
        mobile: 6.0,
        tablet: 10.0,
        desktop: 12.0,
      ),
      vertical: ResponsiveLayout.value(
        context,
        mobile: 8.0,
        tablet: 12.0,
        desktop: 14.0,
      ),
    );

    final fontSize = ResponsiveLayout.value(
      context,
      mobile: 11.0,
      tablet: 12.0,
      desktop: 13.0,
    );

    return TableRow(
      children: [
        Padding(
          padding: padding,
          child: Text(
            aspect,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: settings.textColor,
              fontSize: fontSize,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            manual,
            style: TextStyle(
              color: settings.textColor.withValues(alpha: 0.6),
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            mapotech,
            style: TextStyle(
              color: tealLight,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
