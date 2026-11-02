import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const GradientButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: onPressed != null ? AppColors.brandGradient : null,
          color: onPressed == null ? AppColors.line : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.nameLabel.copyWith(
              color: onPressed != null ? AppColors.white : AppColors.muted,
            ),
          ),
        ),
      ),
    );
  }
}
