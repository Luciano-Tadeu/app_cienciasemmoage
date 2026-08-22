import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_status_manager.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header.dart';
import 'package:app_cienciasemmoage/features/video_feed/screens/video_feed_screen.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_feed_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/search/screens/search_feed_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // 0 = Home, 1 = Vídeos, 2 = Pesquisa
  int _abaAtual = 0;
  final PageController controller = PageController();
  final List<Widget> _telas = [
    const HomeFeedScreen(),
    const VideoFeed(),
    const SearchFeedScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) => {
              setState(() {
                if (value != _abaAtual) return;
                Header.controller.trocarPagina(value);

                switch (value) {
                  case 0:
                    Header.controller.expandir();
                    VideoPlayerStatusManager.instance.pauseAllVideos();
                    break;
                  case 1:
                    Header.controller.desativar();
                    VideoPlayerStatusManager.instance.playCurrentVideo();
                    break;
                  case 2:
                    Header.controller.encolher();
                    VideoPlayerStatusManager.instance.pauseAllVideos();
                    break;
                }
              }),
            },
            children: [_telas[0], _telas[1], _telas[2]],
          ),
          Header(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
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
                                _abaAtual == 0
                                    ? -0.8
                                    : (_abaAtual == 1
                                          ? 0.0
                                          : 0.8), // Coord em X
                                0.0, // Coord em Y
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _construirBotao(Icons.home_rounded, 0),
                                  _construirBotao(
                                    Icons.play_circle_fill_rounded,
                                    1,
                                  ),
                                  _construirBotao(Icons.search_rounded, 2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirBotao(IconData icone, int indice) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _abaAtual = indice;
          controller.animateToPage(
            indice,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        behavior: HitTestBehavior.opaque,

        child: Center(child: Icon(icone, color: Colors.white, size: 32)),
      ),
    );
  }
}
