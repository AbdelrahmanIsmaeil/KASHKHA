import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.size,
    this.width = 76,
    this.height = 44,
    required this.onPressed,
    required this.isSelected,
  });
  final String size;
  final double width;
  final double height;
  final void Function()? onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          backgroundColor: isSelected
              ? AppColors.redCLR
              : AppColors.whiteCLR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          size,
          style: AppStyles.style16ExtraBold.copyWith(
            color: isSelected ? AppColors.whiteCLR : AppColors.blackCLR,
          ),
        ),
      ),
    );
  }
}