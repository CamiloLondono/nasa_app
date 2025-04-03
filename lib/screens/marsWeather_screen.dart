import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mars_weather_provider.dart';

class MarsWeatherScreen extends StatefulWidget {
  const MarsWeatherScreen({super.key});

  @override
  _MarsWeatherScreenState createState() => _MarsWeatherScreenState();
}

class _MarsWeatherScreenState extends State<MarsWeatherScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MarsWeatherProvider>(context, listen: false)
            .fetchMarsWeather());
  }

  @override
  Widget build(BuildContext context) {
    final marsWeatherProvider = context.watch<MarsWeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en Marte'),
        centerTitle: true,
      ),
      body: marsWeatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (marsWeatherProvider.weatherData == null ||
                  marsWeatherProvider.weatherData!.isEmpty)
              ? const Center(child: Text('No se pudieron obtener los datos.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: marsWeatherProvider.weatherData!.length > 7
                      ? 7
                      : marsWeatherProvider.weatherData!.length,
                  itemBuilder: (context, index) {
                    final sortedSols = marsWeatherProvider.weatherData!.keys
                        .toList()
                      ..sort((a, b) => int.parse(b).compareTo(
                          int.parse(a))); // Ordenamos de mayor a menor

                    final solKey =
                        sortedSols[index]; // Tomamos los últimos 7 días
                    final int? sol = int.tryParse(solKey.toString());
                    if (sol == null) return const SizedBox.shrink();
                    final data = marsWeatherProvider.weatherData![solKey];

                    double? maxTemp = _parseDouble(data?['AT']?['mx']);
                    double? minTemp = _parseDouble(data?['AT']?['mn']);
                    double? pressure = _parseDouble(data?['PRE']?['av']);
                    double? windSpeed = _parseDouble(data?['HWS']?['av']);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sol $sol',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text('Temperatura máxima: ${maxTemp ?? 'N/A'}°C'),
                            Text('Temperatura mínima: ${minTemp ?? 'N/A'}°C'),
                            Text('Presión: ${pressure ?? 'N/A'} Pa'),
                            Text(
                                'Velocidad del viento: ${windSpeed ?? 'N/A'} m/s'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  /// Función para convertir valores a double de forma segura
  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value); // Intentamos convertir si es un string
    }
    return null; // Retornamos null si no es convertible
  }
}
