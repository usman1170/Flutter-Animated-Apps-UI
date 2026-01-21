import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../restaurant_list/data/restaurant_data.dart';
import '../controllers/cart_controller.dart';
import '../widgets/checkout_dialog.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Stack(
        children: [
          Obx(() {
            if (controller.items.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
              children: [
                _CartHeader(total: controller.subtotal),
                const SizedBox(height: 16),
                ...controller.items
                    .asMap()
                    .entries
                    .map(
                      (entry) => _CartItemTile(
                        product: entry.value,
                        onRemove: () => controller.remove(entry.value),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 16),
                _SummaryCard(subtotal: controller.subtotal),
              ],
            );
          }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _CheckoutBar(
              total: controller.subtotal,
              onPressed: () {
                Get.dialog(
                  CheckoutDialog(
                    onDone: () {
                      controller.clear();
                      Get.back();
                      Get.offAllNamed(Routes.RESTAURANT_LIST);
                    },
                  ),
                  barrierDismissible: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [accentColor.withAlpha(40), accentColor.withAlpha(10)],
        ),
        border: Border.all(color: accentColor.withAlpha(60)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_mall, color: accentColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ready to feast?',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withAlpha(204),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: total * 1.08),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Text(
                '\$${value.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.total, required this.onPressed});

  final double total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final totalValue = (total * 1.08).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(120),
            blurRadius: 18,
            offset: const Offset(0, -8),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withAlpha(179),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$$totalValue',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              'Place order',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.product, required this.onRemove});

  final Product product;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: accentColor),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.subtotal});

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    final total = subtotal * 1.08;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryRow(label: 'Subtotal', value: subtotal),
            const SizedBox(height: 8),
            _SummaryRow(label: 'Fees', value: subtotal * 0.08),
            const Divider(height: 24),
            _SummaryRow(label: 'Total', value: total, isTotal: true),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final double value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: isTotal ? 16 : 14,
      fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text('\$${value.toStringAsFixed(2)}', style: textStyle),
      ],
    );
  }
}
