class MarsWeather {
  final String sol;
  final double minTemp;
  final double maxTemp;
  final double avgTemp;
  final double windSpeed;
  final String season;

  MarsWeather({
    required this.sol,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
    required this.windSpeed,
    required this.season,
  });

  factory MarsWeather.fromJson(Map<String, dynamic> json) {
    return MarsWeather(
      sol: json['sol_keys'][0] ?? 'N/A',
      minTemp: json[json['sol_keys'][0]]['AT']['mn']?.toDouble() ?? 0.0,
      maxTemp: json[json['sol_keys'][0]]['AT']['mx']?.toDouble() ?? 0.0,
      avgTemp: json[json['sol_keys'][0]]['AT']['av']?.toDouble() ?? 0.0,
      windSpeed: json[json['sol_keys'][0]]['HWS']['av']?.toDouble() ?? 0.0,
      season: json[json['sol_keys'][0]]['Season'] ?? 'Desconocida',
    );
  }
}
