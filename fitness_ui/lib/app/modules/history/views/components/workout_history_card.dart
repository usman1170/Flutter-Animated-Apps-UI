import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:body_part_selector/body_part_selector.dart';

class MuscleGroupThumbnail {
  const MuscleGroupThumbnail({
    required this.name,
    required this.parts,
    this.isFront = true,
  });

  final String name;
  final BodyParts parts;
  final bool isFront;
}

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({
    required this.date,
    required this.title,
    required this.duration,
    required this.exercisesCount,
    required this.calories,
    required this.exercisesText,
    required this.muscleGroups,
    super.key,
  });

  final String date;
  final String title;
  final String duration;
  final int exercisesCount;
  final int calories;
  final String exercisesText;
  final List<MuscleGroupThumbnail> muscleGroups;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101B27),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1B2A3D), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7B94),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Icon(Icons.more_vert, color: Color(0xFF6B7B94), size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatPill(Icons.timer_outlined, duration),
              const SizedBox(width: 8),
              _buildStatPill(
                Icons.fitness_center_outlined,
                '$exercisesCount exercises',
              ),
              const SizedBox(width: 8),
              _buildStatPill(
                Icons.local_fire_department_outlined,
                '$calories kcal',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Exercises:',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7B94),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exercisesText,
            style: GoogleFonts.inter(
              color: const Color(0xFF8D9CAE),
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100, // Fixed height for muscle graphs
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: muscleGroups.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final group = muscleGroups[index];
                return _buildMuscleGraphItem(group);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF162438),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF23364F), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF8B9CB2), size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              color: const Color(0xFFB1C0D4),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleGraphItem(MuscleGroupThumbnail group) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF162438),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF23364F), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: IgnorePointer(
              child: BodyPartSelector(
                bodyParts: group.parts,
                side: group.isFront ? BodySide.front : BodySide.back,
                onSelectionUpdated: (_) {}, // Read-only
                unselectedColor: const Color(0xFF324157),
                selectedColor: const Color(0xFF34F5FF),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            group.name,
            style: GoogleFonts.inter(
              color: const Color(0xFFD4E0F0),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
