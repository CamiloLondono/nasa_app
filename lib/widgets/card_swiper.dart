import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/planet.dart'; // Asegúrate de tener un modelo para Planet

class CardSwiper extends StatelessWidget {
  final List<Planet> planets; // Cambiamos de Movie a Planet
  const CardSwiper({super.key, required this.planets});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (planets.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: planets.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (_, int index) {
            final planet = planets[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(planet.hdurl),
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}
