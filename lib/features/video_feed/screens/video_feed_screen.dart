import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
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

  List<String> videoList = [];

  @override
  void initState() {
    super.initState();

    getVideos();
  }

  void getVideos() async {
    List<String> videos = await YoutubeService().listarVideos();
    
    setState(() {
      videoList = videos;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        scrollDirection: Axis.vertical,
        children: [
          if (videoList.isNotEmpty) 
            for (int i = 0; i < 3; i++) 
              VideoPlayer(videoId: videoList[i], isPlaying: actPage == i)
          else 
            Container(
              color: Colors.black,
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: AppColors.tertiary,
                  ),
                ),
              ),
            )
        ],
        onPageChanged: (idx) {
          setState(() {
            actPage = idx;
          });
        },
      ),
    ); 
  }
}