import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _openWhatsApp(BuildContext context, String phone) async {
    final uri = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: "_blank");
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
        );
      }
    }
  }

  Future<void> _openEmail(BuildContext context, String email,
      {bool isEn = false}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'MAPOTECH Inquiry',
        'body': isEn
            ? 'Hello, I would like information about MAPOTECH...'
            : 'Halo, saya ingin informasi tentang MAPOTECH...',
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(isEn
                  ? 'Cannot open email'
                  : 'Tidak dapat membuka email')),
        );
      }
    }
  }

  Future<void> _openMaps(BuildContext context, String url,
      {bool isEn = false}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank');
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  isEn ? 'Cannot open maps' : 'Tidak dapat membuka maps')),
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
        final tealDark = settings.primaryColor.withValues(alpha: 0.85);
        final tealLight = settings.accentColor;

        final contactCard = Card(
          color: settings.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: teal.withValues(alpha: 0.2)),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.phone,
                        color: tealLight, size: 26),
                  ),
                  title: Text(
                    isEn
                        ? 'Phone / WhatsApp'
                        : 'Telepon / WhatsApp',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    isEn
                        ? '+62 821-3241-1163\nDirect contact with the development team'
                        : '+62 821-3241-1163\nKontak langsung dengan tim pengembang',
                    style: TextStyle(
                      fontSize: 14,
                      color: settings.textColor
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  onTap: () =>
                      _openWhatsApp(context, '6282132411163'),
                ),
                Divider(
                    color:
                        settings.textColor.withValues(alpha: 0.1)),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.email,
                        color: tealLight, size: 26),
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    isEn
                        ? 'Fontaro990@gmail.com\nResponse within 2-4 hours'
                        : 'Fontaro990@gmail.com\nRespon dalam 2-4 jam',
                    style: TextStyle(
                      fontSize: 14,
                      color: settings.textColor
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  onTap: () => _openEmail(context,
                      'Fontaro990@gmail.com',
                      isEn: isEn),
                ),
                Divider(
                    color:
                        settings.textColor.withValues(alpha: 0.1)),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.location_city,
                        color: tealLight, size: 26),
                  ),
                  title: Text(
                    isEn ? 'Location' : 'Lokasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: settings.textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Dusun Krajan RT02/RW01 Kecamatan Pujer (Praktek Dokter Umum Dr. Agoes), BONDOWOSO, JAWA TIMUR 68271',
                    style: TextStyle(
                      fontSize: 14,
                      color: settings.textColor
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  onTap: () => _openMaps(
                    context,
                    'https://maps.app.goo.gl/qQefnsiEq5GQddje8',
                    isEn: isEn,
                  ),
                ),
              ],
            ),
          ),
        );

        final purchaseCard = Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [teal, tealDark],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: teal.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  isEn ? 'How to Purchase' : 'Cara Pembelian',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildPurchaseStep(
                '1',
                isEn
                    ? 'Contact us via WhatsApp or Email'
                    : 'Hubungi kami via WhatsApp atau Email',
                teal,
              ),
              _buildPurchaseStep(
                '2',
                isEn
                    ? 'Transfer Rp 150.000 to the provided account'
                    : 'Transfer Rp 150.000 ke rekening yang diberikan',
                teal,
              ),
              _buildPurchaseStep(
                '3',
                isEn
                    ? 'Send proof of transfer'
                    : 'Kirim bukti transfer',
                teal,
              ),
              _buildPurchaseStep(
                '4',
                isEn
                    ? 'Receive download link + installation guide'
                    : 'Terima link download + panduan instalasi',
                teal,
              ),
              _buildPurchaseStep(
                '5',
                isEn
                    ? 'Our team will help with setup if needed (We\'ll come to your location — Bondowoso area only!)'
                    : 'Tim kami akan membantu setup jika diperlukan (Kami Akan Datang Ke tempat Anda (Khusus daerah Bondowoso saja!))',
                teal,
              ),
            ],
          ),
        );

        final isWide = !ResponsiveLayout.isMobile(context);

        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: true,
          child: Column(
            children: [
              Text(
                isEn ? 'Contact Us' : 'Hubungi Kami',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 28.0,
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
                isEn
                    ? 'The RELVA team is ready to help you implement MAPOTECH at your clinic, pharmacy, or private practice'
                    : 'Tim RELVA siap membantu Anda mengimplementasikan MAPOTECH di klinik, apotek, atau praktik mandiri Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: settings.textColor.withValues(alpha: 0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: contactCard),
                    const SizedBox(width: 24),
                    Expanded(child: purchaseCard),
                  ],
                )
              else
                Column(
                  children: [
                    contactCard,
                    const SizedBox(height: 24),
                    purchaseCard,
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPurchaseStep(String step, String description, Color teal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: teal),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

