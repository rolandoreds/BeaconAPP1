import 'package:beaconapp/authentication/authentication_screen.dart';
import 'package:beaconapp/home.dart';
import 'package:beaconapp/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 58, 101, 62),
          primary: const Color.fromARGB(255, 58, 101, 62),
          secondary: Colors.green.shade100,
          tertiary: Colors.grey,
          onPrimary: Colors.white,
        ),
        useMaterial3: true,
      ),
      // Goes the sign in screen first, should go to calendar next
      home: const AuthenticationScreen(), 
      routes: {
          '/home': (context) => const HomePage(),
          '/calendar': (context) => const CalendarPage(),
          // DO NOT USE THIS, IT WILL CRASH THE APP
          '/login': (context) => const AuthenticationScreen(),
      }
    );
  }
}
