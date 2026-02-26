import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:body_part_selector/body_part_selector.dart';

import '../../../core/theme/app_colors.dart';
import 'components/workout_history_card.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildMonthSelector(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
                    children: [
                      WorkoutHistoryCard(
                        date: '11/4/24',
                        title: 'Glutes, Chest & Legs',
                        duration: '45 min',
                        exercisesCount: 6,
                        calories: 365,
                        exercisesText:
                            'Hip Thrust • Cycling - Stationary • Barbell Decline Bench Press • Push Up on Knees • Incline Push Up • Superman',
                        muscleGroups: [
                          const MuscleGroupThumbnail(
                            name: 'Quadriceps',
                            isFront: true,
                            parts: BodyParts(
                              leftUpperLeg: true,
                              rightUpperLeg: true,
                            ),
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Glutes',
                            isFront: false,
                            parts: BodyParts(
                              lowerBody: true,
                            ), // lowerBody acts broadly, or we could customize
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Chest',
                            isFront: true,
                            parts: BodyParts(
                              upperBody: true,
                            ), // We'll map to upperBody assuming chest covers it visually
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Lower back',
                            isFront: false,
                            parts: BodyParts(
                              abdomen: true,
                            ), // Using abdomen mapped to back side often hits lower back visually
                          ),
                        ],
                      ),
                      WorkoutHistoryCard(
                        date: '11/2/24',
                        title: 'Legs & Core Blast',
                        duration: '45 min',
                        exercisesCount: 6,
                        calories: 265,
                        exercisesText:
                            'Jog In Place • Air Squats • Lunge Jump • Bicycle Crunch • Superman Hold • Crunches',
                        muscleGroups: [
                          const MuscleGroupThumbnail(
                            name: 'Calves',
                            isFront: false,
                            parts: BodyParts(
                              leftLowerLeg: true,
                              rightLowerLeg: true,
                            ),
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Quadriceps',
                            isFront: true,
                            parts: BodyParts(
                              leftUpperLeg: true,
                              rightUpperLeg: true,
                            ),
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Abs',
                            isFront: true,
                            parts: BodyParts(abdomen: true),
                          ),
                          const MuscleGroupThumbnail(
                            name: 'Lower back',
                            isFront: false,
                            parts: BodyParts(abdomen: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 24,
              bottom: 24,
              child: _buildLeftFloatingButtons(),
            ),
            Positioned(right: 24, bottom: 24, child: _buildActionButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WORKOUT HISTORY',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildLegendDot(const Color(0xFFFFD600), 'UPPER: 25%'),
              const SizedBox(width: 16),
              _buildLegendDot(AppColors.accent, 'LOWER: 50%'),
              const SizedBox(width: 16),
              _buildLegendDot(const Color(0xFF2962FF), 'CORE: 25%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFFB1C0D4),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'NOVEMBER, 2024',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          Row(
            children: [
              _buildChevronDiamond(Icons.chevron_left_rounded),
              const SizedBox(width: 12),
              _buildChevronDiamond(Icons.chevron_right_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChevronDiamond(IconData icon) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF132030),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(icon, size: 20, color: const Color(0xFF566781)),
        ),
      ),
    );
  }

  Widget _buildLeftFloatingButtons() {
    return Row(
      children: [
        _buildDiamondIcon(Icons.grid_view_rounded, true),
        const SizedBox(width: 8),
        _buildDiamondIcon(Icons.view_agenda_rounded, false),
      ],
    );
  }

  Widget _buildDiamondIcon(IconData icon, bool isActive) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1B2A3D) : const Color(0x90142439),
          border: Border.all(
            color: isActive ? AppColors.accent : const Color(0xFF2D425C),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(
            icon,
            size: 22,
            color: isActive ? Colors.white : const Color(0xFF566781),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withAlpha(70),
              blurRadius: 10,
              spreadRadius: 1.2,
            ),
          ],
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: const Icon(
            Icons.add_rounded,
            color: Color(0xFF06131E),
            size: 28,
          ),
        ),
      ),
    );
  }
}
