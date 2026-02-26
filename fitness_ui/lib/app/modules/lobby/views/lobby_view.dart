import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/lobby_controller.dart';
import 'components/team_invitation_popup.dart';

class LobbyView extends GetView<LobbyController> {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(LobbyController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                Expanded(
                  child: Obx(() {
                    final avatarPath =
                        controller.selectedAvatarPath.value.isEmpty
                        ? 'https://models.readyplayer.me/65893b0514f9f5f28e61d783.glb'
                        : controller.selectedAvatarPath.value;
                    return ModelViewer(
                      key: ValueKey(avatarPath),
                      backgroundColor: Colors.transparent,
                      src: avatarPath,
                      alt: 'A 3D model of a rigged human',
                      ar: false,
                      autoRotate: false,
                      cameraControls: true,
                      disableZoom: true,
                    );
                  }),
                ),
              ],
            ),
            // Bottom Action Bar & Overlay
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWorkoutInvitationCard(),
                  const SizedBox(height: 16),
                  _buildBottomActionBar(context),
                ],
              ),
            ),
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
            'LOBBY',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LVL 2',
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '500/1000 XP',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildSegmentedProgressBar(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF132030),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF2D425C), width: 1),
                ),
                child: Row(
                  children: [
                    Text(
                      'COINS: ',
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF8B9CB2),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.generating_tokens,
                      color: AppColors.accent,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '500',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF132030),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2D425C), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2A3D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.accent, width: 1),
                    ),
                    child: Text(
                      'PLAY',
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'QUESTS',
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF566781),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedProgressBar() {
    return Row(
      children: List.generate(
        8,
        (index) => Expanded(
          child: Transform(
            transform: Matrix4.skewX(-0.42),
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(right: index == 7 ? 0 : 4),
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: index < 4 ? AppColors.accent : const Color(0xFF25374D),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutInvitationCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF10212D), // Custom dark teal to match reference
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Fainter shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF152A3A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.forward_to_inbox_rounded,
              color: AppColors.accent,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WORKOUT INVITATION',
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your friend has invited you to join the multiple\nworkout.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8B9CB2),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2A3A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'DECLINE',
                          style: GoogleFonts.orbitron(
                            color: const Color(0xFF677A91),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F3642),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.accent,
                            width: 1,
                          ), // solid cyan
                        ),
                        child: Text(
                          'ACCEPT',
                          style: GoogleFonts.orbitron(
                            color: AppColors.accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Row(
      children: [
        _buildDiamondIcon(Icons.person_outline_rounded),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF132030),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2D425C), width: 1),
            ),
            child: Row(
              children: [
                _buildFriendAvatar('L', AppColors.accent, isActive: true),
                const SizedBox(width: 4),
                _buildFriendAvatar('E', const Color(0xFFE0E0E0)),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const TeamInvitationPopup(),
                    );
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2D42),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.accent,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'START',
            style: GoogleFonts.orbitron(
              color: const Color(0xFF06131E),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFriendAvatar(
    String initial,
    Color color, {
    bool isActive = false,
  }) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2D40),
        border: isActive
            ? Border.all(color: AppColors.accent, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDiamondIcon(IconData icon) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0x90142439),
          border: Border.all(color: const Color(0xFF2D425C), width: 1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(icon, size: 22, color: const Color(0xFF566781)),
        ),
      ),
    );
  }
}
