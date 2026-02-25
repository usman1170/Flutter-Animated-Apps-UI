import 'package:flutter/material.dart';

class GoalStreakPanel extends StatelessWidget {
  const GoalStreakPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardGap = constraints.maxWidth * 0.04;
        final double weeklyHeight = constraints.maxWidth * 0.72;
        final double metricHeight = constraints.maxWidth * 0.42;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWeeklyGoalCard(
              height: weeklyHeight,
              panelWidth: constraints.maxWidth,
            ),
            SizedBox(height: cardGap),
            _buildMetricCard(
              title: 'Current streak',
              value: '3 WEEKS',
              icon: Icons.calendar_today_rounded,
              height: metricHeight,
              panelWidth: constraints.maxWidth,
            ),
            SizedBox(height: cardGap),
            _buildMetricCard(
              title: 'Longest streak',
              value: '5 WEEKS',
              icon: Icons.workspace_premium_rounded,
              height: metricHeight,
              panelWidth: constraints.maxWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeeklyGoalCard({
    required double height,
    required double panelWidth,
  }) {
    final double titleSize = (panelWidth * 0.09).clamp(9.0, 12.0);
    final double valueSize = (panelWidth * 0.23).clamp(18.0, 30.0);
    final double trophySize = (panelWidth * 0.27).clamp(24.0, 42.0);
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A3451), Color(0xFF122742), Color(0xFF0C1B2D)],
          stops: [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2B425B), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3500E5FF),
            blurRadius: 10,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 8,
            child: Text(
              'Weekly goal',
              style: TextStyle(
                color: const Color(0xFFC9D5E7),
                fontSize: titleSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 24,
            right: trophySize + 14,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF59F6FF), Color(0xFF00E6FF)],
                  ).createShader(bounds),
                  child: Text(
                    'DONE',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: valueSize,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      height: 0.92,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 8,
            child: _buildGradientIcon(
              icon: Icons.emoji_events_rounded,
              size: trophySize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required double height,
    required double panelWidth,
  }) {
    final double titleSize = (panelWidth * 0.085).clamp(9.0, 12.0);
    final double valueSize = (panelWidth * 0.15).clamp(13.0, 20.0);
    final double iconSize = (panelWidth * 0.11).clamp(12.0, 16.0);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF14253A), Color(0xFF0D1B2A)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2B425B), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFC9D5E7),
                    fontSize: titleSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF55F2FF), Color(0xFF00E5FF)],
                    ).createShader(bounds),
                    child: Text(
                      value,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: valueSize,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        height: 0.95,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: _buildGradientIcon(icon: icon, size: iconSize),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientIcon({required IconData icon, required double size}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF61F7FF), Color(0xFF00E5FF)],
      ).createShader(bounds),
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}
