import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  // Form controllers for better state management
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
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
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

  // Enhanced form data getter
  Map<String, String> get _formData => {
    'firstname': _firstNameController.text.trim(),
    'lastname': _lastNameController.text.trim(),
    'email': _emailController.text.trim(),
    'phoneNumber': _phoneController.text.trim(),
    'address': _addressController.text.trim(),
    'city': _cityController.text.trim(),
    'postalCode': _postalCodeController.text.trim(),
  };

  // Enhanced Duitku API call with better error handling
  Future<void> _processDuitkuPayment() async {
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
          await _navigateToPayment(paymentUrl);
        } else {
          _showErrorSnackBar('Invalid payment URL received');
        }
      } else {
        _showErrorSnackBar(
          'Payment initialization failed: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Connection error: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _navigateToPayment(String paymentUrl) async {
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
      _showSuccessSnackBar('Payment completed successfully!');
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
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              if (label == 'Email' && !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }

  List<Widget> get _formSteps => [
    // Personal Info Step
    Column(
      children: [
        _buildTextField(
          controller: _firstNameController,
          label: 'First Name',
          icon: Icons.person,
        ),
        _buildTextField(
          controller: _lastNameController,
          label: 'Last Name',
          icon: Icons.person_outline,
        ),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
      ],
    ),
    // Address Step
    Column(
      children: [
        _buildTextField(
          controller: _addressController,
          label: 'Address',
          icon: Icons.home,
        ),
        _buildTextField(
          controller: _cityController,
          label: 'City',
          icon: Icons.location_city,
        ),
        _buildTextField(
          controller: _postalCodeController,
          label: 'Postal Code',
          icon: Icons.local_post_office,
          keyboardType: TextInputType.number,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duitku Payment Form'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Progress indicator
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (_currentStep + 1) / _formSteps.length,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Step ${_currentStep + 1} of ${_formSteps.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    // Form content
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: SingleChildScrollView(
                          key: ValueKey(_currentStep),
                          child: _formSteps[_currentStep],
                        ),
                      ),
                    ),

                    // Navigation buttons
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          if (_currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => _currentStep--);
                                },
                                child: const Text('Previous'),
                              ),
                            ),
                          if (_currentStep > 0) const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      if (_currentStep <
                                          _formSteps.length - 1) {
                                        setState(() => _currentStep++);
                                      } else {
                                        _processDuitkuPayment();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                                      _currentStep < _formSteps.length - 1
                                          ? 'Next'
                                          : 'Pay with Duitku',
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
        ),
      ),
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
    final phone = '6282132411163';
    final encodedMessage = Uri.encodeComponent(message);
    final uri = Uri.parse('https://wa.me/$phone?text=$encodedMessage');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cannot open WhatsApp')));
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
            'MAPOTEK Payment Confirmation - ${widget.customerData['firstname']} ${widget.customerData['lastname']}',
        'body': message,
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cannot open email')));
      }
    }
  }

  String _generateInvoiceMessage() {
    final now = DateTime.now();
    final invoiceId = 'INV-${now.millisecondsSinceEpoch}';

    return '''
🧾 INVOICE PEMBAYARAN MAPOTEK

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
• Product: MAPOTEK Software
• Harga: Rp 150.000
• Status: COMPLETED ✅
• Payment via: Duitku

📩 Selanjutnya:
Mohon tunggu konfirmasi dari tim kami. Anda akan menerima:
1. Link download MAPOTEK
2. Panduan instalasi
3. Setup assistance (khusus area Bondowoso)

Terima kasih telah mempercayai MAPOTEK! 🙏
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duitku Payment'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: !_paymentCompleted
                ? _buildPaymentSection(context)
                : _buildCompletedSection(context),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.payment,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              const Text(
                'Ready to Pay',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Click the button below to open Duitku payment gateway',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final uri = Uri.parse(widget.paymentUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        // Show payment completed screen
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
                            content: Text('Error opening payment: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Open Duitku Payment'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Payment Completed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Thank you ${widget.customerData['firstname']}!\nYour MAPOTEK purchase is confirmed.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Contact options
              const Text(
                'Get Your Invoice & Download Link:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // WhatsApp Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _openWhatsApp,
                  icon: const Icon(Icons.chat, color: Colors.white),
                  label: const Text('Send Invoice via WhatsApp'),
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
                  icon: const Icon(Icons.email, color: Colors.white),
                  label: const Text('Send Invoice via Email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D8E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Done button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
