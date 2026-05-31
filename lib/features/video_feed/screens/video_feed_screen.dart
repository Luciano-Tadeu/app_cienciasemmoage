import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_widget.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
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
  int actPage = 0;

  final List<String> videoList = [
    "v3140NQVBXQ",
    "RwLHbJw7tLI"
  ];

  void printarVideos() async {
    print(await YoutubeService().listarVideos());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        scrollDirection: Axis.vertical,
        children: [
          for (int i = 0; i < videoList.length; i++) 
            VideoPlayer(videoId: videoList[i], isPlaying: actPage == i)
        ],
        onPageChanged: (idx) {
          setState(() {
            actPage = idx;
          });
          printarVideos();
          print("trocou para ${actPage}");
        },
      ),
    ); 
  }
}