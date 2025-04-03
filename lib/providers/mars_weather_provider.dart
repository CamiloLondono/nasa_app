import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarsWeatherProvider extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic>? weatherData;

  Future<void> fetchMarsWeather() async {
    const String url =
        'https://api.nasa.gov/insight_weather/?version=1.0&feedtype=json&api_key=9FfdHxOu5IUK81qZFqoZR40tLe2F84J1QORTojEb';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey("sol_keys") && data["sol_keys"] is List) {
          weatherData = {
            for (var sol in data["sol_keys"])
              sol.toString(): data[sol.toString()]
          };
        } else {
          weatherData = {};
        }
      } else {
        weatherData = {};
      }
    } catch (error) {
      print("Error al obtener datos del clima en Marte: $error");
      weatherData = {};
    }

    isLoading = false;
    notifyListeners();
  }
}
