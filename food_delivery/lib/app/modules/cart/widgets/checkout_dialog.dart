import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../controllers/checkout_controller.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  late final CheckoutController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(CheckoutController(), tag: 'checkout_dialog');
  }

  @override
  void dispose() {
    Get.delete<CheckoutController>(tag: 'checkout_dialog');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          final isSuccess = _controller.stage.value == CheckoutStage.success;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: isSuccess
                    ? const Icon(Icons.check_circle,
                        color: Colors.greenAccent, size: 58)
                    : RotationTransition(
                        turns: Tween<double>(begin: -0.02, end: 0.02).animate(
                          CurvedAnimation(
                            parent: _controller.pulseController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.9, end: 1.05).animate(
                            CurvedAnimation(
                              parent: _controller.pulseController,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: const Icon(Icons.local_mall,
                              color: accentColor, size: 58),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess ? 'Order placed' : 'Placing your order',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isSuccess
                    ? 'Your feast is on the way.'
                    : 'Hang tight while we prep the kitchen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withAlpha(179),
                ),
              ),
              const SizedBox(height: 20),
              if (!isSuccess)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        value: value,
                        backgroundColor: Colors.white12,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    );
                  },
                ),
              if (isSuccess)
                ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Back to home'),
                ),
            ],
          );
        }),
      ),
    );
  }
}
