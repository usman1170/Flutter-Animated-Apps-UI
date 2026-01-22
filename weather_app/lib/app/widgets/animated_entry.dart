import 'package:flutter/material.dart';

class AnimatedEntry extends StatefulWidget {
  const AnimatedEntry({
    super.key,
    required this.child,
    this.index = 0,
    this.delayStep = const Duration(milliseconds: 90),
    this.offset = const Offset(0, 0.12),
  });

  final Widget child;
  final int index;
  final Duration delayStep;
  final Offset offset;

  @override
  State<AnimatedEntry> createState() => _AnimatedEntryState();
}

class _AnimatedEntryState extends State<AnimatedEntry> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delayStep * widget.index, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      opacity: _visible ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        offset: _visible ? Offset.zero : widget.offset,
        child: widget.child,
      ),
    );
  }
}
