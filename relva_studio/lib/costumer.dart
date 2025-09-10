import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final Map<String, String> formData = {
      'firstname': '',
      'lastname': '',
      'email': '',
      'phoneNumber': '',
      'address': '',
      'city': '',
      'postalCode': '',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) => formData['firstname'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => formData['lastname'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => formData['email'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => formData['phoneNumber'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) => formData['address'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                onSaved: (value) => formData['city'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Postal Code'),
                onSaved: (value) => formData['postalCode'] = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    print(formData.toString());
                    // Send formData as a POST request to the specified URL
                    Future<void> sendData() async {
                      final url = Uri.parse(
                        'https://sandbox.duitku.com/webapi/api/merchant/v2/inquiry',
                      );
                      try {
                        final response = await Future.delayed(
                          Duration.zero,
                          () async {
                            return await Future.value(
                              await post(
                                url,
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({
                                  "merchantCode": "DS24853",
                                  "paymentAmount": "20000",
                                  "paymentMethod": "VA",
                                  "merchantOrderId": "1757298753507",
                                  "productDetails":
                                      "Pembayaran untuk Toko Contoh",
                                  "additionalParam": "",
                                  "merchantUserInfo": "",
                                  "customerVaName":
                                      "${formData['firstname']} ${formData['lastname']}",
                                  "email": "${formData['email']}",
                                  "phoneNumber": "${formData['phoneNumber']}",
                                  "itemDetails": [
                                    {
                                      "name": "Test Item 1",
                                      "price": 150000,
                                      "quantity": 1,
                                    },
                                  ],
                                  "customerDetail": {
                                    "firstName": "${formData['firstname']}",
                                    "lastName": "${formData['lastname']}",
                                    "email": "${formData['email']}",
                                    "phoneNumber": "${formData['phoneNumber']}",
                                    "billingAddress": {
                                      "firstName": "${formData['firstname']}",
                                      "lastName": "${formData['lastname']}",
                                      "address": "${formData['address']}",
                                      "city": "${formData['city']}",
                                      "postalCode": "${formData['postalCode']}",
                                      "phone": "${formData['phoneNumber']}",
                                      "countryCode": "ID",
                                    },
                                    "shippingAddress": {
                                      "firstName": "${formData['firstname']}",
                                      "lastName": "${formData['lastname']}",
                                      "address": "${formData['address']}",
                                      "city": "${formData['city']}",
                                      "postalCode": "${formData['postalCode']}",
                                      "phone": "${formData['phoneNumber']}",
                                      "countryCode": "ID",
                                    },
                                  },
                                  "callbackUrl": "YOUR_MOCK_URL/callback",
                                  "returnUrl": "YOUR_MOCK_URL/return",
                                  "signature":
                                      "04eacfa14f89819777f843fd16378f3d",
                                  "expiryPeriod": 15,
                                }),
                              ),
                            );
                          },
                        );
                        if (response.statusCode == 200) {
                          // Success
                          final responseData = jsonDecode(response.body);
                          final paymentUrl = responseData['paymentUrl'];
                          if (paymentUrl != null) {
                            if (context.mounted) {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: const Text('Payment'),
                                    ),
                                    body: Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // Open the paymentUrl in the browser
                                          // You need to add url_launcher package in pubspec.yaml
                                          // import 'package:url_launcher/url_launcher.dart';
                                          if (context.mounted) {
                                            if (await canLaunchUrl(
                                              paymentUrl,
                                            )) {
                                              await launchUrl(paymentUrl);
                                            }
                                          }
                                        },
                                        child: const Text('Open Payment URL'),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data sent successfully!'),
                              ),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed: ${response.statusCode}'),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    }

                    sendData();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
