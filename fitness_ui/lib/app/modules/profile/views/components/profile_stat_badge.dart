import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import 'arc_progress_painter.dart';

class ProfileStatBadge extends StatefulWidget {
  const ProfileStatBadge({
    super.key,
    required this.icon,
    required this.label,
    required this.progress,
  });

  final IconData icon;
  final String label;
  final double progress;

  @override
  State<ProfileStatBadge> createState() => _ProfileStatBadgeState();
}

class _ProfileStatBadgeState extends State<ProfileStatBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _intro;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1050 + (widget.progress * 250).round()),
    );
    _intro = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
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
      animation: _controller,
      builder: (context, _) {
        final introValue = _intro.value;
        final pulse = 0.9 + (introValue * 0.1);
        final glow = 0.18 + (introValue * 0.55);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: pulse,
              child: SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.accent.withAlpha((glow * 70).round()),
                            AppColors.accent.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: CustomPaint(
                        painter: ArcProgressPainter(
                          progress: widget.progress,
                          phase: introValue,
                          glow: glow,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(7.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF132131),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF21354A),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(28),
                                blurRadius: 14,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            color: AppColors.accent,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 9,
                      child: Transform.translate(
                        offset: Offset(
                          math.cos((introValue * math.pi * 1.15) - 0.4) * 2,
                          math.sin((introValue * math.pi * 1.15) - 0.4) * 2,
                        ),
                        child: Container(
                          width: 4.5,
                          height: 4.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(
                              (110 + (introValue * 110)).round(),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withAlpha(
                                  (40 + (introValue * 90)).round(),
                                ),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0x88142231),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF263A50)),
              ),
              child: Text(
                widget.label,
                style: GoogleFonts.orbitron(
                  color: const Color(0xFFB7C4D2),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
