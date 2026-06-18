import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                    ? 'MAPOTECH Privacy Policy'
                    : 'Kebijakan Privasi MAPOTECH',
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
                          ? 'MAPOTECH values your privacy. All patient health data, financial transactions, medical records, and medicine inventory you input into the application are securely stored in your local database or your chosen encrypted server, and are not misused by third parties.'
                          : 'MAPOTECH menghargai privasi Anda. Semua data kesehatan pasien, transaksi finansial, rekam medis, dan persediaan obat yang Anda input ke dalam aplikasi tersimpan secara aman di database lokal Anda atau server terenkripsi pilihan Anda, dan tidak disalahgunakan oleh pihak ketiga.',
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
                          ? 'As a cross-platform digital health platform, MAPOTECH is designed with high security standards to facilitate safe integration with SATUSEHAT and BPJS using official Ministry of Health and BPJS authentication.'
                          : 'Sebagai platform kesehatan digital cross-platform, MAPOTECH dirancang dengan standar keamanan tinggi untuk memfasilitasi integrasi dengan SATUSEHAT dan BPJS secara aman menggunakan otentikasi resmi kementerian kesehatan dan BPJS.',
                      style: TextStyle(
                        fontSize: 16,
                        color: settings.textColor
                            .withValues(alpha: 0.85),
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

