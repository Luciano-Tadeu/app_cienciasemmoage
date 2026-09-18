import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNewCard extends StatelessWidget {
  final String title, section, time, imageUrl, videoUrl;
  final void Function(String) playNewVideo;

  const HomeNewCard({
    super.key,
    required this.title,
    required this.section,
    required this.time,
    required this.imageUrl,
    required this.videoUrl,
    required this.playNewVideo
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.textDark, // Funciona como fallback se a imagem demorar a carregar
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // --- CAMADA 1: Imagem ---
            Positioned.fill(
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            
            // --- CAMADA 2: Gradiente Escuro ---
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColors.tertiary, Colors.transparent],
                    stops: const [0.32, 1.0],
                  ),
                ),
              ),
            ),
            
            // --- CAMADA 3: Conteúdo (Textos) ---
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 116,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Lançamento da Semana",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunito(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunito(
                      color: AppColors.textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _construirTag(section),
                      const SizedBox(width: 8),
                      _construirTag(
                        time,
                        icone: Icons.access_time_filled_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- CAMADA 4: O CLIQUE (Fica por cima de tudo) ---
            Positioned.fill(
              child: Material(
                color: Colors.transparent, // Transparente para a imagem aparecer!
                child: InkWell(
                  splashColor: Colors.black.withValues(alpha: 0.1),
                  highlightColor: Colors.black.withValues(alpha: 0.05),
                  onTap: () {
                    print("CLICOU NO CARD: $title");
                    playNewVideo(videoUrl);
                  },
                ),
              ),
            ),
            
          ],
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
