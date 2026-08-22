class Video {
  final String id;
  final String titulo;
  final String thumb;
  final String descricao;
  final String tempo;
  final List<String> tags;

  Video({
    required this.id,
    required this.titulo,
    required this.thumb,
    required this.descricao,
    required this.tempo,
    required this.tags,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    String duracaoBruta = json["contentDetails"]?["duration"] ?? "";

    return Video(
      id: json["id"] ?? "",
      titulo: json["snippet"]?["title"] ?? "Sem título",
      thumb: json["snippet"]?["thumbnails"]?["high"]?["url"] ?? "",
      descricao: json["snippet"]?["description"] ?? "Sem descrição",
      
      tempo: _formatarTempoYoutube(duracaoBruta),
      
      tags: List<String>.from(json["snippet"]?["tags"] ?? []),
    );
  }

  static String _formatarTempoYoutube(String isoDuration) {
    if (isoDuration.isEmpty) return "0:00";

    RegExp regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    Match? match = regex.firstMatch(isoDuration);

    if (match == null) return "0:00";

    String horas = match.group(1) ?? "";
    String minutos = match.group(2) ?? "0";
    String segundos = match.group(3) ?? "0";

    String segundosFormatados = segundos.padLeft(2, '0');

    if (horas.isNotEmpty) {
      String minutosFormatados = minutos.padLeft(2, '0');
      return "$horas:$minutosFormatados:$segundosFormatados";
    }

    return "$minutos:$segundosFormatados";
  }
}