import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syarat & Ketentuan"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Syarat & Ketentuan MAPOTEK",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "Dengan membeli dan menggunakan MAPOTEK, Anda menyetujui:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "1. Lisensi penggunaan untuk satu praktik/klinik\n"
              "2. Dilarang mendistribusikan atau menjual ulang aplikasi\n"
              "3. Update dan support disediakan oleh tim RELVA\n"
              "4. Garansi 7 hari uang kembali jika tidak puas\n"
              "5. Tim RELVA tidak bertanggung jawab atas kehilangan data akibat kesalahan pengguna",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
