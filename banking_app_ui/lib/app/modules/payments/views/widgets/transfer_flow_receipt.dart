import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import 'transfer_flow_models.dart';
import 'transfer_flow_surface.dart';

class TransferReceiptCard extends StatelessWidget {
  final TransferFlowType type;
  final String amount;
  final String fromLabel;
  final String toLabel;
  final String reference;
  final String bank;

  const TransferReceiptCard({
    super.key,
    required this.type,
    required this.amount,
    required this.fromLabel,
    required this.toLabel,
    required this.reference,
    required this.bank,
  });

  @override
  Widget build(BuildContext context) {
    final accent = type.accent;
    return TransferGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColor.blueSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 70 : 88),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.elevatedSurface(context),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withAlpha(60),
                        blurRadius: 22,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(LucideIcons.badgeCheck, color: accent, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer Successful',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primaryLabel(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Receipt ready for sharing and review.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryLabel(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${amount.isEmpty ? '0.00' : amount}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _PartyTile(
                  title: 'From',
                  value: fromLabel,
                  accent: accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PartyTile(title: 'To', value: toLabel, accent: accent),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 14,
            width: double.infinity,
            child: CustomPaint(
              painter: _DashPainter(color: AppColor.dividerColor(context)),
            ),
          ),
          const SizedBox(height: 14),
          _ReceiptRow(label: 'Bank', value: bank),
          const SizedBox(height: 12),
          _ReceiptRow(label: 'Route', value: type.title),
          const SizedBox(height: 12),
          _ReceiptRow(label: 'Reference', value: reference),
          const SizedBox(height: 12),
          _ReceiptRow(label: 'Status', value: 'Completed • Instant settlement'),
          const SizedBox(height: 12),
          _ReceiptRow(
            label: 'Receipt ID',
            value:
                'UBL-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
          ),
        ],
      ),
    );
  }
}

class _PartyTile extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;

  const _PartyTile({
    required this.title,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withAlpha(54)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReceiptRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 84,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.secondaryLabel(context),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;

  const _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;
    double start = 0;
    while (start < size.width) {
      canvas.drawLine(
        Offset(start, size.height / 2),
        Offset(math.min(start + 8, size.width), size.height / 2),
        paint,
      );
      start += 13;
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter oldDelegate) =>
      oldDelegate.color != color;
}
