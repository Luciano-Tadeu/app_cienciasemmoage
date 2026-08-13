import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_white_card.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_new_card.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 220, left: 16, right: 16, bottom: 100),
      children: const [
        HomeNewCard(
          title: 'Caravelas e água viva: Diferenças e curiosidades',
          section: 'Zoologia',
          time: '2 min',
          imageUrl: 'https://i.pinimg.com/736x/98/f8/b6/98f8b6ebc4120457fcb4bbaa3fa93d1f.jpg',
        ),
        SizedBox(height: 16),
        HomeWhiteCard(
          title: "Teste",
          desc: "Teste",
          section: "Teste",
          time: "Teste",
        ),
        SizedBox(height: 16),
        HomeWhiteCard(
          title: "Teste",
          desc: "Teste",
          section: "Teste",
          time: "Teste",
        ),
        SizedBox(height: 16),
        HomeWhiteCard(
          title: "Teste",
          desc: "Teste",
          section: "Teste",
          time: "Teste",
        ),
        SizedBox(height: 16),
        HomeWhiteCard(
          title: "Teste",
          desc: "Teste",
          section: "Teste",
          time: "Teste",
        ),
      ],
    );
  }
}
