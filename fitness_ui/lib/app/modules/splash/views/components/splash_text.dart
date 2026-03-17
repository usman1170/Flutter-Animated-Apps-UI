import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBadge extends StatelessWidget {
  const TopBadge({super.key, required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xCC122032),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF294057)),
        ),
        child: Text(
          'PLAYERFIT // SYSTEM ONLINE',
          style: GoogleFonts.orbitron(
            color: const Color(0xFFCFE5F8),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.8,
          ),
        ),
      ),
    );
  }
}

class TitleBlock extends StatelessWidget {
  const TitleBlock({super.key, required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Text(
            'PLAYERFIT',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'CALIBRATING YOUR NEXT SESSION',
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              color: const Color(0xFF8EA3BA),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.4,
            ),
          ),
        ],
      ),
    );
  }
}
