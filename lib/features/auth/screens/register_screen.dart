import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/auth/auth_step_header.dart';
import '../../../widgets/auth/auth_text_field.dart';
import '../../../widgets/auth/gradient_checkbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _agreed = false;

  bool get _nameValid => _nameCtrl.text.trim().length >= 2;
  bool get _emailValid =>
      RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(_emailCtrl.text.trim());
  bool get _passwordValid => _passwordCtrl.text.length >= 6;
  bool get _canSubmit => _nameValid && _emailValid && _passwordValid && _agreed;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_canSubmit) return;
    Navigator.pushNamed(context, AppRoutes.profileSetup);
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
              AuthStepHeader(currentStep: 1, totalSteps: 2),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create your account', style: AppTextStyles.title),
                      const SizedBox(height: 8),
                      Text(
                        'Join your team on TB Chat. It takes less than a minute.',
                        style: AppTextStyles.body.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 28),
                      // Full name
                      _NameField(controller: _nameCtrl, onChanged: (_) => setState(() {})),
                      const SizedBox(height: 20),
                      // Work email
                      AuthTextField(
                        label: 'Work email',
                        hint: 'niladri@company.com',
                        helperText: "We'll use this for account recovery only.",
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outline_rounded,
                            size: 20, color: AppColors.muted),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),
                      // Password
                      AuthTextField(
                        label: 'Password',
                        hint: 'Min. 6 characters',
                        controller: _passwordCtrl,
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline_rounded,
                            size: 20, color: AppColors.muted),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),
                      // Terms checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientCheckbox(
                            value: _agreed,
                            onChanged: (v) => setState(() => _agreed = v),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'I agree to the ',
                                style: AppTextStyles.body
                                    .copyWith(color: AppColors.muted),
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: AppTextStyles.body.copyWith(
                                        color: AppColors.indigo,
                                        fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()..onTap = () {},
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppTextStyles.body.copyWith(
                                        color: AppColors.indigo,
                                        fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()..onTap = () {},
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
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
                label: 'Create account',
                onPressed: _canSubmit ? _submit : null,
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: AppTextStyles.body.copyWith(color: AppColors.muted),
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: AppTextStyles.body.copyWith(
                          color: AppColors.indigo, fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, AppRoutes.signIn),
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

/// Name field with green checkmark suffix when valid.
class _NameField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const _NameField({required this.controller, required this.onChanged});

  bool get _valid => controller.text.trim().length >= 2;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: 'Full name',
      hint: 'Your name',
      controller: controller,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline_rounded,
          size: 20, color: AppColors.muted),
      suffixIcon: _valid
          ? const Icon(Icons.check_rounded, size: 20, color: AppColors.online)
          : null,
      onChanged: onChanged,
    );
  }
}
