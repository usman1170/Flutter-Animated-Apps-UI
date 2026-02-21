import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_fonts.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/thermostat_painter.dart';
import 'package:gap/gap.dart';

class SmartDevicesGrid extends GetView<HomeController> {
  const SmartDevicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      children: [
        _buildLockCard(),
        _buildThermostatCard(),
        _buildVacuumCard(),
        _buildLeakCard(),
      ],
    );
  }

  Widget _buildLockCard() {
    return GlassCard(
      fallbackColor: AppColors.lockCard,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Smart door\nlock',
                  style: AppFonts.textStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              Obx(
                () => _buildToggle(
                  controller.isSmartLockOn.value,
                  controller.toggleSmartLock,
                ),
              ),
            ],
          ),
          Gap(8),
          Row(
            children: [
              const Icon(
                Icons.battery_3_bar,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '99%',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              _buildSmallIconButton(Icons.share_outlined),
              const Gap(8),
              _buildSmallIconButton(Icons.fingerprint, active: true),
              const Gap(8),
              _buildSmallIconButton(Icons.key),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThermostatCard() {
    return GlassCard(
      fallbackColor: AppColors.thermostatCard,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thermostat',
                style: AppFonts.textStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Obx(
                () => _buildToggle(
                  controller.isThermostatOn.value,
                  controller.toggleThermostat,
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              const Icon(
                Icons.thermostat,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '22°C',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Gap(4),
          Row(
            children: [
              const Icon(
                Icons.water_drop_outlined,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '78%',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 100,
              height: 50,
              child: CustomPaint(painter: ThermostatPainter(value: 0.7)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacuumCard() {
    return GlassCard(
      fallbackColor: AppColors.vacuumCard,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Smart vacuum\ncleaner',
                  style: AppFonts.textStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              Obx(
                () => _buildToggle(
                  controller.isVacuumOn.value,
                  controller.toggleVacuum,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '23 minutes left',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              const Icon(
                Icons.battery_2_bar,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '19%',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeakCard() {
    return GlassCard(
      fallbackColor: AppColors.leakCard,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Water leak\ndetector',
                  style: AppFonts.textStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              Obx(
                () => _buildToggle(
                  controller.isWaterLeakOn.value,
                  controller.toggleWaterLeak,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                'Normal',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              const Icon(
                Icons.battery_full,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const Gap(4),
              Text(
                '100%',
                style: AppFonts.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(bool value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: value
              ? AppColors.accentGreen
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.power_settings_new,
            size: 14,
            color: value ? AppColors.accentGreen : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallIconButton(IconData icon, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
