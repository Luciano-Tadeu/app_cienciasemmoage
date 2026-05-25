import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;

  const VideoPlayer({
    super.key, 
    required this.videoId
  });

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState();
  }
} 

class VideoPlayerState extends State<VideoPlayer> with AutomaticKeepAliveClientMixin {
  Video? video;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    carregarVideo();
  }


  void carregarVideo() async {
    final result = await YoutubeService().buscarVideo(widget.videoId);

    if (!mounted) return;

    print(widget.videoId);

    setState(() {
      video = result;
    });

    print(video!.titulo);
    print(video!.tags);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // YoutubePlayer(controller: _controller,),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, const Color.fromARGB(104, 142, 66, 43), const Color.fromARGB(220, 142, 66, 43), AppColors.tertiary]
              )
            ),
            width: double.infinity,
            height: 250,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (video != null) ...[
                      Text(
                        video!.titulo, 
                        style: TextStyle(
                          fontSize: 26
                        )
                      ),
                      Text(video!.tags.toString()),
                      Text("Ler mais...")
                    ],
                  ]
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}