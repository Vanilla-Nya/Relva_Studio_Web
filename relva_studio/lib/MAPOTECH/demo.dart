import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  Future<void> _openUrl(BuildContext context, String url, String errMsg) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errMsg)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        final teal = settings.primaryColor;
        final tealLight = settings.accentColor;

        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: teal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: teal.withValues(alpha: 0.3), width: 2),
                ),
                child: Icon(
                  Icons.desktop_windows_rounded,
                  size: ResponsiveLayout.value(
                    context,
                    mobile: 70.0,
                    tablet: 85.0,
                    desktop: 100.0,
                  ),
                  color: tealLight,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                isEn
                    ? 'Download MAPOTECH Desktop'
                    : 'Download MAPOTECH Desktop',
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
              const SizedBox(height: 16),
              Text(
                isEn
                    ? 'Easy-to-install Windows desktop application, ready to use for your operational needs'
                    : 'Aplikasi desktop untuk Windows yang mudah di-install dan siap digunakan untuk kebutuhan operasional Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: settings.textColor.withValues(alpha: 0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Card(
                  color: settings.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: teal.withValues(alpha: 0.2)),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            isEn ? 'System Requirements:' : 'Persyaratan Sistem:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: settings.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildReqRow('Windows 7/8/10/11', tealLight, settings),
                        _buildReqRow(isEn ? 'Minimum 2GB RAM' : 'RAM minimal 2GB', tealLight, settings),
                        _buildReqRow(isEn ? '500MB free storage' : 'Penyimpanan kosong 500MB', tealLight, settings),
                        _buildReqRow('.NET Framework 4.5+', tealLight, settings),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _openUrl(
                                context,
                                'https://drive.google.com/drive/folders/1aQWYkf5ulsRSFS8j5CMjvBAaWuHjgTC4?usp=drive_link',
                                isEn
                                    ? 'Cannot open download link'
                                    : 'Tidak dapat membuka link download',
                              );
                            },
                            icon: const Icon(Icons.download_rounded,
                                size: 24),
                            label: Text(
                              isEn ? 'Download Now' : 'Download Sekarang',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: teal.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReqRow(String text, Color tealLight, AppSettings settings) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded,
              color: tealLight, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: settings.textColor.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
