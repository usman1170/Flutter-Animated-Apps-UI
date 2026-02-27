import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/lobby_controller.dart';
import 'components/team_invitation_popup.dart';

class LobbyView extends StatefulWidget {
  const LobbyView({super.key});

  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends State<LobbyView> {
  late final LobbyController controller;
  bool _isQuestTab = false;
  bool _isClaiming = false;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<LobbyController>()) {
      controller = Get.find<LobbyController>();
    } else {
      controller = Get.put(LobbyController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Expanded(
              child: Stack(
                children: [
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    offset: _isQuestTab ? const Offset(-0.08, 0) : Offset.zero,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: _isQuestTab ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: _isQuestTab,
                        child: _buildPlayTabContent(context),
                      ),
                    ),
                  ),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    offset: _isQuestTab ? Offset.zero : const Offset(0.08, 0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: _isQuestTab ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !_isQuestTab,
                        child: _buildQuestTabContent(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runClaimAnimation() async {
    if (_isClaiming) return;
    setState(() => _isClaiming = true);

    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Claim reward',
      barrierColor: const Color(0xAA020811),
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const _ClaimRewardOverlay();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );

    if (mounted) {
      setState(() => _isClaiming = false);
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
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
          const SizedBox(height: 14),
          _buildModeTabs(),
        ],
      ),
    );
  }

  Widget _buildModeTabs() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF132030),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2D425C), width: 1),
      ),
      child: Row(
        children: [
          _buildModeTabButton(label: 'PLAY', isActive: !_isQuestTab),
          _buildModeTabButton(label: 'QUESTS', isActive: _isQuestTab),
        ],
      ),
    );
  }

  Widget _buildModeTabButton({required String label, required bool isActive}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isQuestTab = label == 'QUESTS'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1B2A3D) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(color: AppColors.accent, width: 1)
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.orbitron(
              color: isActive ? Colors.white : const Color(0xFF566781),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayTabContent(BuildContext context) {
    return Container(
      key: const ValueKey('play_tab'),
      child: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              final avatarPath = controller.selectedAvatarPath.value.isEmpty
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
    );
  }

  Widget _buildQuestTabContent() {
    return Container(
      key: const ValueKey('quest_tab'),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 92),
            children: [
              _buildQuestSummaryCard(),
              const SizedBox(height: 14),
              _buildQuestSectionTitle('DAILY OPS'),
              const SizedBox(height: 8),
              _buildQuestTile(
                title: 'Complete 2 Workouts',
                subtitle: 'Progress 1/2',
                xp: '+120 XP',
                progress: 0.5,
              ),
              const SizedBox(height: 8),
              _buildQuestTile(
                title: 'Burn 300 Calories',
                subtitle: 'Progress 220/300 kcal',
                xp: '+90 XP',
                progress: 0.73,
              ),
              const SizedBox(height: 14),
              _buildQuestSectionTitle('WEEKLY MISSIONS'),
              const SizedBox(height: 8),
              _buildQuestTile(
                title: '7 Day Streak',
                subtitle: 'Progress 5/7',
                xp: '+300 XP',
                progress: 0.71,
              ),
              const SizedBox(height: 8),
              _buildQuestTile(
                title: 'Invite 3 Teammates',
                subtitle: 'Progress 2/3',
                xp: '+180 XP',
                progress: 0.67,
              ),
              const SizedBox(height: 14),
              _buildQuestSectionTitle('BOSS CHALLENGE'),
              const SizedBox(height: 8),
              _buildBossCard(),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: GestureDetector(
              onTap: _runClaimAnimation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isClaiming
                        ? const [Color(0xFF64F8FF), Color(0xFF28EEFF)]
                        : const [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(_isClaiming ? 120 : 70),
                      blurRadius: _isClaiming ? 18 : 10,
                      spreadRadius: _isClaiming ? 2 : 1,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: Text(
                    _isClaiming ? 'CLAIMING...' : 'CLAIM READY REWARDS',
                    key: ValueKey(_isClaiming),
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFF06131E),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF172A42), Color(0xFF0F1D31)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E4561), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUEST BOARD',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              _QuestChip(label: 'Active 6'),
              SizedBox(width: 8),
              _QuestChip(label: 'Completed 14'),
              SizedBox(width: 8),
              _QuestChip(label: 'Reward 420'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.orbitron(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildQuestTile({
    required String title,
    required String subtitle,
    required String xp,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF122235),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A415B), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                xp,
                style: GoogleFonts.orbitron(
                  color: AppColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF8FA4BE),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFF263A52),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBossCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111F32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A405A), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF1A314B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_fire_department_rounded, color: AppColors.accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Final Burn Challenge',
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Complete 4 intense sessions in 48 hours',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8FA4BE),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+600',
            style: GoogleFonts.orbitron(
              color: AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
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
        color: const Color(0xFF10212D),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
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
                  'Your friend has invited you to join the multiple workout.',
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
                          border: Border.all(color: AppColors.accent, width: 1),
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
                color: AppColors.accent.withAlpha(76),
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

class _QuestChip extends StatelessWidget {
  const _QuestChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2D45),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFF2F4865), width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.orbitron(
          color: const Color(0xFFB7C8DB),
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ClaimRewardOverlay extends StatefulWidget {
  const _ClaimRewardOverlay();

  @override
  State<_ClaimRewardOverlay> createState() => _ClaimRewardOverlayState();
}

class _ClaimRewardOverlayState extends State<_ClaimRewardOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glow;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();

    _glow = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.72)),
    );

    Future.delayed(const Duration(milliseconds: 1900), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 34),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF122235),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF315174), width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withAlpha((80 * _glow.value).toInt()),
                  blurRadius: 28 * _glow.value,
                  spreadRadius: 2 * _glow.value,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _controller.value < 0.74 ? 'CLAIMING REWARD' : 'REWARD CLAIMED',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: _progress.value,
                    minHeight: 7,
                    backgroundColor: const Color(0xFF253B56),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _controller.value < 0.74 ? 0 : 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '+420 COINS • +180 XP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF06131E),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
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
}
