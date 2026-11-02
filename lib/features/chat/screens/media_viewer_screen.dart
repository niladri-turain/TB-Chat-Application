import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MediaViewerScreen extends StatelessWidget {
  const MediaViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.white,
        title: const Text('Media'),
      ),
      body: const Center(
        child: Text('Media Viewer Screen', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
