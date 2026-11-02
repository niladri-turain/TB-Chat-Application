import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double size;
  final bool showOnline;

  const AppAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 44,
    this.showOnline = false,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.brandGradient,
            image: imageUrl != null
                ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                : null,
          ),
          child: imageUrl == null
              ? Center(
                  child: Text(
                    _initials,
                    style: AppTextStyles.nameLabel.copyWith(
                      color: AppColors.white,
                      fontSize: size * 0.35,
                    ),
                  ),
                )
              : null,
        ),
        if (showOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
