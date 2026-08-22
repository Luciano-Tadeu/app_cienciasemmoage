import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:http/http.dart' as http;

class YoutubeService {
  static const String playlist = "UUsS0P1wnlLt0hDanRq-SgzA";
  static String get key => dotenv.env['YOUTUBE_API_KEY'] ?? '';

  Future<void> buscarPlaylist() async {
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/channels"
      "?part=contentDetails"
      "&forHandle=@cienciasemmoage"
      "&key=$key",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print(data);
    }
  }

  String? _nextPageToken;


  Future<List<String>> listarVideos({bool carregarMais = false}) async {
    if (carregarMais && _nextPageToken == null) return [];

    List<String> videos = [];
    String urlString =
        "https://www.googleapis.com/youtube/v3/playlistItems"
        "?part=snippet"
        "&playlistId=$playlist"
        "&maxResults=5"
        "&key=$key";

    if (carregarMais && _nextPageToken != null) {
      urlString += "&pageToken=$_nextPageToken";
    }

    final response = await http.get(Uri.parse(urlString));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      _nextPageToken = data["nextPageToken"];

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

  Future<Map<String, String>> buscarEstatisticasCanal() async {
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/channels"
      "?part=statistics"
      "&forHandle=@cienciasemmoage"
      "&key=$key"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["items"] != null && data["items"].isNotEmpty) {
        final stats = data["items"][0]["statistics"];
        
        return {
          "inscritos": stats["subscriberCount"] ?? "0",
          "videos": stats["videoCount"] ?? "0",
        };
      }
    }

    return {"inscritos": "0", "videos": "0"};
  }
}
