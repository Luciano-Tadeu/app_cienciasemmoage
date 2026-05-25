class Video {
  final String titulo;
  final String thumb;
  final List<dynamic> tags;
  final String id;

  Video({
    required this.titulo,
    required this.thumb,
    required this.tags,
    required this.id
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      titulo: json["snippet"]["title"],
      thumb: json["snippet"]
          ["thumbnails"]
          ["high"]
          ["url"],
      tags: json["snippet"]["tags"],
      id: json["id"]
    );
  }
}