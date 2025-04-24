import 'package:beaconapp/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // Goes the sign in screen first, should go to calendar next
      home: const AuthenticationScreen(), 
    );
  }
}

// The guy in the tutorial did this
class MyApp extends StatefulWidget {
  const MyApp( {super.key} );

  @override
  State<MyApp> createState() => MyAppState();
}

// This is the calendar class
class MyAppState extends State<MyApp> {
  DateTime today = DateTime.now();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Academic Calendar")),
    body: content(),
  );
}

  Widget content() {
    return Column(
      children: [
        Text("Spring"),
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