import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import 'package:body_part_selector/body_part_selector.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  bool isFront = true;
  BodyParts _bodyParts = const BodyParts(
    leftUpperArm: true,
    leftLowerArm: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildProgress(),
              const SizedBox(height: 20),
              Text(
                'DO YOU HAVE ANY INJURIES OR PHYSICAL LIMITATIONS?',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 0.93,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Choose the body part where you are experiencing\ndiscomfort or an injury.',
                style: GoogleFonts.inter(
                  color: const Color(0xFFA0AEC4),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),
              _buildBodyCard(),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'PERSONAL INFO',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF141E2C),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF34465F), width: 1),
          ),
          child: Text(
            '8/8',
            style: GoogleFonts.orbitron(
              color: const Color(0xFFB4C0D5),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'SKIP',
          style: GoogleFonts.orbitron(
            color: const Color(0xFFA7B4CA),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return Row(
      children: List.generate(
        8,
        (index) => Expanded(
          child: Transform(
            transform: Matrix4.skewX(-0.42),
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(right: index == 7 ? 0 : 5),
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.accent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF14253D), Color(0xFF0A1730)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2E425D), width: 1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.55,
            child: Center(
              child: SizedBox(
                width: 192,
                child: BodyPartSelector(
                  bodyParts: _bodyParts,
                  side: isFront ? BodySide.front : BodySide.back,
                  onSelectionUpdated: (p) => setState(() => _bodyParts = p),
                  unselectedColor: const Color(0xFF55607A),
                  selectedColor: const Color(0xFF34F5FF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A2434),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFF31465F), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirection('FRONT', isFront, () {
                  setState(() {
                    isFront = true;
                  });
                }),
                _buildDirection('BACK', !isFront, () {
                  setState(() {
                    isFront = false;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirection(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF1E2B3F) : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: GoogleFonts.orbitron(
            color: active ? Colors.white : const Color(0xFF7A889E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
