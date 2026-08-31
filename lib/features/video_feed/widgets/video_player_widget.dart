import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/tag.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_status.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_status_manager.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header.dart';
import 'package:app_cienciasemmoage/shared/widgets/header/header_controller.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  final bool isPlaying;
  final bool enabled;

  const VideoPlayer({
    super.key, 
    required this.videoId,
    required this.isPlaying,
    required this.enabled
  });

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState();
  }
} 

class VideoPlayerState extends State<VideoPlayer> with AutomaticKeepAliveClientMixin {
  YoutubePlayerController? _controller;
  bool hidingHUD = false;
  Video? video;

  @override
  bool get wantKeepAlive => true;
  bool isReadyToPlay = false;

  @override
  void initState() {
    super.initState();

    enableController();
    carregarVideo();
  }

  void enableController() {
    VideoPlayerStatusManager.instance.addListener(videoStatusChanger);
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

    setState(() {});
  }

  void disableController() {
    final controller = _controller;

    if (controller == null) return;

    controller.dispose();

    setState(() {
      _controller = null;
      isReadyToPlay = false;
    });
  }

  void videoStatusChanger() {
    final controller = _controller;

    if (controller == null) {
      return;
    }

    switch (VideoPlayerStatusManager.instance.status) {
      case VideoPlayerStatus.PAUSED:
        if (controller.value.isPlaying) {
          forceReset();
        }
        break;
      case VideoPlayerStatus.PLAYING:
        tryPlayingVideo();
        break;
    }
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
    final controller = _controller;

    if (controller == null) {
      return;
    }

    if (widget.isPlaying && isReadyToPlay) {
      controller.play();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Header.controller.desativar();
        }
      });
      setState(() {hidingHUD = true;});
    } else {
      forceReset();
    }
  }

  void forceReset() {
    final controller = _controller;

    if (controller == null) return;

    controller.seekTo(Duration.zero);
    controller.pause();
    setState(() {hidingHUD = false;});
  }

  void onTapChangeVideoState() {
    final controller = _controller;

    if (controller == null) return;

    if (controller.value.isPlaying) {
      controller.pause();
      setState(() {hidingHUD = false;});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Header.controller.encolher();
        }
      });
    } else {
      controller.play();
      setState(() {hidingHUD = true;});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Header.controller.desativar();
        }
      });
    }
  }

  @override
  void dispose() {
    VideoPlayerStatusManager.instance.removeListener(videoStatusChanger);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
  
    if (oldWidget.isPlaying != widget.isPlaying) tryPlayingVideo();

    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        enableController();
      } else {
        disableController();
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (!widget.enabled || controller == null) return Text("nada");

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
              onTapChangeVideoState();
            },
            child: Center(
              child: YoutubePlayer(
                controller: controller,
                aspectRatio: 9 / 20,
                showVideoProgressIndicator: false,
                onEnded: (e) {
                  controller.seekTo(Duration.zero);
                  controller.play();
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
                    child: AnimatedSize(
                      clipBehavior: Clip.none,
                      duration: Duration(milliseconds: 200),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (video != null) ...[
                            Text(
                              video!.titulo, 
                              style: TextStyle(
                                fontSize: 24
                              )
                            ),
                            SizedBox(height: 8),
                            AnimatedAlign(
                              alignment: Alignment.centerLeft, 
                              duration: Duration(milliseconds: 250),
                              heightFactor: !hidingHUD ? 1 : 0,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: !hidingHUD ? 1 : 0,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 6,
                                  children: [
                                    for (var tag in video!.tags) 
                                      Tag(text: tag)
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 12),
                            // Text("Ler mais...")
                          ],
                        ]
                      ),
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