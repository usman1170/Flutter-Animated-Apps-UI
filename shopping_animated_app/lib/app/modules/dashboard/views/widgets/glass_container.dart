import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.opacity = 0.14,
    this.borderOpacity = 0.32,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double opacity;
  final double borderOpacity;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass.withOwnLayer(
      shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
      settings: LiquidGlassSettings(
        blur: 16,
        thickness: 12,
        glassColor: Colors.white.withAlpha((opacity * 255).round()),
        lightIntensity: 0.9,
        ambientStrength: 0.55,
        saturation: 1.2,
        chromaticAberration: 0.02,
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: gradient,
          border: Border.all(
            color: Colors.white.withAlpha((borderOpacity * 255).round()),
            width: 1,
          ),
        ),
        child: child,
      ),
    );
  }
}
