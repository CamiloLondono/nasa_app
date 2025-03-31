import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/planets_provider.dart';
import '../screens/home_screen.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlanetsProvider(), lazy: false),
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
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
