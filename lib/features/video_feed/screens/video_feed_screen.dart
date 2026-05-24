import 'package:flutter/material.dart';

class VideoFeed extends StatelessWidget {
  const VideoFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Center(child: Text("pagina 1"),),
          Center(child: Text("pagina 2"),),
        ],
      ),
    ); 
  }

}