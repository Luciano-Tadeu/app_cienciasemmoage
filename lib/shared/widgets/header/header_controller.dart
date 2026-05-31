import 'package:app_cienciasemmoage/shared/widgets/header/header_modes.dart';
import 'package:flutter/material.dart';

class HeaderController extends ChangeNotifier {
  HeaderModes modo = HeaderModes.EXPANDIDO;
  int paginaAtual = 0;

  void trocarPagina(int novaPagina) {
    paginaAtual = novaPagina;
    notifyListeners();
  }

  void desativar() {
    modo = HeaderModes.DESATIVADO;
    notifyListeners();
  }

  void encolher() {
    modo = HeaderModes.ENCOLHIDO;
    notifyListeners();
  }

  void expandir() {
    modo = HeaderModes.EXPANDIDO;
    notifyListeners();
  }
}