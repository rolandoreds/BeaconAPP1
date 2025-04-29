import 'package:beaconapp/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime, DateTime) onDaySelected;

  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime? _selectedDay;
  late DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String selectedDateStr = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
    _focusedDay = widget.focusedDay;
    selectedDateStr = DateFormat('MMMM d, y').format(_selectedDay!);
  }

  List<Event> _getHomeworkForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

    List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents2[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: TableCalendar(
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
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  widget.onDaySelected(selectedDay, focusedDay);
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
              eventLoader: (day) {
                final homework = _getHomeworkForDay(day);
                final events = _getEventsForDay(day);
                return [...homework, ...events];
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isEmpty) return const SizedBox(); // No events, no marker

                  // Separate homework and events
                  final homework = _getHomeworkForDay(day);
                  final normalEvents = _getEventsForDay(day);

                  List<Widget> markers = [];

                  if (homework.isNotEmpty) {
                    markers.add(
                      _buildMarkerDot(color: Colors.blue), // Homework = Blue
                    );
                  }

                  if (normalEvents.isNotEmpty) {
                    markers.add(
                      _buildMarkerDot(color: Colors.red), // Events = Red
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: markers,
                  );
                },
              ),
            ),
    );
  }

    Widget _buildMarkerDot({required Color color}) {
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}