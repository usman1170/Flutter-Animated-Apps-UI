import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bookings', style: AppTheme.displaySmall),
            const SizedBox(height: 16),
            const _MonthlyCalendar(),
            const SizedBox(height: 22),
            Text(
              'Your stays',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...controller.bookings.map(
              (booking) => _BookingCard(item: booking),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlyCalendar extends GetView<BookingsController> {
  const _MonthlyCalendar();

  @override
  Widget build(BuildContext context) {
    const weekDays = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -80) {
          controller.goToNextMonth();
        } else if (details.primaryVelocity! > 80) {
          controller.goToPreviousMonth();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.white.withAlpha(204),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Obx(() {
          final DateTime activeMonth = controller.visibleMonth.value;
          final List<DateTime?> monthDates = controller.monthDates;
          return Column(
            children: [
              Row(
                children: [
                  _MonthArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: controller.goToPreviousMonth,
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: Text(
                        _monthLabel(activeMonth),
                        key: ValueKey(
                          '${activeMonth.year}-${activeMonth.month}',
                        ),
                        textAlign: TextAlign.center,
                        style: AppTheme.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  _MonthArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: controller.goToNextMonth,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: weekDays
                    .map(
                      (day) => Expanded(
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: AppTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                itemCount: monthDates.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final DateTime? date = monthDates[index];
                  if (date == null) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: () => controller.selectDate(date),
                    child: _MonthDateCell(
                      label: '${date.day}',
                      isSelected: controller.isSelected(date),
                      isToday: controller.isToday(date),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white.withAlpha(220),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: AppColor.textPrimary),
        ),
      ),
    );
  }
}

class _MonthDateCell extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isToday;

  const _MonthDateCell({
    required this.label,
    required this.isSelected,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.primary : AppColor.white.withAlpha(235),
        borderRadius: BorderRadius.circular(12),
        border: isToday && !isSelected
            ? Border.all(color: AppColor.primary.withAlpha(130), width: 1.2)
            : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColor.primary.withAlpha(55),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ]
            : const [],
      ),
      child: Center(
        child: Text(
          label,
          style: AppTheme.titleSmall.copyWith(
            color: isSelected ? AppColor.white : AppColor.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

String _monthLabel(DateTime month) {
  const names = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${names[month.month - 1]} ${month.year}';
}

class _BookingCard extends StatelessWidget {
  final BookingItem item;

  const _BookingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isConfirmed = item.status == 'Confirmed';
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(222),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item.imageUrl,
              width: 84,
              height: 84,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.hotelName,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(item.location, style: AppTheme.bodySmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isConfirmed
                            ? AppColor.primary.withAlpha(35)
                            : Colors.orange.withAlpha(35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.status,
                        style: AppTheme.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isConfirmed
                              ? AppColor.primary
                              : const Color(0xFFB54708),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(item.dateLabel, style: AppTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
