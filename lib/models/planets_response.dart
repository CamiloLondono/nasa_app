import 'dart:convert';
import '../models/planet.dart';

class PlanetResponse {
  List<Planet> planets;

  PlanetResponse({required this.planets});

  factory PlanetResponse.fromJson(String str) =>
      PlanetResponse.fromMap(json.decode(str));

  factory PlanetResponse.fromMap(List<dynamic> json) => PlanetResponse(
        planets: List<Planet>.from(json.map((x) => Planet.fromMap(x))),
      );
}
