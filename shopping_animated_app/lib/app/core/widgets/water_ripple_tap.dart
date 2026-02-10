import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WaterRippleTap extends StatefulWidget {
  const WaterRippleTap({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 850),
    this.amplitude = 0.09,
    this.frequency = 22.0,
    this.decay = 6.0,
  });

  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final double amplitude;
  final double frequency;
  final double decay;

  @override
  State<WaterRippleTap> createState() => _WaterRippleTapState();
}

class _WaterRippleTapState extends State<WaterRippleTap>
    with SingleTickerProviderStateMixin {
  final GlobalKey _boundaryKey = GlobalKey();
  ui.Image? _snapshot;
  Offset _center = Offset.zero;
  late final AnimationController _controller;
  late Future<ui.FragmentProgram> _program;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _snapshot = null);
        }
      });
    _program = ui.FragmentProgram.fromAsset('shaders/water_ripple.frag');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _captureAndAnimate(TapDownDetails details) async {
    if (_isCapturing) return;
    _isCapturing = true;
    try {
      final box = _boundaryKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null) return;
      final local = box.globalToLocal(details.globalPosition);
      _center = local;

      final boundary = _boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return;
      await WidgetsBinding.instance.endOfFrame;
      final pixelRatio = View.of(context).devicePixelRatio;
      final image = await boundary.toImage(pixelRatio: pixelRatio);
      if (!mounted) return;
      setState(() => _snapshot = image);
      _controller.forward(from: 0);
    } finally {
      _isCapturing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _boundaryKey,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) => _captureAndAnimate(details),
        onTap: widget.onTap,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            widget.child,
            if (_snapshot != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return FutureBuilder<ui.FragmentProgram>(
                        future: _program,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox.shrink();
                          final shader = snapshot.data!.fragmentShader();
                          return SizedBox.expand(
                            child: CustomPaint(
                              painter: _RipplePainter(
                                shader: shader,
                                image: _snapshot!,
                                center: _center,
                                time: _controller.value,
                                amplitude: widget.amplitude,
                                frequency: widget.frequency,
                                decay: widget.decay,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  _RipplePainter({
    required this.shader,
    required this.image,
    required this.center,
    required this.time,
    required this.amplitude,
    required this.frequency,
    required this.decay,
  });

  final ui.FragmentShader shader;
  final ui.Image image;
  final Offset center;
  final double time;
  final double amplitude;
  final double frequency;
  final double decay;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setImageSampler(0, image);
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, center.dx);
    shader.setFloat(3, center.dy);
    shader.setFloat(4, time);
    shader.setFloat(5, amplitude);
    shader.setFloat(6, frequency);
    shader.setFloat(7, decay);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.image != image;
  }
}
