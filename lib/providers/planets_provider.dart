import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/planet.dart';

class PlanetsProvider extends ChangeNotifier {
  Planet? todayPlanet;

  PlanetsProvider() {
    getTodayPlanet();
  }

  Future<void> getTodayPlanet() async {
    print('Obteniendo datos de la API...');

    final url = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=9FfdHxOu5IUK81qZFqoZR40tLe2F84J1QORTojEb');

    try {
      final response = await http.get(url);
      print('Código de respuesta: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Datos recibidos: $data');
        print('hdurl: ${data["hdurl"]}');
        print('url: ${data["url"]}'); // ✅ Verificar qué datos llegan

        todayPlanet = Planet.fromMap(data);
        print('Datos procesados correctamente: ${todayPlanet!.title}');

        notifyListeners();
      } else {
        print('Error al obtener datos: ${response.body}');
      }
    } catch (e) {
      print('Error en la petición: $e');
    }
  }
}
