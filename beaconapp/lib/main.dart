import 'package:beaconapp/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthenticationScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp( {super.key} );

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  DateTime today = DateTime.now();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Welcome To Canada College!")),
    body: content(),
  );
}

  Widget content() {
    return Column(
      children: [
        Text("Canada College Schedule"),
        Container(
          child: TableCalendar(
            locale: "en_US",
            headerStyle: 
              HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            focusedDay: today, 
            firstDay: DateTime.utc(2025, 01, 01), 
            lastDay: DateTime.utc(2030, 06, 3)
            ),
        ),
      ],
    );
  }
}