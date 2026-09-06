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
  static int actPage = 0;

  static final List<String> videoList = [];
  static final Set<String> loadedVideos = {};

  @override
  void initState() {
    super.initState();

    getVideos(false);
  }

  Future<int> manualVideoInsert(String videoId) async {
    final video = await YoutubeService().buscarVideo(videoId);

    if (video == null) return -1;

    if (loadedVideos.add(video.id)) {
      videoList.insert(actPage + 1, video.id);
      
      if (mounted) {setState(() {});}
      return actPage + 1;
    }

    return videoList.indexWhere((video) => video == videoId);
  }

  void getVideos(bool carregarMais) async {
    List<String> videos = await widget.youtubeService.listarVideos(carregarMais: carregarMais);

    if (!mounted) return;
    
    setState(() {
      for (final video in videos) {
        if (loadedVideos.add(video)) {
          videoList.add(video);
        }
      }
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
            getVideos(true);
          }
        },
        itemBuilder: (context, index) {
          final isNear = (index - actPage).abs() <= 1;
          return VideoPlayer(
            key: ValueKey(videoList[index]),
            videoId: videoList[index], 
            isPlaying: actPage == index,
            enabled: isNear,
          );
        },
      ),
    ); 
  }
}