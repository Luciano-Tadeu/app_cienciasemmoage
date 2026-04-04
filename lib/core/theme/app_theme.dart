import 'package:flutter/material.dart'; 
import 'app_colors.dart';

class AppTheme {
  
  AppTheme._();


  static ThemeData get lightTheme {
    return ThemeData(
      
      primaryColor: AppColors.tertiary,
      scaffoldBackgroundColor: AppColors.backgroundCreme,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.tertiary,
        elevation: 0,
      ),
      
      // (Futuro): Aqui depois podemos adicionar regras para botões (ElevatedButtonTheme) ou textos (TextTheme).

    );
  }
}