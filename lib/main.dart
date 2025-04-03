import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/planets_provider.dart';
import '../providers/mars_weather_provider.dart'; // Se agregó el nuevo provider
import '../screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlanetsProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (_) => MarsWeatherProvider(),
            lazy: false), // Se agregó el nuevo provider
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explorador Espacial',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mars_weather': (_) => MarsWeatherScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
