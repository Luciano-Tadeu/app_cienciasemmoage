import 'package:app_cienciasemmoage/features/video_feed/widgets/video_player_status.dart';
import 'package:flutter/material.dart';

class VideoPlayerStatusManager extends ChangeNotifier {
  static final VideoPlayerStatusManager instance = VideoPlayerStatusManager._();
  VideoPlayerStatusManager._();

  VideoPlayerStatus status = VideoPlayerStatus.PAUSED;

  void pauseAllVideos() {
    status = VideoPlayerStatus.PAUSED;
    notifyListeners();
  }

  void playCurrentVideo() {
    status = VideoPlayerStatus.PLAYING;
    notifyListeners();
  }
}