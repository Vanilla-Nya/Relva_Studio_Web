import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  final String imagePath;
  final String tag;

  const ImageDetailPage({
    super.key,
    required this.imagePath,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screenshot MAPOTEK"),
        backgroundColor: const Color(0xFF2E7D8E),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Card(
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
