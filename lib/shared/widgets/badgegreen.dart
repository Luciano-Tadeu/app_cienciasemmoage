import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgeGreen extends StatelessWidget {
  final String text;

  const BadgeGreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

      decoration: BoxDecoration(
        color: AppColors.secondary75,
        borderRadius: BorderRadius.circular(100)
      ),

      child: Text(
        text,
        style: GoogleFonts.nunito(
          textStyle: const TextStyle(
            color: AppColors.textLight,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        )
      )
    );
  }
}
