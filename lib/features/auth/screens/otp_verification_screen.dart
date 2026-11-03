import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/auth/auth_step_header.dart';
import '../../../widgets/auth/otp_input_row.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _otp = '';
  bool _hasError = false;
  int _attemptsLeft = 3;
  int _resendSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendSeconds = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds <= 0) {
        t.cancel();
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _verify() {
    // Simulate: any 6-digit OTP other than '123456' triggers error state
    if (_otp == '123456') {
      Navigator.pushNamed(context, AppRoutes.profileSetup);
    } else {
      setState(() {
        _hasError = true;
        _attemptsLeft = (_attemptsLeft - 1).clamp(0, 3);
      });
    }
  }

  String get _resendLabel {
    if (_resendSeconds > 0) {
      final m = (_resendSeconds ~/ 60).toString().padLeft(2, '0');
      final s = (_resendSeconds % 60).toString().padLeft(2, '0');
      return '$m:$s';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthBackButton(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      // Illustration
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.indigo.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: _PhoneIllustration(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Verify your number', style: AppTextStyles.title),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the 6-digit code sent to',
                        style: AppTextStyles.body.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          text: '+91 98765 43210',
                          style: AppTextStyles.nameLabel,
                          children: [
                            const TextSpan(text: ' · '),
                            TextSpan(
                              text: 'Change',
                              style: AppTextStyles.nameLabel.copyWith(
                                  color: AppColors.indigo),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.maybePop(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // OTP boxes
                      OtpInputRow(
                        hasError: _hasError,
                        onCompleted: (otp) => setState(() {
                          _otp = otp;
                          _hasError = false;
                        }),
                        onChanged: (otp) => setState(() {
                          _otp = otp;
                          if (_hasError && otp.length < 6) _hasError = false;
                        }),
                      ),
                      const SizedBox(height: 12),
                      // Error message
                      if (_hasError)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline_rounded,
                                size: 16, color: AppColors.error),
                            const SizedBox(width: 6),
                            Text(
                              'Incorrect code. $_attemptsLeft attempt${_attemptsLeft == 1 ? '' : 's'} left.',
                              style: AppTextStyles.body.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      // Resend countdown
                      Text.rich(
                        TextSpan(
                          text: "Didn't get it? Resend code in ",
                          style: AppTextStyles.body.copyWith(color: AppColors.muted),
                          children: [
                            if (_resendSeconds > 0)
                              TextSpan(
                                text: _resendLabel,
                                style: AppTextStyles.body.copyWith(
                                    color: AppColors.pink,
                                    fontWeight: FontWeight.w600),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Resend / Call me buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SecondaryActionButton(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: 'Resend SMS',
                            enabled: _resendSeconds == 0,
                            onTap: () {
                              if (_resendSeconds == 0) _startResendTimer();
                            },
                          ),
                          const SizedBox(width: 12),
                          _SecondaryActionButton(
                            icon: Icons.phone_outlined,
                            label: 'Call me',
                            enabled: _resendSeconds == 0,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              // Bottom CTA
              GradientButton(
                label: 'Verify & Continue',
                onPressed: _otp.length == 6 ? _verify : null,
              ),
              const SizedBox(height: 8),
              Text(
                'On Android the code is filled in automatically.',
                style: AppTextStyles.meta,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 16,
                color: enabled ? AppColors.muted : AppColors.line),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.meta.copyWith(
                color: enabled ? AppColors.muted : AppColors.line,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneIllustration extends StatelessWidget {
  const _PhoneIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 52,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.indigo, width: 2),
          ),
          child: Center(
            child: Container(
              width: 28,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.indigo.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            gradient: AppColors.brandGradient,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded,
              color: AppColors.white, size: 16),
        ),
      ],
    );
  }
}
