import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Group Info')),
      body: const Center(
        child: Text('Group Info Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
