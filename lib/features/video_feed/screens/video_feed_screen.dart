import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_widget.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
import 'package:flutter/material.dart';

class VideoFeed extends StatefulWidget  {
  final PageController pageController;
  final YoutubeService youtubeService;

  const VideoFeed({
    super.key, 
    required this.pageController, 
    required this.youtubeService
  });
  
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
    List<String> videos = await widget.youtubeService.listarVideos();

    if (!mounted) return;
    
    setState(() {
      videoList = videos;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (videoList.isEmpty) {
      return Container(
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
      );
    }
    
    return Scaffold(
      body: PageView.builder(
        controller: widget.pageController,
        allowImplicitScrolling: true,
        scrollDirection: Axis.vertical,
        itemCount: videoList.length,
        onPageChanged: (idx) async {
          setState(() {
            actPage = idx;
          });

          if (idx == videoList.length - 1) {
            List<String> novosVideos = await widget.youtubeService.listarVideos(carregarMais: true);

            setState(() {
              videoList.addAll(novosVideos);
            });
          }

          
        },
        itemBuilder: (context, index) {
          final isNear = (index - actPage).abs() <= 1;
          return VideoPlayer(
            videoId: videoList[index], 
            isPlaying: actPage == index,
            enabled: isNear,
          );
        },
      ),
    ); 
  }
}