import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TransferFormTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const TransferFormTitle({
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
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColor.primaryLabel(context),
          ),
        ),
        const SizedBox(height: 6),
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

class TransferFormLabel extends StatelessWidget {
  final String text;

  const TransferFormLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColor.primaryLabel(context),
      ),
    );
  }
}

class TransferFormDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const TransferFormDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.secondaryLabel(context),
            ),
          ),
        ),
        const SizedBox(width: 10),
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
