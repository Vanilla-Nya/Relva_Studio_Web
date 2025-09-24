import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _openWhatsApp(BuildContext context, String phone) async {
    final uri = Uri.parse('https://wa.me/$phone'); // phone: e.g. 6282132411163
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: "_blank",
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
        );
      }
    }
  }

  Future<void> _openEmail(BuildContext context, String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Pertanyaan MAPOTEK',
        'body': 'Halo, saya ingin informasi tentang MAPOTEK...',
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka email')),
        );
      }
    }
  }

  Future<void> _openMaps(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka maps')),
        );
      }
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
                      leading: const Icon(
                        Icons.phone,
                        color: Color(0xFF2E7D8E),
                        size: 32,
                      ),
                      title: const Text(
                        "Telepon / WhatsApp",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "+62 821-3241-1163\nKontak langsung dengan tim pengembang",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        _openWhatsApp(context, '6282132411163');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Color(0xFF2E7D8E),
                        size: 32,
                      ),
                      title: const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "Fontaro990@gmail.com\nRespon dalam 2-4 jam",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        _openEmail(context, 'Fontaro990@gmail.com');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.location_city,
                        color: Color(0xFF2E7D8E),
                        size: 32,
                      ),
                      title: const Text(
                        "Lokasi",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "Dusun Krajan RT02/RW01 Kecamatan Pujer (Praktek Dokter Umum Dr. Agoes), BONDOWOSO, JAWA TIMUR 68271",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        _openMaps(
                          context,
                          'https://maps.app.goo.gl/qQefnsiEq5GQddje8',
                        );
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
                  _buildPurchaseStep(
                    "1",
                    "Hubungi kami via WhatsApp atau Email",
                  ),
                  _buildPurchaseStep(
                    "2",
                    "Transfer Rp 150.000 ke rekening yang diberikan",
                  ),
                  _buildPurchaseStep("3", "Kirim bukti transfer"),
                  _buildPurchaseStep(
                    "4",
                    "Terima link download + panduan instalasi",
                  ),
                  _buildPurchaseStep(
                    "5",
                    "Tim kami akan membantu setup jika diperlukan (Kami Akan Datang Ke tempat Anda (Khusus daerah Bondowoso saja!))",
                  ),
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
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
