import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgeGreenAnimated extends StatefulWidget {
  final String text;

  const BadgeGreenAnimated({super.key, required this.text});

  @override
  State<BadgeGreenAnimated> createState() => _BadgeGreenAnimatedState();
}

class _BadgeGreenAnimatedState extends State<BadgeGreenAnimated> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: _selected? AppColors.secondary : AppColors.secondary75,
          borderRadius: BorderRadius.circular(100),
        ),

        child: Text(
          widget.text,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: AppColors.textLight,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
