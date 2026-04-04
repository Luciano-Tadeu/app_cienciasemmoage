import 'package:flutter/material.dart';

class AppColors {
  // Construtor privado para evitar que a classe seja instanciada
  AppColors._();

  // Cores Principais
  static const Color backgroundCreme = Color(0xFFF6F0E6); // Fundo do app
  static const Color secondary = Color(0xFF9DCB3C);    // Barra inferior e botões
  static const Color secondary75 = Color(0xBF9DCB3C);    // Barra inferior e botões com 75% de opacidade
  static const Color tertiary = Color(0xFF8E422B);   // Header marrom e detalhes em destaque
  static const Color tertiary75 = Color(0xBF8E422B);   // Header marrom e detalhes em destaque com 75% de opacidade

  // Cores de Texto e Utilitários
  static const Color textDark = Color(0xFF6A3722);        // Textos de resumos nos cards
  static const Color cardplus = Color(0xFFECE5D2);        // Texto dentro do card de lançamento
  static const Color textLight = Color(0xFFFFFFFF);       // Textos dentro do header marrom e botões verdes
  static const Color shadowColor = Color(0x1A000000);     // Sombra leve para os cards (10% de opacidade)
}