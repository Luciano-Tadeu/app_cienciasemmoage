import 'package:flutter/material.dart';

class VideoFeed extends StatefulWidget  {
  const VideoFeed({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return VideoFeedState();
  }

}

class VideoFeedState extends State<VideoFeed> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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