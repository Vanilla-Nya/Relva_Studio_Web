import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kebijakan Privasi"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Kebijakan Privasi MAPOTEK",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "MAPOTEK menghargai privasi Anda. Semua data yang Anda input ke dalam aplikasi tersimpan secara lokal di komputer Anda dan tidak dikirim ke server manapun.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "Aplikasi desktop MAPOTEK tidak mengumpulkan, menyimpan, atau membagikan data pribadi Anda kepada pihak ketiga. Data pasien dan praktik Anda sepenuhnya berada dalam kendali Anda.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
