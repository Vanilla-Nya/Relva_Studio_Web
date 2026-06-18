import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';

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
    final settings = AppSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: settings.backgroundColor,
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: Hero(
                    tag: tag,
                    child: Card(
                      elevation: 16,
                      color: settings.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: settings.cardColor.withValues(alpha: 0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: settings.textColor, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
