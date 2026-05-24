import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final int paginaAtual;

  const Header({
    super.key,
    required this.paginaAtual
  });

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  bool headerExpandido = false;
  bool headerIconesExtras = false;

  int animId = 0;

  @override
  void didUpdateWidget(covariant Header oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.paginaAtual != widget.paginaAtual) {
      if (widget.paginaAtual == 0) {
        expandirHeader();
      } else {
        encolherHeader();
      }
    }
  }

  void expandirHeader() async {
    int idAtual = ++animId;

    setState(() => headerExpandido = true);
    await Future.delayed(Duration(milliseconds: 500));

    if (idAtual != animId) return;

    setState(() => headerIconesExtras = true);
  }

  void encolherHeader() async {
    int idAtual = ++animId;
    
    setState(() => headerIconesExtras = false);
    await Future.delayed(Duration(milliseconds: 400));

    if (idAtual != animId) return;
    
    setState(() => headerExpandido = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: headerExpandido ? 180 : 140,
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24)
        )
      ),
      child: SafeArea( 
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
                "assets/images/Logo.png"
              ),
            ),
          )
        )
      ),
    );
  }

}