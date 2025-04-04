import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir URLs en el navegador
import '../providers/planets_provider.dart';

class ApodScreen extends StatelessWidget {
  const ApodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final planetsProvider = Provider.of<PlanetsProvider>(context);
    print('PlanetsProvider inicializado: ${planetsProvider.todayPlanet}');

    if (planetsProvider.todayPlanet != null) {
      print('Media Type: ${planetsProvider.todayPlanet!.mediaType}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('NASA - Imagen del Día'),
        centerTitle: true,
      ),
      body: planetsProvider.todayPlanet == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    planetsProvider.todayPlanet!.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Verificamos si el contenido es imagen o video
                  if (planetsProvider.todayPlanet!.mediaType == "image") ...[
                    GestureDetector(
                      onTap: () async {
                        final Uri uri =
                            Uri.parse(planetsProvider.todayPlanet!.hdurl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      child: Column(
                        children: [
                          Icon(Icons.image, size: 100, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            'Haz clic aquí para ver la imagen',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ] else if (planetsProvider.todayPlanet!.mediaType ==
                      "video") ...[
                    Icon(Icons.video_collection, size: 100, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      'Este es un video. Ábrelo aquí:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () =>
                          _openVideo(planetsProvider.todayPlanet!.url, context),
                      child: Text('Ver Video'),
                    ),
                  ],

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      planetsProvider.todayPlanet!.explanation,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Función para abrir el video en el navegador
  void _openVideo(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el video')),
      );
    }
  }
}
