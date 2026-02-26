import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class TeamInvitationPopup extends StatefulWidget {
  const TeamInvitationPopup({super.key});

  @override
  State<TeamInvitationPopup> createState() => _TeamInvitationPopupState();
}

class _TeamInvitationPopupState extends State<TeamInvitationPopup> {
  bool _showSuccess = false;

  void _onShare() {
    setState(() {
      _showSuccess = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSuccess = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: const Color(0xFF121E31),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF2A3D57), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x8A030915),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 10),
                  _buildSearchField(),
                  const SizedBox(height: 9),
                  _buildShareRow(),
                  const SizedBox(height: 12),
                  Text(
                    'YOUR FRIENDS: 3',
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFriendsList(),
                  const SizedBox(height: 10),
                  if (_showSuccess) ...[
                    _buildSuccessToast(),
                    const SizedBox(height: 10),
                  ],
                  _buildBottomActions(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: _buildCloseButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHOOSE YOUR WORKOUT\nTEAM!',
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 29 / 2,
            fontWeight: FontWeight.w700,
            height: 1.05,
            letterSpacing: 0.35,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Invite up to 3 friends or random players to your\nworkout. Start anytime - no need to wait for others.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9BAFC4),
            fontSize: 10,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A3F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF324863), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF7A8EA7), size: 18),
          const SizedBox(width: 8),
          Text(
            'SEARCH FOR A FRIEND',
            style: GoogleFonts.orbitron(
              color: const Color(0xFF7A8EA7),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareRow() {
    return Row(
      children: [
        _buildDiamondIcon(Icons.copy_rounded),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A3F),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF324863), width: 1),
            ),
            child: Text(
              'HTTPS://EXAM...',
              style: GoogleFonts.orbitron(
                color: const Color(0xFF92A6BD),
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: _onShare,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 34,
            width: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x6629D9ED),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'SHARE',
              style: GoogleFonts.orbitron(
                color: const Color(0xFF06131E),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFriendsList() {
    return Column(
      children: [
        _buildFriendTile(
          name: 'Layla Ramsey',
          subtitle: 'Lvl 2 · Current streak: 5 w',
          initial: 'L',
          initialColor: AppColors.accent,
          isInvited: false,
        ),
        const SizedBox(height: 7),
        _buildFriendTile(
          name: 'Ethan Brooks',
          subtitle: 'Lvl 1 · Current streak: 1 w',
          initial: 'E',
          initialColor: const Color(0xFFE0E0E0),
          isInvited: false,
        ),
        const SizedBox(height: 7),
        _buildFriendTile(
          name: 'Evelyn Castillo',
          subtitle: 'Lvl 3 · Current streak: 2 w',
          initial: 'EC',
          initialColor: const Color(0xFFFFB300),
          isInvited: true,
        ),
      ],
    );
  }

  Widget _buildFriendTile({
    required String name,
    required String subtitle,
    required String initial,
    required Color initialColor,
    required bool isInvited,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF192A3F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF31455E), width: 1),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF24364D),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: TextStyle(
                    color: initialColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              if (!isInvited)
                const Positioned(
                  right: -2,
                  top: -2,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.accent,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF90A3BA),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isInvited ? Icons.check_rounded : Icons.add_rounded,
            color: const Color(0xFF9AAEC6),
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessToast() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4152),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF32657B), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF0D5569),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.mail_outline_rounded, color: AppColors.accent, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SUCCESS!',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                'The invitation was sent!',
                style: GoogleFonts.inter(
                  color: const Color(0xFFC0D3E4),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF222F43),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF344860), width: 1),
              ),
              child: Text(
                'CANCEL',
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF8A9CB5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.35,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x5A34E8FC),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'START',
              style: GoogleFonts.orbitron(
                color: const Color(0xFF06131E),
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFF212C3D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF344860), width: 1),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: const Icon(Icons.close_rounded, size: 16, color: Color(0xFF7E90A8)),
        ),
      ),
    );
  }

  Widget _buildDiamondIcon(IconData icon) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2D41),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFF334860), width: 1),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(icon, size: 15, color: const Color(0xFF8296AF)),
        ),
      ),
    );
  }
}
