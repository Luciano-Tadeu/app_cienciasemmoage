import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWhiteCard extends StatelessWidget {
  final String title, desc, section, time;

  const HomeWhiteCard({super.key, required this.title, required this.desc, required this.section, required this.time});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.textLight,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.black.withValues(alpha: 0.1),
        highlightColor: Colors.black.withValues(alpha: 0.05),
        onTap: (){
          print("CLICOU NO CARD: $title");
          //TODO: Redirecionar para o vídeo
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
        
              Text(
                desc,
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  color: AppColors.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _construirTag(section),
                  const SizedBox(width: 8),
                  _construirTag(time, icone: Icons.access_time_filled_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirTag(String texto, {IconData? icone}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardplus,
        borderRadius: BorderRadius.circular(999),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icone != null) ...[
            Icon(icone, size: 14, color: AppColors.textDark),
            const SizedBox(width: 4),
          ],

          Text(
            texto,
            style: GoogleFonts.nunito(
              color: AppColors.textDark,
              fontSize: 10.53,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
