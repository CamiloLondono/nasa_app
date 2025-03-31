import 'package:flutter/material.dart';
import '../models/planet.dart'; // Asegúrate de tener este modelo

class PlanetSlider extends StatelessWidget {
  final List<Planet> planets;
  final String? title;

  const PlanetSlider({super.key, required this.planets, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: planets.length,
              itemBuilder: (_, int index) => _PlanetPoster(planets[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanetPoster extends StatelessWidget {
  final Planet planet;
  const _PlanetPoster(this.planet);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(planet.hdurl),
              width: 130,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            planet.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
