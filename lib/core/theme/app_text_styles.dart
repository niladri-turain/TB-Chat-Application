import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get title => GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 28,
        color: AppColors.ink,
      );

  static TextStyle get header => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColors.ink,
      );

  static TextStyle get nameLabel => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.ink,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: AppColors.ink,
      );

  static TextStyle get meta => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: AppColors.muted,
      );
}
