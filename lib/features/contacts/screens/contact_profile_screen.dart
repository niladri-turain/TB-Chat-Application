import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ContactProfileScreen extends StatelessWidget {
  const ContactProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Contact Profile')),
      body: const Center(
        child: Text('Contact Profile Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
