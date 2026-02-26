import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  bool isFront = true;
  BodyParts bodyParts = const BodyParts(
    leftUpperArm: true,
    leftLowerArm: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050D18),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 22),
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
              const SizedBox(height: 16),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: Get.back,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF132030),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF2E425D), width: 1),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: Color(0xFFC4D4E8),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'PERSONAL INFO',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2B3F),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF31465F), width: 1),
              ),
              child: Text(
                'BACK',
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF9EAEC3),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(70),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'FINISH',
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF06131E),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
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
                  bodyParts: bodyParts,
                  side: isFront ? BodySide.front : BodySide.back,
                  onSelectionUpdated: (p) => setState(() => bodyParts = p),
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
