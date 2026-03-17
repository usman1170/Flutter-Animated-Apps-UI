import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class AvatarModelLoader extends StatefulWidget {
  const AvatarModelLoader({super.key});

  @override
  State<AvatarModelLoader> createState() => _AvatarModelLoaderState();
}

class _AvatarModelLoaderState extends State<AvatarModelLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
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
      builder: (context, _) {
        final value = _controller.value;
        final pulse = 0.72 + (math.sin(value * math.pi * 2) + 1) * 0.14;
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _LoaderGridPainter(progress: value)),
            ),
            Container(
              width: 168,
              height: 168,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withAlpha(42),
                    AppColors.accent.withAlpha(0),
                  ],
                ),
              ),
            ),
            Transform.scale(
              scale: pulse,
              child: Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accent.withAlpha(90),
                    width: 1.4,
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: value * math.pi * 2,
              child: CustomPaint(
                size: const Size.square(136),
                painter: _LoaderRingPainter(),
              ),
            ),
            Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFF142132),
                  border: Border.all(color: AppColors.accent, width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(44),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Transform.rotate(
                  angle: -math.pi / 4,
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.accent,
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 46,
              child: Column(
                children: [
                  Text(
                    'RENDERING AVATAR',
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoaderGridPainter extends CustomPainter {
  _LoaderGridPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF12283A).withAlpha(42)
      ..strokeWidth = 1;
    const spacing = 24.0;
    final shift = (progress * spacing * 2) % spacing;
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y + shift),
        Offset(size.width, y + shift),
        paint,
      );
    }
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LoaderGridPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LoaderRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final track = Paint()
      ..color = const Color(0xFF24384A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(rect.deflate(6), 0, math.pi * 2, false, track);

    final active = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0x1100E5FF), AppColors.accent, Color(0xAA7EF5FF)],
        stops: [0, 0.55, 1],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawArc(rect.deflate(6), -1.1, math.pi * 1.45, false, active);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
