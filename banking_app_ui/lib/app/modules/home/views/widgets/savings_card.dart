import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 148,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFBFE6FF), Color(0xFFA7DCFF)],
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.white.withAlpha(30),
                      AppColor.transparent,
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              right: 128,
              top: 24,
              child: _SavingsCopy(),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(190),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.x,
                  size: 16,
                  color: Color(0xFF51606F),
                ),
              ),
            ),
            const Positioned(right: 8, top: 6, child: _SavingsIllustration()),
          ],
        ),
      ),
    );
  }
}

class _SavingsCopy extends StatelessWidget {
  const _SavingsCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Savings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              height: 1.25,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
            children: [
              TextSpan(text: 'Save and earn up to '),
              TextSpan(
                text: '16%',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Annual interest on your balance',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF42627D),
          ),
        ),
      ],
    );
  }
}

class _SavingsIllustration extends StatelessWidget {
  const _SavingsIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 136,
      height: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 6,
            bottom: 4,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                width: 66,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF94CFFF), Color(0xFF5CAEFF)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withAlpha(18),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 56,
            bottom: 22,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColor.white.withAlpha(165),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const Positioned(right: 62, bottom: 18, child: _CoinIcon()),
          Positioned(
            right: 44,
            top: 6,
            child: Transform.rotate(
              angle: 0.18,
              child: Container(
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF8FCFF), Color(0xFFBCC9D6)],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withAlpha(20),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinIcon extends StatelessWidget {
  const _CoinIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF9AA5B1), width: 3),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFDFEFE), Color(0xFFE5EBF1)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF7B8794), width: 2),
            ),
          ),
          const Icon(LucideIcons.clock3, size: 18, color: Color(0xFF111827)),
        ],
      ),
    );
  }
}
