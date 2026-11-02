import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('New Chat')),
      body: const Center(
        child: Text('New Chat Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
