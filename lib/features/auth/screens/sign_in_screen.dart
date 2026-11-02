import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Sign In')),
      body: const Center(
        child: Text('Sign In Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
