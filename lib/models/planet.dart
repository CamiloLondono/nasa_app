class Planet {
  String title;
  String explanation;
  String url;
  String hdurl;
  String mediaType;
  String date;

  Planet({
    required this.title,
    required this.explanation,
    required this.url,
    required this.hdurl,
    required this.mediaType,
    required this.date,
  });

  factory Planet.fromMap(Map<String, dynamic> json) => Planet(
        title: json["title"] ?? "Sin título",
        explanation: json["explanation"] ?? "Sin descripción",
        url: json["url"] ?? "",
        hdurl: json["hdurl"] ?? "",
        mediaType: json["media_type"] ?? "",
        date: json["date"] ?? "",
      );
}
