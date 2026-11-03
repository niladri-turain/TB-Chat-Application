import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/auth/auth_step_header.dart';
import '../../../widgets/auth/auth_text_field.dart';
import '../services/auth_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameCtrl = TextEditingController();
  final _designationCtrl = TextEditingController();
  String _status = 'Available';
  bool _loading = false;
  final _authService = AuthService();

  final List<String> _statusOptions = [
    'Available',
    'Busy',
    'In a meeting',
    'On leave',
    'Do not disturb',
  ];

  bool get _canContinue => _nameCtrl.text.trim().isNotEmpty;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _designationCtrl.dispose();
    super.dispose();
  }

  void _pickStatus(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _StatusPickerSheet(
        options: _statusOptions,
        selected: _status,
      ),
    );
    if (result != null) setState(() => _status = result);
  }

  Future<void> _continue() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null && _nameCtrl.text.trim().isNotEmpty) {
      setState(() => _loading = true);
      try {
        await _authService
            .saveProfile(
              uid: uid,
              displayName: _nameCtrl.text.trim(),
              designation: _designationCtrl.text.trim(),
              about: _status,
            )
            .timeout(const Duration(seconds: 10));
      } catch (_) {
        // non-blocking — navigate even if save fails/times out
      } finally {
        if (mounted) setState(() => _loading = false);
      }
    }
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.chats, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              AuthStepHeader(currentStep: 2, totalSteps: 2),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Set up your profile', style: AppTextStyles.title),
                      const SizedBox(height: 8),
                      Text(
                        'Help your teammates recognise you.',
                        style: AppTextStyles.body.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 28),
                      // Avatar picker
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.indigo.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.indigo.withValues(alpha: 0.3),
                                  width: 1.5,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_outline_rounded,
                                size: 44,
                                color: AppColors.indigo,
                              ),
                            ),
                            Positioned(
                              bottom: -4,
                              right: -4,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    gradient: AppColors.brandGradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Add a photo',
                          style: AppTextStyles.nameLabel
                              .copyWith(color: AppColors.indigo),
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Display name
                      AuthTextFieldWithCounter(
                        label: 'Display name',
                        controller: _nameCtrl,
                        maxLength: 40,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),
                      // Designation (optional)
                      AuthTextField(
                        label: 'Designation (optional)',
                        hint: 'e.g. Frontend Developer',
                        controller: _designationCtrl,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      // About / status dropdown
                      _StatusDropdown(
                        value: _status,
                        onTap: () => _pickStatus(context),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              // CTAs
              GradientButton(
                label: 'Continue',
                onPressed: _canContinue && !_loading ? _continue : null,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _loading ? null : _continue,
                child: Text(
                  "I'll do this later",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.indigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
        ),
        if (_loading)
          Container(
            color: Colors.black.withValues(alpha: 0.35),
            child: const Center(
              child: _SavingCard(),
            ),
          ),
      ],
    );
  }
}

class _SavingCard extends StatelessWidget {
  const _SavingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 16),
          Text('Saving your profile…',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Just a moment', style: AppTextStyles.meta),
        ],
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _StatusDropdown({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'About ',
            style: AppTextStyles.nameLabel,
            children: [
              TextSpan(
                text: '(optional)',
                style: AppTextStyles.meta,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: AppTextStyles.body),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 20, color: AppColors.muted),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusPickerSheet extends StatelessWidget {
  final List<String> options;
  final String selected;

  const _StatusPickerSheet({required this.options, required this.selected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          ...options.map(
            (o) => ListTile(
              title: Text(o, style: AppTextStyles.body),
              trailing: o == selected
                  ? const Icon(Icons.check_rounded,
                      color: AppColors.indigo, size: 20)
                  : null,
              onTap: () => Navigator.pop(context, o),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
