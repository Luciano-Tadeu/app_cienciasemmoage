import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 1. O pacote foi importado aqui
import 'core/theme/app_theme.dart';
import 'features/navigation/main_scaffold.dart';

// 2. O main virou 'Future<void>' e 'async'
Future<void> main() async {
  // 3. Trava de segurança do Flutter para carregar dependências externas
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Carrega a sua chave de API escondida
  await dotenv.load(fileName: ".env");

  // 5. Roda o seu app
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