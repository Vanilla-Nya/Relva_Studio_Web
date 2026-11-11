import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'card_media_background_stub.dart'
    if (dart.library.html) 'card_media_background_web.dart';

enum CardMediaType {
  none,
  videoAsset,
  videoUrl,
  gifAsset,
  gifUrl,
  imageAsset,
  imageUrl,
}

/// Custom Card Media Background Widget
/// Strictly follows Zero External UI Packages Rule.
/// Supports Video Link, Manual Local Video, GIF, and Image with REV Palette Glassmorphism.
class CardMediaBackground extends StatelessWidget {
  final String? mediaPath;
  final String uniqueId;
  final double overlayAlpha;
  final Widget? child;
  final BorderRadius? borderRadius;

  const CardMediaBackground({
    super.key,
    required this.mediaPath,
    this.uniqueId = 'header',
    this.overlayAlpha = 0.85,
    this.child,
    this.borderRadius,
  });

  CardMediaType _detectMediaType(String? path) {
    if (path == null || path.trim().isEmpty) return CardMediaType.none;
    final lower = path.toLowerCase().trim();
    final isRemote = lower.startsWith('http://') || lower.startsWith('https://');

    if (lower.endsWith('.mp4') ||
        lower.endsWith('.webm') ||
        lower.endsWith('.ogg') ||
        lower.endsWith('.mov')) {
      return isRemote ? CardMediaType.videoUrl : CardMediaType.videoAsset;
    }

    if (lower.endsWith('.gif')) {
      return isRemote ? CardMediaType.gifUrl : CardMediaType.gifAsset;
    }

    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp')) {
      return isRemote ? CardMediaType.imageUrl : CardMediaType.imageAsset;
    }

    // Default to videoUrl if remote link
    if (isRemote) return CardMediaType.videoUrl;

    return CardMediaType.none;
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    final isDark = settings.theme == AppThemeMode.dark;
    final mediaType = _detectMediaType(mediaPath);

    Widget backgroundMedia;

    switch (mediaType) {
      case CardMediaType.videoAsset:
      case CardMediaType.videoUrl:
        if (kIsWeb) {
          backgroundMedia = buildPlatformVideoView(
            mediaPath: mediaPath!,
            uniqueId: uniqueId,
          );
        } else {
          // Non-web fallback
          backgroundMedia = Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  settings.primaryColor.withValues(alpha: 0.3),
                  settings.accentColor.withValues(alpha: 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        }
        break;

      case CardMediaType.gifAsset:
        backgroundMedia = kIsWeb
            ? Image.network(
                mediaPath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (ctx, err, stack) => Image.asset(
                  mediaPath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (ctx2, err2, stack2) => const SizedBox.shrink(),
                ),
              )
            : Image.asset(
                mediaPath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (ctx, err, stack) => const SizedBox.shrink(),
              );
        break;

      case CardMediaType.gifUrl:
        backgroundMedia = Image.network(
          mediaPath!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (ctx, err, stack) => const SizedBox.shrink(),
        );
        break;

      case CardMediaType.imageAsset:
        backgroundMedia = kIsWeb
            ? Image.network(
                mediaPath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (ctx, err, stack) => Image.asset(
                  mediaPath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (ctx2, err2, stack2) => const SizedBox.shrink(),
                ),
              )
            : Image.asset(
                mediaPath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (ctx, err, stack) => const SizedBox.shrink(),
              );
        break;

      case CardMediaType.imageUrl:
        backgroundMedia = Image.network(
          mediaPath!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (ctx, err, stack) => const SizedBox.shrink(),
        );
        break;

      case CardMediaType.none:
        backgroundMedia = const SizedBox.shrink();
        break;
    }

    Widget content = Stack(
      children: [
        // 1. Underneath Dynamic Media (Video / GIF / Image)
        if (mediaType != CardMediaType.none)
          Positioned.fill(
            child: ClipRect(
              child: backgroundMedia,
            ),
          ),

        // 2. REV Aesthetic Frosted & Tinted Glass Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: mediaType != CardMediaType.none
                    ? [
                        settings.cardColor
                            .withValues(alpha: isDark ? overlayAlpha : overlayAlpha * 0.96),
                        settings.cardColor.withValues(
                            alpha: isDark
                                ? (overlayAlpha + 0.08).clamp(0.0, 0.98)
                                : (overlayAlpha * 0.98).clamp(0.0, 0.98)),
                        settings.surfaceColor.withValues(
                            alpha: isDark
                                ? (overlayAlpha + 0.05).clamp(0.0, 0.98)
                                : (overlayAlpha * 0.92).clamp(0.0, 0.98)),
                      ]
                    : [
                        settings.cardColor.withValues(alpha: 0.94),
                        settings.cardColor.withValues(alpha: 0.94),
                      ],
              ),
            ),
          ),
        ),

        // 3. Ambient Light Glow Accents
        Positioned(
          top: -80,
          right: -80,
          child: IgnorePointer(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    settings.primaryColor.withValues(alpha: 0.18),
                    settings.primaryColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -60,
          left: 100,
          child: IgnorePointer(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    settings.accentColor.withValues(alpha: 0.14),
                    settings.accentColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 4. Foreground Content (Headers, Photo, Actions, Stats)
        if (child != null) child!,
      ],
    );

    if (borderRadius != null) {
      content = ClipRRect(
        borderRadius: borderRadius!,
        child: content,
      );
    }

    return content;
  }
}

