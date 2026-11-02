import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('OTP Verification')),
      body: const Center(
        child: Text('OTP Verification Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
