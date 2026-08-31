import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_cienciasemmoage/features/search/screens/badge_green_animated.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_white_card.dart';

class SearchFeedScreen extends StatelessWidget {
  final void Function(int) pageChanger;
  final void Function(int) playNewVideo;

  const SearchFeedScreen({
    super.key, 
    required this.pageChanger,
    required this.playNewVideo
    });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100, top: 156), 
      children: [
        SizedBox(
          height: 45,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    pageChanger(1);
                    playNewVideo(2);
                  }
                , child: Text("teste")),
                BadgeGreenAnimated(text: "Teste"),
                SizedBox(width: 12),
                BadgeGreenAnimated(text: "Física"),
                SizedBox(width: 12),
                BadgeGreenAnimated(text: "Biologia"),
                SizedBox(width: 12),
                BadgeGreenAnimated(text: "Matemática"),
                SizedBox(width: 12),
                BadgeGreenAnimated(text: "Astronomia"),
                SizedBox(width: 12),
                BadgeGreenAnimated(text: "Geografia"),
              ],
            ),
          ),
        ),
        
      ]
    );
  }
}
