import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/main_scaffold.dart';

void main() {
  runApp(const CienciaSemMoageApp());
}

class CienciaSemMoageApp extends StatelessWidget {
  const CienciaSemMoageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ciência Sem Moage',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      // APONTE PARA CÁ!
      home: const MainScaffold(), 
    );
  }
}