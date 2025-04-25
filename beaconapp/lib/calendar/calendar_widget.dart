import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beaconapp/utils.dart';

class CalendarWidget extends StatefulWidget {
  /*
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  */

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();

/*
  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: TableCalendar(
              locale: "en_US",
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              calendarFormat: CalendarFormat.month,
              focusedDay: focusedDay,
              firstDay: DateTime.utc(2025, 01, 01),
              lastDay: DateTime.utc(2030, 06, 03),
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: onDaySelected,
              onPageChanged: (focusedDay) { },
            ),
          ),
        ],
      ),
    );
  }
  */
}

class _CalendarWidgetState extends State<CalendarWidget>{
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}