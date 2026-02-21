import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_fonts.dart';
import 'package:gap/gap.dart';

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&h=100&fit=crop',
                  ),
                ),
                const Gap(12),
                Text(
                  "Sia's home",
                  style: AppFonts.heading.copyWith(fontSize: 20),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.accentRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(24),
        SizedBox(
          height: 40,
          child: Obx(() {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final isSelected =
                    controller.currentCategoryIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.currentCategoryIndex.value = index,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.categories[index],
                      style: AppFonts.textStyle.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.secondaryText,
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
