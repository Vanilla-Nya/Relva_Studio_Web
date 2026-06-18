import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        final teal = settings.primaryColor;

        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEn
                    ? 'MAPOTECH Terms & Conditions'
                    : 'Syarat & Ketentuan MAPOTECH',
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
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: settings.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: teal.withValues(alpha: 0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEn
                          ? 'By purchasing, installing, and using the MAPOTECH platform, you agree to the following terms:'
                          : 'Dengan membeli, meng-install, dan menggunakan platform MAPOTECH, Anda menyetujui ketentuan berikut:',
                      style: TextStyle(
                        fontSize: 16,
                        color: settings.textColor
                            .withValues(alpha: 0.85),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isEn
                          ? '1. License of use is limited to one healthcare facility, clinic, pharmacy, or private practice per license.\n'
                              '2. Strictly prohibited from redistributing, copying, or modifying the application source code for commercial purposes without written permission from RELVA Studio.\n'
                              '3. Application updates and technical setup assistance are provided in accordance with the agreed ordering package.\n'
                              '4. 7 working day money-back guarantee from the date of purchase if the application does not function on a computer system that meets the minimum criteria.\n'
                              '5. Users are fully responsible for the accuracy of medical record data, medicine prescriptions, and legal compliance related to local medical services.'
                          : '1. Lisensi penggunaan terbatas untuk satu fasilitas kesehatan, klinik, apotek, atau praktik mandiri per lisensi.\n'
                              '2. Dilarang keras mendistribusikan ulang, menyalin, atau memodifikasi kode sumber aplikasi untuk tujuan komersialisasi tanpa izin tertulis dari RELVA Studio.\n'
                              '3. Pembaruan (update) aplikasi dan bantuan teknis setup disediakan sesuai dengan paket pemesanan yang disepakati.\n'
                              '4. Jaminan/garansi pengembalian dana 7 hari kerja sejak pembelian apabila aplikasi tidak berfungsi pada sistem komputer yang memenuhi kriteria minimum.\n'
                              '5. Pengguna bertanggung jawab penuh atas keakuratan data rekam medis, resep obat, dan kepatuhan hukum terkait pelayanan medis lokal.',
                      style: TextStyle(
                        fontSize: 15,
                        color: settings.textColor
                            .withValues(alpha: 0.75),
                        height: 1.6,
                      ),
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
}
