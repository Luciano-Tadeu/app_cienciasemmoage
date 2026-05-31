import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/tag.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header.dart';
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
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        mute: true,
        autoPlay: false,
        hideControls: true,
        disableDragSeek: true,
        hideThumbnail: true
      )
    );

    carregarVideo();
  }

  void carregarVideo() async {
    if (video != null) return;

    final result = await YoutubeService().buscarVideo(widget.videoId);

    if (!mounted) return;

    setState(() {
      video = result;
    });
  }

  void tryPlayingVideo() {
    if (widget.isPlaying && isReadyToPlay) {
      _controller.play();
    } else {
      _controller.seekTo(Duration.zero);
      _controller.pause();
    }
  }

  void changeVideoState() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
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
  
    if (oldWidget.isPlaying != widget.isPlaying) tryPlayingVideo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: AppColors.tertiary,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black
          ),
          GestureDetector(
            onTap: () {
              changeVideoState();
            },
            child: Center(
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 9 / 20,
                showVideoProgressIndicator: false,
                onEnded: (e) {
                  _controller.seekTo(Duration.zero);
                  _controller.play();
                },
                onReady: () { 
                  isReadyToPlay = true;
                  tryPlayingVideo();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
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