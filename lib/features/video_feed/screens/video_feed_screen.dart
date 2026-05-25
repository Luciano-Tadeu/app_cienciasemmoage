import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_widget.dart';
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
          VideoPlayer(videoId: "v3140NQVBXQ",),
          VideoPlayer(videoId: "RwLHbJw7tLI",),
        ],
      ),
    ); 
  }
}