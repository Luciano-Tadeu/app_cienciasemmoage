import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/tag.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  final bool isPlaying;

  const VideoPlayer({
    super.key, 
    required this.videoId,
    required this.isPlaying
  });

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState();
  }
} 

class VideoPlayerState extends State<VideoPlayer> with AutomaticKeepAliveClientMixin {
  late final YoutubePlayerController _controller;
  Video? video;

  @override
  bool get wantKeepAlive => true;
  bool isReadyToPlay = false;

  @override
  void initState() {
    super.initState();
    carregarVideo();
  }

  void carregarVideo() async {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        mute: true,
        autoPlay: true,
      )
    );

    final result = await YoutubeService().buscarVideo(widget.videoId);

    if (!mounted) return;

    print(widget.videoId);

    setState(() {
      video = result;
    });
  }

  void tryPlayingVideo() {
    print("Tentou algo ${widget.isPlaying} ${isReadyToPlay}");
    if (widget.isPlaying && isReadyToPlay) {
      print("e conseguiu");
      _controller.play();
    } else {
      print("e falhou");
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
  
    print("widget atualizou");
    if (oldWidget.isPlaying != widget.isPlaying) tryPlayingVideo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: AppColors.tertiary,
      child: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 9 / 16,
              onReady: () {
                _controller.cue(widget.videoId);
                isReadyToPlay = true;
                tryPlayingVideo();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color.fromARGB(188, 142, 66, 43),
                    AppColors.tertiary
                  ],
                  stops: [
                    0.0,
                    0.3,
                    0.6
                  ]
                )
              ),
              width: double.infinity,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12, 
                    right: 12,
                    bottom: 80
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (video != null) ...[
                          Text(
                            video!.titulo, 
                            style: TextStyle(
                              fontSize: 26
                            )
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 6,
                            children: [
                              for (var tag in video!.tags) 
                                Tag(text: tag)
                            ],
                          ),
                          SizedBox(height: 12),
                          Text("Ler mais...")
                        ],
                      ]
                    ),
                  ) 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}