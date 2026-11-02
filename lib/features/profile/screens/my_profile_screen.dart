import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('My Profile')),
      body: const Center(
        child: Text('My Profile Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
