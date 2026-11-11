import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_colors.dart';
import 'app_toggle.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onTap;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(device.icon, size: 32, color: AppColors.textDark),
                const Spacer(),
                AppToggle(value: device.isOn, onChanged: onToggle),
              ],
            ),
            const Spacer(),
            Text(
              device.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              device.subtitle,
              style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
