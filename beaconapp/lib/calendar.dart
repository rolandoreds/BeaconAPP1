import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// The guy in the tutorial did this
class CalendarPage extends StatefulWidget {
  const CalendarPage( {super.key} );

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

// TO-DO: add opaque SMCCD logo behind calendar
// This is the calendar class
class _CalendarPageState extends State<CalendarPage> {
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