import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header_controller.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header_modes.dart';
import 'package:app_cienciasemmoage/shared/widgets/badgegreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';

class Header extends StatefulWidget {
  static final HeaderController controller = HeaderController();
  static final YoutubeService yt = YoutubeService();

  const Header({super.key});

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  bool headerExpandido = false;
  bool headerIconesExtras = false;
  bool headerDesativado = false;

  int animId = 0;

  String posts = "...";
  String seguidores = "...";

  @override
  void initState() {
    super.initState();
    Header.controller.addListener(mudarModo);
    _carregarEstatisticas();
  }

  Future<void> _carregarEstatisticas() async {
    final dados = await Header.yt.buscarEstatisticasCanal();

    setState(() {
      posts = formatarNumero(dados["videos"] ?? "0");
      seguidores = formatarNumero(dados["inscritos"] ?? "0");
    });
  }

  void mudarModo() {
    switch (Header.controller.modo) {
      case HeaderModes.EXPANDIDO:
        expandirHeader();
        break;
      case HeaderModes.ENCOLHIDO:
        encolherHeader();
        break;
      case HeaderModes.DESATIVADO:
        desativarHeader();
        break;
    }
  }

  void expandirHeader() async {
    int idAtual = ++animId;
    headerDesativado = false;

    setState(() => headerExpandido = true);
    await Future.delayed(Duration(milliseconds: 500));

    if (idAtual != animId) return;

    setState(() => headerIconesExtras = true);
  }

  void encolherHeader() async {
    int idAtual = ++animId;
    headerDesativado = false;

    setState(() => headerIconesExtras = false);
    await Future.delayed(Duration(milliseconds: 200));

    if (idAtual != animId) return;

    setState(() => headerExpandido = false);
  }

  void desativarHeader() async {
    setState(() {
      headerIconesExtras = false;
      headerExpandido = false;
      headerDesativado = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    Header.controller.removeListener(mudarModo);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 300),

      width: double.infinity,
      height: headerExpandido ? 200 : (headerDesativado ? 90 : 140),

      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),

      child: SafeArea(
        bottom: false,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 15,
            top: headerExpandido ? 50 : 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 400),

                width: headerExpandido ? 80 : 65,
                height: headerExpandido ? 80 : 65,

                decoration: headerDesativado
                    ? BoxDecoration()
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: AppColors.backgroundCreme,
                      ),

                child: headerDesativado
                    ? SizedBox()
                    : Image.asset("assets/images/Logo.png", fit: BoxFit.cover),
              ),

              AnimatedOpacity(
                opacity: headerDesativado || !headerIconesExtras ? 0.0 : 1.0,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeOut,

                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BadgeGreen(text: posts),

                        Text(
                          "Posts",
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 36),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BadgeGreen(text: seguidores),

                        Text(
                          "Seguidores",
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatarNumero(String numeroBruto) {
    int? numero = int.tryParse(numeroBruto);
    if (numero == null) return "0";

    if (numero >= 1000000) {
      double convertido = numero / 1000000;
      return "${convertido.toStringAsFixed(1).replaceAll('.0', '').replaceAll('.', ',')} mi";
    } else if (numero >= 1000) {
      double convertido = numero / 1000;
      return "${convertido.toStringAsFixed(1).replaceAll('.0', '').replaceAll('.', ',')} mil";
    } else {
      return numero.toString();
    }
  }
}
