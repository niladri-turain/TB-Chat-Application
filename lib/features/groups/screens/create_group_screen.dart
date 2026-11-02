import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Create Group')),
      body: const Center(
        child: Text('Create Group Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
