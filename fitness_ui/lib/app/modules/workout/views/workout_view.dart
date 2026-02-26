import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import 'personal_info_view.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            _buildHeader(),
            const SizedBox(height: 14),
            _buildWeeklyProgress(),
            const SizedBox(height: 16),
            _buildTodayWorkoutCard(),
            const SizedBox(height: 16),
            _buildQuickFocusRow(),
            const SizedBox(height: 16),
            _buildSectionTitle('RECOMMENDED CIRCUITS'),
            const SizedBox(height: 10),
            _buildCircuitTile(
              title: 'HIIT SHRED',
              subtitle: '18 min · Full body · Medium',
              calories: '220 kcal',
            ),
            const SizedBox(height: 10),
            _buildCircuitTile(
              title: 'CORE & GLUTES BLAST',
              subtitle: '24 min · Lower + Core · Hard',
              calories: '310 kcal',
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('MUSCLE FOCUS MAP'),
            const SizedBox(height: 10),
            _buildMuscleFocusSection(),
            const SizedBox(height: 16),
            _buildSectionTitle('RECOVERY & MOBILITY'),
            const SizedBox(height: 10),
            _buildRecoverySection(),
            const SizedBox(height: 16),
            _buildPersonalInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WORKOUT',
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Build your plan, track your limits, and start stronger sessions.',
          style: GoogleFonts.inter(
            color: const Color(0xFF93A8C0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyProgress() {
    const int completed = 5;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WEEKLY TARGET',
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF9CB2C8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(
                  7,
                  (index) => Expanded(
                    child: Transform(
                      transform: Matrix4.skewX(-0.42),
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(right: index == 6 ? 0 : 4),
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: index < completed
                              ? AppColors.accent
                              : const Color(0xFF25374D),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF132030),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2D425C), width: 1),
          ),
          child: Text(
            '$completed/7',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayWorkoutCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162941), Color(0xFF0D1B30)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2D4561), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY\'S SESSION',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Strength + Conditioning',
            style: GoogleFonts.inter(
              color: const Color(0xFFA9BCD2),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              _WorkoutStatChip(label: '28 min'),
              SizedBox(width: 8),
              _WorkoutStatChip(label: '6 exercises'),
              SizedBox(width: 8),
              _WorkoutStatChip(label: '320 kcal'),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(70),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'START WORKOUT',
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF06131E),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFocusRow() {
    return Row(
      children: List.generate(
        3,
        (index) {
          const labels = ['UPPER', 'LOWER', 'CORE'];
          const values = ['72%', '64%', '58%'];
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF142337),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2C415A), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    labels[index],
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFF8FA5BF),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    values[index],
                    style: GoogleFonts.orbitron(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.orbitron(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    );
  }

  Widget _buildCircuitTile({
    required String title,
    required String subtitle,
    required String calories,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF132238),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A405A), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF1D314B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bolt_rounded, color: AppColors.accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8FA4BE),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            calories,
            style: GoogleFonts.orbitron(
              color: AppColors.accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF121F31),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A3E57), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERSONAL INFO',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Set injuries or physical limitations before starting plans.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8FA4BE),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Get.to(() => const PersonalInfoView()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF192B42),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: const Color(0xFF36516D), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'OPEN PERSONAL INFO',
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFFC7D6EA),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.accent,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleFocusSection() {
    final items = <_FocusItem>[
      _FocusItem(
        name: 'Shoulders',
        intensity: 'High',
        side: BodySide.front,
        parts: const BodyParts(leftShoulder: true, rightShoulder: true),
      ),
      _FocusItem(
        name: 'Back',
        intensity: 'Medium',
        side: BodySide.back,
        parts: const BodyParts(upperBody: true),
      ),
      _FocusItem(
        name: 'Core',
        intensity: 'High',
        side: BodySide.front,
        parts: const BodyParts(abdomen: true),
      ),
      _FocusItem(
        name: 'Quads',
        intensity: 'Medium',
        side: BodySide.front,
        parts: const BodyParts(leftUpperLeg: true, rightUpperLeg: true),
      ),
    ];

    return SizedBox(
      height: 142,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, index) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final item = items[index];
          return Container(
            width: 110,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF132238),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A405A), width: 1),
            ),
            child: Column(
              children: [
                Expanded(
                  child: IgnorePointer(
                    child: BodyPartSelector(
                      bodyParts: item.parts,
                      side: item.side,
                      onSelectionUpdated: (_) {},
                      unselectedColor: const Color(0xFF3A4960),
                      selectedColor: AppColors.accent,
                    ),
                  ),
                ),
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D314B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.intensity,
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFFA9BDD4),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecoverySection() {
    return Row(
      children: [
        Expanded(
          child: _buildRecoveryTile(
            title: 'POST-WORKOUT',
            subtitle: '8 min stretch flow',
            icon: Icons.self_improvement_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildRecoveryTile(
            title: 'SLEEP SCORE',
            subtitle: 'Last night: 81%',
            icon: Icons.nights_stay_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildRecoveryTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF121F31),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A3E57), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 18),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF90A5BF),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutStatChip extends StatelessWidget {
  const _WorkoutStatChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A3F),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFF324963), width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFFC0D0E3),
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FocusItem {
  const _FocusItem({
    required this.name,
    required this.intensity,
    required this.side,
    required this.parts,
  });

  final String name;
  final String intensity;
  final BodySide side;
  final BodyParts parts;
}
