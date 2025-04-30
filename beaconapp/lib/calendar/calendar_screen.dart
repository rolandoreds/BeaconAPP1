import 'package:beaconapp/calendar/calendar_utils.dart';
import 'package:beaconapp/calendar/calendar_widget.dart';
import 'package:beaconapp/slide_in_menu.dart';
import 'package:beaconapp/calendar/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime? _selectedDay;
  late DateTime _focusedDay = DateTime.now();
  String selectedDateStr = '';
  late final ValueNotifier<List<Event>> _selectedHomework;
  late final ValueNotifier<List<Event>> _selectedEvents;

    @override
    void initState() {
      super.initState();
      _selectedDay = _focusedDay;
      _selectedHomework = ValueNotifier(_getHomeworkForDay(_selectedDay!));
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      selectedDateStr = DateFormat('MMMM d, y').format(_selectedDay!);
    }

  @override
  void dispose() {
    _selectedHomework.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getHomeworkForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

    List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents2[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      selectedDateStr = DateFormat('MMMM d, y').format(_selectedDay!);
      _selectedHomework.value = _getHomeworkForDay(selectedDay);
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text(
            'Calendar',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final panelMinHeight = screenHeight - 490;
          
          return SlidingUpPanel(
            minHeight: panelMinHeight,
            maxHeight: screenHeight * 0.96,
            panelBuilder: (scrollController) => buildSlidingPanel(
              scrollController: scrollController,
            ),
            body: CalendarWidget(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              onDaySelected: _onDaySelected,
            )
          );
        }
      )
    );
  }

  // Method that builds the SlidingUpPanel
  Widget buildSlidingPanel({
    required ScrollController scrollController,
  }) =>
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildTabBar(),
          body: TabWidget(
            homework: _selectedHomework,
            events: _selectedEvents,
            scrollController: scrollController,
          )
        ),
      );

  // Method that decorates the Tabs in the SlidingUpPanel
  PreferredSizeWidget buildTabBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: buildDragIcon()),
            SizedBox(height: 8),
            Text(
              selectedDateStr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          tabs: [
            Tab(child: Text('Homework')),
            Tab(child: Text('Events')),
          ],
        ),
      );

  // Method that creates the Icon used at the top of the SlidingUpPanel
  Widget buildDragIcon() => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 50,
        height: 4,
      );
}