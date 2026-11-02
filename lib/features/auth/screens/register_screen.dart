import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Register')),
      body: const Center(
        child: Text('Register Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
