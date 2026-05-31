import 'dart:convert';

import 'package:app_cienciasemmoage/models/video.dart';
import 'package:http/http.dart' as http;

class YoutubeService {
  static const String playlist = "UUsS0P1wnlLt0hDanRq-SgzA";
  static const String key = "AIzaSyAG0i7XhnkUb6C3lFVkkS3aJAjeFffMIBk";

  Future<void> buscarPlaylist() async {
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/channels"
      "?part=contentDetails"
      "&forHandle=@cienciasemmoage"
      "&key=$key"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print(data);
    }
  }

  Future<List<String>> listarVideos() async {
    List<String> videos = [];
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/playlistItems"
      "?part=snippet"
      "&playlistId=$playlist"
      "&maxResults=5"
      "&key=$key",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var item in data["items"]) {
        videos.add(item["snippet"]["resourceId"]["videoId"]);
      }
    }
    
    return videos;
  }

  Future<Video?> buscarVideo(String videoId) async {
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/videos"
      "?part=snippet,contentDetails"
      "&id=$videoId"
      "&key=$key",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Video.fromJson(data["items"][0]);
    } else {
      return null;
    }
  }
}