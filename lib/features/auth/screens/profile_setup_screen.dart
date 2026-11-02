import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profile Setup')),
      body: const Center(
        child: Text('Profile Setup Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
