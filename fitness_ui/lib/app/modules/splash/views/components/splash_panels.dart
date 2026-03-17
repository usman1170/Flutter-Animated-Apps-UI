import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class StatusPanel extends StatelessWidget {
  const StatusPanel({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xD0142130),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF2A3D54)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withAlpha(18),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: MetricChip(
              label: 'POWER',
              value: '${72 + (progress * 16).round()}%',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MetricChip(
              label: 'FOCUS',
              value: '${80 + (progress * 12).round()}%',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MetricChip(
              label: 'RECOVERY',
              value: '${64 + (progress * 18).round()}%',
            ),
          ),
        ],
      ),
    );
  }
}

class MetricChip extends StatelessWidget {
  const MetricChip({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF172434),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF223A51)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.orbitron(
              color: const Color(0xFF7E94AC),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.orbitron(
              color: AppColors.accent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class FooterProgress extends StatelessWidget {
  const FooterProgress({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SYNCING LOADOUT',
          style: GoogleFonts.orbitron(
            color: const Color(0xFF95A8BD),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 8,
            decoration: const BoxDecoration(color: Color(0xFF203243)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.15 + (progress * 0.85),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C2FF), AppColors.accent],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
