import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/auth/auth_step_header.dart';
import '../../../widgets/auth/phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneCtrl = TextEditingController();
  bool _canSubmit = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_canSubmit) return;
    Navigator.pushNamed(context, AppRoutes.otpVerification);
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
                      const SizedBox(height: 32),
                      // TB Chat logo
                      const _TbChatLogo(),
                      const SizedBox(height: 28),
                      Text('Welcome back', style: AppTextStyles.title),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in with the mobile number\nregistered with your team.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 32),
                      PhoneField(
                        controller: _phoneCtrl,
                        showClearButton: true,
                        onChanged: (_, number) =>
                            setState(() => _canSubmit = number.length >= 8),
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        label: 'Send code',
                        onPressed: _canSubmit ? _submit : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shield_outlined,
                              size: 16, color: AppColors.muted),
                          const SizedBox(width: 6),
                          Text('Secure access to your team workspace',
                              style: AppTextStyles.meta),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Info card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.line.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.line,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.info_outline_rounded,
                                  size: 18, color: AppColors.muted),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Changed your number? Ask your workspace admin to update it before signing in.',
                                style: AppTextStyles.body
                                    .copyWith(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom link
              Text.rich(
                TextSpan(
                  text: 'New to TB Chat? ',
                  style: AppTextStyles.body.copyWith(color: AppColors.muted),
                  children: [
                    TextSpan(
                      text: 'Create an account',
                      style: AppTextStyles.body.copyWith(
                          color: AppColors.indigo, fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, AppRoutes.register),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _TbChatLogo extends StatelessWidget {
  const _TbChatLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LogoTile(letter: 'T', gradient: AppColors.brandGradient),
            const SizedBox(width: 4),
            _LogoTile(letter: 'B', gradient: const LinearGradient(
              colors: [AppColors.indigo, AppColors.indigo],
            )),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'CHAT',
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class _LogoTile extends StatelessWidget {
  final String letter;
  final LinearGradient gradient;

  const _LogoTile({required this.letter, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
