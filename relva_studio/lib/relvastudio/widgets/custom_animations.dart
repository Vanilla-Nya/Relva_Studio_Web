import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';

class FadeInSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;

  const FadeInSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 30),
  });

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  final double hoverOffset;
  final double hoverScale;

  const HoverCard({
    super.key,
    required this.child,
    this.hoverOffset = -8.0,
    this.hoverScale = 1.02,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: _isHovered ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          final currentScale = 1.0 + (widget.hoverScale - 1.0) * value;
          final currentOffset = widget.hoverOffset * value;
          return Transform.translate(
            offset: Offset(0.0, currentOffset),
            child: Transform.scale(
              scale: currentScale,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class BreathingBlob extends StatefulWidget {
  final Color color;
  final double size;

  const BreathingBlob({
    super.key,
    required this.color,
    required this.size,
  });

  @override
  State<BreathingBlob> createState() => _BreathingBlobState();
}

class _BreathingBlobState extends State<BreathingBlob> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentSize = widget.size * _animation.value;
        return Container(
          width: currentSize,
          height: currentSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                widget.color.withValues(alpha: 0.15),
                widget.color.withValues(alpha: 0.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final String targetText;
  final AppSettings settings;

  const AnimatedCounter({
    super.key,
    required this.targetText,
    required this.settings,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late int _targetValue;
  late String _suffix;

  @override
  void initState() {
    super.initState();
    final numericPart = widget.targetText.replaceAll(RegExp(r'[^0-9]'), '');
    _suffix = widget.targetText.replaceAll(RegExp(r'[0-9]'), '');
    _targetValue = int.tryParse(numericPart) ?? 0;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = IntTween(begin: 0, end: _targetValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}$_suffix',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: widget.settings.primaryColor,
          ),
        );
      },
    );
  }
}
