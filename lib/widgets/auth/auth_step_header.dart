import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Top bar with back button, optional step label, and segmented progress bar.
class AuthStepHeader extends StatelessWidget {
  final int currentStep; // 1-based
  final int totalSteps;
  final VoidCallback? onBack;

  const AuthStepHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BackButton(onTap: onBack ?? () => Navigator.maybePop(context)),
            Text(
              'Step $currentStep of $totalSteps',
              style: AppTextStyles.meta.copyWith(color: AppColors.muted),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ProgressBar(current: currentStep, total: totalSteps),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.line,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.chevron_left_rounded, color: AppColors.ink, size: 24),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final filled = i < current;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              gradient: filled ? AppColors.brandGradient : null,
              color: filled ? null : AppColors.line,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

/// Simple back button without step info (used on sign-in and OTP screens).
class AuthBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AuthBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.line,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.chevron_left_rounded, color: AppColors.ink, size: 24),
      ),
    );
  }
}
