import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_colors.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final bool selected;
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: selected ? AppColors.mainGradient : null,
          color: selected ? null : AppColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room.name,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : AppColors.textGrey,
              ),
            ),
            const Spacer(),
            Center(
              child: Icon(
                room.icon,
                size: 44,
                color: selected ? Colors.white : AppColors.textDark,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
