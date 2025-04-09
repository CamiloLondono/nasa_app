import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
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

    if (marsWeatherProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final weatherData = marsWeatherProvider.weatherData;

    if (weatherData == null || weatherData.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No se pudieron obtener los datos.')),
      );
    }

    final sortedSols = weatherData.keys.toList()
      ..sort((a, b) => int.parse(b).compareTo(int.parse(a)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en Marte'),
        centerTitle: true,
      ),
      body: Center(
        child: Swiper(
          itemCount: sortedSols.length > 7 ? 7 : sortedSols.length,
          itemWidth: MediaQuery.of(context).size.width * 0.85,
          layout: SwiperLayout.STACK,
          itemBuilder: (context, index) {
            final solKey = sortedSols[index];
            final int? sol = int.tryParse(solKey.toString());
            if (sol == null) return const SizedBox.shrink();
            final data = weatherData[solKey];

            double? maxTemp = _parseDouble(data?['AT']?['mx']);
            double? minTemp = _parseDouble(data?['AT']?['mn']);
            double? pressure = _parseDouble(data?['PRE']?['av']);
            double? windSpeed = _parseDouble(data?['HWS']?['av']);

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(_getImageForSol(index)),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sol $sol',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text('Temperatura máxima: ${maxTemp ?? 'N/A'}°C',
                          style: const TextStyle(color: Colors.white)),
                      Text('Temperatura mínima: ${minTemp ?? 'N/A'}°C',
                          style: const TextStyle(color: Colors.white)),
                      Text('Presión: ${pressure ?? 'N/A'} Pa',
                          style: const TextStyle(color: Colors.white)),
                      Text('Velocidad del viento: ${windSpeed ?? 'N/A'} m/s',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  String _getImageForSol(int index) {
    final images = [
      'image1.png',
      'image2.png',
      'image3.png',
      'image4.png',
      'image5.png',
    ];
    return images[index % images.length];
  }
}
