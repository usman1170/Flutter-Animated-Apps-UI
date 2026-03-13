import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TransferFlowBackdrop extends StatelessWidget {
  final Color accent;

  const TransferFlowBackdrop({super.key, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.screenBackground(context),
            AppColor.blueSoft(
              context,
            ).withAlpha(AppColor.isDark(context) ? 56 : 42),
            AppColor.screenBackground(context),
          ],
          stops: const [0, 0.32, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 44,
            right: -24,
            child: _GlowOrb(color: accent.withAlpha(42), size: 170),
          ),
          Positioned(
            top: 250,
            left: -30,
            child: _GlowOrb(
              color: AppColor.blueSoft(context).withAlpha(88),
              size: 180,
            ),
          ),
          Positioned(
            bottom: 110,
            right: -20,
            child: _GlowOrb(
              color: AppColor.mintSoft(context).withAlpha(78),
              size: 150,
            ),
          ),
        ],
      ),
    );
  }
}

class TransferGlassCard extends StatelessWidget {
  final Widget child;

  const TransferGlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(
          context,
        ).withAlpha(AppColor.isDark(context) ? 220 : 238),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColor.dividerColor(
            context,
          ).withAlpha(AppColor.isDark(context) ? 100 : 150),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(AppColor.isDark(context) ? 28 : 10),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

class TransferRoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const TransferRoundButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.elevatedSurface(context),
          border: Border.all(color: AppColor.dividerColor(context)),
        ),
        child: Icon(icon, color: AppColor.primaryLabel(context)),
      ),
    );
  }
}

class TransferHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const TransferHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColor.primaryLabel(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            color: AppColor.secondaryLabel(context),
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, AppColor.transparent]),
      ),
    );
  }
}
