// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

final Set<String> _registeredViews = <String>{};

Widget buildPlatformVideoView({
  required String mediaPath,
  required String uniqueId,
}) {
  final cleanId = 'card-video-bg-${uniqueId}_${mediaPath.hashCode.abs()}';

  if (!_registeredViews.contains(cleanId)) {
    _registeredViews.add(cleanId);
    ui_web.platformViewRegistry.registerViewFactory(cleanId, (int viewId) {
      final video = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..loop = true
        ..controls = false
        ..setAttribute('playsinline', 'true')
        ..setAttribute('webkit-playsinline', 'true')
        ..setAttribute('muted', '')
        ..style.border = 'none'
        ..style.outline = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..style.pointerEvents = 'none'
        ..style.position = 'absolute'
        ..style.top = '0'
        ..style.left = '0';

      final isRemote =
          mediaPath.startsWith('http://') || mediaPath.startsWith('https://');

      if (isRemote) {
        final source = html.SourceElement()
          ..src = mediaPath
          ..type = 'video/mp4';
        video.append(source);
      } else {
        // Normalize asset path for Flutter Web
        final cleanPath =
            mediaPath.startsWith('/') ? mediaPath.substring(1) : mediaPath;

        // Try direct asset path
        final s1 = html.SourceElement()
          ..src = cleanPath
          ..type = 'video/mp4';
        video.append(s1);

        // Try prefixed assets/ path (standard in Flutter web build output)
        if (!cleanPath.startsWith('assets/')) {
          final s2 = html.SourceElement()
            ..src = 'assets/$cleanPath'
            ..type = 'video/mp4';
          video.append(s2);
        } else {
          final s2 = html.SourceElement()
            ..src = 'assets/$cleanPath'
            ..type = 'video/mp4';
          video.append(s2);
        }
      }

      // Autoplay with muted guarantee
      video.play().catchError((_) {
        // Handled silently
      });

      return video;
    });
  }

  return IgnorePointer(
    child: SizedBox.expand(
      child: HtmlElementView(viewType: cleanId),
    ),
  );
}

