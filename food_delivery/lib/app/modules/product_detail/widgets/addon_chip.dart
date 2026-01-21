import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../controllers/product_detail_controller.dart';

class AddonChip extends StatelessWidget {
  const AddonChip({
    super.key,
    required this.addon,
    required this.isSelected,
    required this.isPulsing,
    required this.pulseController,
    required this.onTap,
  });

  final Addon addon;
  final bool isSelected;
  final bool isPulsing;
  final AnimationController pulseController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final pulseValue = isPulsing
            ? CurvedAnimation(parent: pulseController, curve: Curves.easeOut)
                .value
            : 0.0;
        final scale = 1 - (0.06 * pulseValue);
        final glowOpacity = isSelected ? 0.3 + 0.4 * pulseValue : 0.1;
        return Transform.scale(
          scale: scale,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      accentColor.withAlpha((glowOpacity * 255).round()),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? accentColor : baseColor.withAlpha(51),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: isSelected ? 0.85 : 0.25,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withAlpha(102),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Image.network(
                      addon.imageUrl,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Text(
                addon.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.black : baseColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '+\$${addon.price.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isSelected ? Colors.black87 : baseColor.withAlpha(179),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
