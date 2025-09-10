import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              Icon(
                Icons.desktop_windows,
                size: 120,
                color: const Color(0xFF2E7D8E),
              ),
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
