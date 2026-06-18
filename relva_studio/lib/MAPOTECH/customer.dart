import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/widgets/responsive_layout.dart';

class EnhancedCustomerPage extends StatefulWidget {
  const EnhancedCustomerPage({super.key});

  @override
  State<EnhancedCustomerPage> createState() => _EnhancedCustomerPageState();
}

class _EnhancedCustomerPageState extends State<EnhancedCustomerPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLoading = false;
  int _currentStep = 0;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Map<String, String> get _formData => {
    'firstname': _firstNameController.text.trim(),
    'lastname': _lastNameController.text.trim(),
    'email': _emailController.text.trim(),
    'phoneNumber': _phoneController.text.trim(),
    'address': _addressController.text.trim(),
    'city': _cityController.text.trim(),
    'postalCode': _postalCodeController.text.trim(),
  };

  Future<void> _processDuitkuPayment(AppSettings settings) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse(
        'https://relva-studio-backend.onrender.com/api/duitku-inquiry',
      );

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(_formData),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final paymentUrl = responseData['paymentUrl'] as String?;

        if (paymentUrl != null && paymentUrl.isNotEmpty) {
          await _navigateToPayment(paymentUrl, settings);
        } else {
          _showErrorSnackBar('Gagal mendapatkan tautan pembayaran.');
        }
      } else {
        _showErrorSnackBar(
          'Inisiasi pembayaran gagal: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Kesalahan koneksi: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _navigateToPayment(
      String paymentUrl, AppSettings settings) async {
    final result = await Navigator.of(context).push<bool>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentPage(paymentUrl: paymentUrl, customerData: _formData),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );

    if (result == true && mounted) {
      _showSuccessSnackBar(
        settings.language == AppLanguage.en
            ? 'Payment completed successfully!'
            : 'Pembayaran berhasil diselesaikan!',
        settings,
      );
      _resetForm();
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _cityController.clear();
    _postalCodeController.clear();
    setState(() => _currentStep = 0);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessSnackBar(String message, AppSettings settings) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: settings.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required AppSettings settings,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool isEn = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: settings.textColor),
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return isEn
                    ? '$label is required'
                    : '$label wajib diisi';
              }
              if (label.toLowerCase().contains('email') &&
                  !value.contains('@')) {
                return isEn
                    ? 'Invalid email format'
                    : 'Format email tidak valid';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: settings.textColor.withValues(alpha: 0.6)),
          prefixIcon:
              Icon(icon, color: settings.accentColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: settings.textColor.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: settings.textColor.withValues(alpha: 0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: settings.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Colors.redAccent, width: 2),
          ),
          filled: true,
          fillColor:
              settings.textColor.withValues(alpha: 0.04),
        ),
      ),
    );
  }

  List<Widget> _buildFormSteps(AppSettings settings, bool isEn) => [
    // Personal Info Step
    Column(
      key: const ValueKey('step0'),
      children: [
        _buildTextField(
          controller: _firstNameController,
          label: isEn ? 'First Name' : 'Nama Depan (First Name)',
          icon: Icons.person_rounded,
          settings: settings,
          isEn: isEn,
        ),
        _buildTextField(
          controller: _lastNameController,
          label: isEn ? 'Last Name' : 'Nama Belakang (Last Name)',
          icon: Icons.person_outline_rounded,
          settings: settings,
          isEn: isEn,
        ),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          icon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          settings: settings,
          isEn: isEn,
        ),
        _buildTextField(
          controller: _phoneController,
          label: isEn ? 'Phone Number' : 'Nomor Telepon (Phone Number)',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          settings: settings,
          isEn: isEn,
        ),
      ],
    ),
    // Address Step
    Column(
      key: const ValueKey('step1'),
      children: [
        _buildTextField(
          controller: _addressController,
          label: isEn ? 'Full Address' : 'Alamat Lengkap (Address)',
          icon: Icons.home_rounded,
          settings: settings,
          isEn: isEn,
        ),
        _buildTextField(
          controller: _cityController,
          label: isEn ? 'City / Regency' : 'Kota/Kabupaten (City)',
          icon: Icons.location_city_rounded,
          settings: settings,
          isEn: isEn,
        ),
        _buildTextField(
          controller: _postalCodeController,
          label: isEn ? 'Postal Code' : 'Kode Pos (Postal Code)',
          icon: Icons.local_post_office_rounded,
          keyboardType: TextInputType.number,
          settings: settings,
          isEn: isEn,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        final formSteps = _buildFormSteps(settings, isEn);

        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: false,
          isScrollable: false,
          maxContentWidth: 600.0,
          padding: const EdgeInsets.fromLTRB(16, 76, 16, 24),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Progress indicator
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: (_currentStep + 1) / formSteps.length,
                                minHeight: 6,
                                backgroundColor:
                                    settings.textColor.withValues(alpha: 0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  settings.accentColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            isEn
                                ? 'Step ${_currentStep + 1} of ${formSteps.length}'
                                : 'Langkah ${_currentStep + 1} dari ${formSteps.length}',
                            style: TextStyle(
                              color: settings.textColor.withValues(alpha: 0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form content
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: SingleChildScrollView(
                          key: ValueKey(_currentStep),
                          child: formSteps[_currentStep],
                        ),
                      ),
                    ),

                    // Navigation buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          if (_currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => _currentStep--);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: settings.primaryColor, width: 1.5),
                                  foregroundColor: settings.accentColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  isEn ? 'Previous' : 'Sebelumnya',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          if (_currentStep > 0) const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      if (_currentStep < formSteps.length - 1) {
                                        setState(() => _currentStep++);
                                      } else {
                                        _processDuitkuPayment(settings);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: settings.primaryColor,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                shadowColor: settings.primaryColor
                                    .withValues(alpha: 0.4),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      _currentStep < formSteps.length - 1
                                          ? (isEn ? 'Continue' : 'Lanjutkan')
                                          : (isEn
                                              ? 'Pay with Duitku'
                                              : 'Bayar dengan Duitku'),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String paymentUrl;
  final Map<String, String> customerData;

  const PaymentPage({
    super.key,
    required this.paymentUrl,
    required this.customerData,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _paymentCompleted = false;

  Future<void> _openWhatsApp() async {
    final message = _generateInvoiceMessage();
    const phone = '6282132411163';
    final encodedMessage = Uri.encodeComponent(message);
    final uri = Uri.parse('https://wa.me/$phone?text=$encodedMessage');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot open WhatsApp')),
        );
      }
    }
  }

  Future<void> _openEmail() async {
    final message = _generateInvoiceMessage();
    final uri = Uri(
      scheme: 'mailto',
      path: 'Fontaro990@gmail.com',
      queryParameters: {
        'subject':
            'MAPOTECH Payment Confirmation - ${widget.customerData['firstname']} ${widget.customerData['lastname']}',
        'body': message,
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot open email')),
        );
      }
    }
  }

  String _generateInvoiceMessage() {
    final now = DateTime.now();
    final invoiceId = 'INV-${now.millisecondsSinceEpoch}';

    return '''
🧾 INVOICE PEMBAYARAN MAPOTECH

📋 Detail Pembelian:
• Invoice ID: $invoiceId
• Tanggal: ${now.day}/${now.month}/${now.year}
• Waktu: ${now.hour}:${now.minute}

👤 Data Customer:
• Nama: ${widget.customerData['firstname']} ${widget.customerData['lastname']}
• Email: ${widget.customerData['email']}
• Phone: ${widget.customerData['phoneNumber']}
• Alamat: ${widget.customerData['address']}, ${widget.customerData['city']}, ${widget.customerData['postalCode']}

💰 Pembayaran:
• Product: MAPOTECH Software License
• Harga: Rp 150.000
• Status: COMPLETED ✅
• Payment via: Duitku

📩 Selanjutnya:
Mohon tunggu konfirmasi dari tim kami. Anda akan menerima:
1. Link download MAPOTECH Desktop
2. Panduan instalasi
3. Setup assistance (khusus area Bondowoso)

Terima kasih telah mempercayai MAPOTECH! 🙏
''';
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final isEn = settings.language == AppLanguage.en;
        return ResponsivePageTemplate(
          showBackButton: true,
          showFooter: false,
          maxContentWidth: 500.0,
          child: Center(
            child: !_paymentCompleted
                ? _buildPaymentSection(context, settings, isEn)
                : _buildCompletedSection(context, settings, isEn),
          ),
        );
      },
    );
  }

  Widget _buildPaymentSection(
      BuildContext context, AppSettings settings, bool isEn) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: settings.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: settings.primaryColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: settings.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payment_rounded,
              size: 72,
              color: settings.accentColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            isEn ? 'Ready to Pay' : 'Siap Melakukan Pembayaran',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: settings.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isEn
                ? 'Click the button below to open the Duitku payment gateway securely.'
                : 'Klik tombol di bawah ini untuk membuka gerbang pembayaran Duitku secara aman.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: settings.textColor.withValues(alpha: 0.6),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  final uri = Uri.parse(widget.paymentUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri,
                        mode: LaunchMode.externalApplication);
                    setState(() {
                      _paymentCompleted = true;
                    });
                  } else {
                    throw Exception('Cannot launch payment URL');
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isEn
                            ? 'Failed to open payment link: $e'
                            : 'Gagal membuka link pembayaran: $e'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.open_in_browser_rounded),
              label: Text(
                isEn ? 'Open Duitku Payment' : 'Buka Pembayaran Duitku',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor:
                    settings.primaryColor.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedSection(
      BuildContext context, AppSettings settings, bool isEn) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: settings.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 72,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            isEn ? 'Payment Complete!' : 'Pembayaran Selesai!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isEn
                ? 'Thank you ${widget.customerData['firstname']}!\nYour MAPOTECH license purchase has been confirmed.'
                : 'Terima kasih ${widget.customerData['firstname']}!\nPembelian lisensi MAPOTECH Anda telah dikonfirmasi.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: settings.textColor.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Divider(color: settings.textColor.withValues(alpha: 0.1)),
          const SizedBox(height: 16),
          Text(
            isEn
                ? 'Get Your Invoice & Download Link:'
                : 'Dapatkan Invoice & Link Unduhan:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: settings.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // WhatsApp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openWhatsApp,
              icon: const Icon(Icons.chat_rounded),
              label: Text(
                isEn
                    ? 'Send Invoice via WhatsApp'
                    : 'Kirim Invoice via WhatsApp',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Email Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openEmail,
              icon: const Icon(Icons.email_rounded),
              label: Text(
                isEn
                    ? 'Send Invoice via Email'
                    : 'Kirim Invoice via Email',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Done button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: TextButton.styleFrom(
              foregroundColor: settings.accentColor,
            ),
            child: Text(
              isEn ? 'Done' : 'Selesai',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
