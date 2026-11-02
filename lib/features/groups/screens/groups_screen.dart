import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Groups')),
      body: const Center(
        child: Text('Groups Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
