import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Checkbox with a gradient fill when checked (matches design).
class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: value ? AppColors.brandGradient : null,
          color: value ? null : AppColors.white,
          borderRadius: BorderRadius.circular(6),
          border: value ? null : Border.all(color: AppColors.line, width: 1.5),
        ),
        child: value
            ? const Icon(Icons.check_rounded, color: AppColors.white, size: 16)
            : null,
      ),
    );
  }
}
