import 'package:app_cienciasemmoage/features/video_feed/screens/video_feed_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MainScaffold extends StatefulWidget {

  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  
  // 0 = Home, 1 = Vídeos, 2 = Pesquisa
  int _abaAtual = 0;

  final List<Widget> _telas = [
    const Center(child: Text('Tela 1: Home (Feed de Categorias)', style: TextStyle(fontSize: 20))),
    const VideoFeed(),
    const Center(child: Text('Tela 3: Pesquisa (Descobrir)', style: TextStyle(fontSize: 20))),
  ];


  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _telas[_abaAtual],
      bottomNavigationBar: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 48,
                    width: 224,
                    color: AppColors.secondary,
                
                    child: Stack(
                      children: [
                
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: Alignment(
                            _abaAtual == 0? -0.8 : (_abaAtual == 1? 0.0 : 0.8), // Coord em X
                            0.0 // Coord em Y
                          ),
                
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: AppColors.tertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                
                        Positioned.fill(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _construirBotao(Icons.home_rounded, 0),
                              _construirBotao(Icons.play_circle_fill_rounded, 1),
                              _construirBotao(Icons.search_rounded, 2),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _construirBotao(IconData icone, int indice) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _abaAtual = indice),
        behavior: HitTestBehavior.opaque,
          
          child: Center(
            child: Icon(
              icone,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
    );
  }
}