import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Contacts')),
      body: const Center(
        child: Text('Contacts Screen', style: TextStyle(color: AppColors.ink)),
      ),
    );
  }
}
