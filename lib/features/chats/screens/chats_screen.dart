import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Chats')),
      body: const Center(
        child: Text('Chats Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
