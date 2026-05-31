import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header_controller.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header_modes.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  static final HeaderController controller = HeaderController();

  const Header({
    super.key
  });

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

  @override
  void initState() {
    super.initState();
    Header.controller.addListener(mudarModo);
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
      height: headerExpandido ? 180 : (headerDesativado ? 0 : 140),

      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24)
        )
      ),
      
      child: SafeArea( 
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 400),

              width: headerExpandido ? 80 : 65,
              height: headerExpandido ? 80 : 65,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: AppColors.backgroundCreme
              ),

              child: Image.asset(
                "assets/images/Logo.png",
                fit: BoxFit.cover,
              ),
            ),
          )
        )
      ),
    );
  }

}