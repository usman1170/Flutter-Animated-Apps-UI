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
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF101B27),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF1B2A3D), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildShareSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                'YOUR FRIENDS: 3',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            _buildFriendsList(),
            if (_showSuccess) _buildSuccessToast(),
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CHOOSE YOUR WORKOUT\nTEAM!',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Invite up to 3 friends or random players to your\nworkout. Start anytime — no need to wait for others.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8B9CB2),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF162332),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF24364A), width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF5D6E85),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'SEARCH FOR A FRIEND',
                  style: GoogleFonts.orbitron(
                    color: const Color(0xFF5D6E85),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDiamondIcon(Icons.copy_rounded),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xFF162332),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF24364A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'HTTPS://EXAM...',
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFF8B9CB2),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: _onShare,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'SHARE',
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFF06131E),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsList() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 220),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        shrinkWrap: true,
        children: [
          _buildFriendTile(
            'Layla Ramsey',
            'Lvl 2 • Current streak: 5 w',
            'L',
            AppColors.accent,
            isInvited: false,
          ),
          const SizedBox(height: 8),
          _buildFriendTile(
            'Ethan Brooks',
            'Lvl 1 • Current streak: 1 w',
            'E',
            const Color(0xFFE0E0E0),
            isInvited: false,
          ),
          const SizedBox(height: 8),
          _buildFriendTile(
            'Evelyn Castillo',
            'Lvl 3 • Current streak: 2 w',
            'EC',
            const Color(0xFFFF9800),
            isInvited: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendTile(
    String name,
    String subtitle,
    String initial,
    Color initialColor, {
    required bool isInvited,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF162332),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF24364A), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2D40),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: TextStyle(
                color: initialColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
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
                    color: const Color(0xFF8B9CB2),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (isInvited)
            const Icon(Icons.check_rounded, color: Color(0xFF8B9CB2), size: 24)
          else
            const Icon(Icons.add_rounded, color: Color(0xFF8B9CB2), size: 24),
        ],
      ),
    );
  }

  Widget _buildSuccessToast() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF162D3D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1E3F54), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF162D3D).withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.email_outlined, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SUCCESS!',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'The invitation was sent!',
                style: GoogleFonts.inter(
                  color: const Color(0xFF90A3BB),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2A3A),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF293D52), width: 1),
                ),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.orbitron(
                    color: const Color(0xFF7C8EA6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF43FAFF), Color(0xFF20E8FC)],
                ),
                borderRadius: BorderRadius.circular(10),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiamondIcon(IconData icon) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF162332),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF24364A), width: 1),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(icon, size: 16, color: const Color(0xFF5D6E85)),
        ),
      ),
    );
  }
}
