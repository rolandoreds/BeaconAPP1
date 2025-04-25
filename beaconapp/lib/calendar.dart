import 'package:beaconapp/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'calendar_widget.dart'; // <-- new import

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String selectedDateStr = '';
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final double tabBarHeight = 150;

  // Use a fixed initial height instead of dynamic calculation
  double panelMinHeight = 175;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    selectedDateStr = DateFormat('MMMM d, y').format(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Calendar"),
        backgroundColor: Color.fromARGB(255, 58, 101, 62),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use a simpler approach - position the panel at approximately 60% of screen height
          // This is a safer approach than trying to measure the calendar directly
          final panelMinHeight = screenHeight - 460;
          
        return SlidingUpPanel(
          minHeight: panelMinHeight,
          maxHeight: screenHeight * 0.96,
          panelBuilder: (scrollController) => buildSlidingPanel(
            scrollController: scrollController,
        ),
          body: CalendarWidget(
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                selectedDateStr = DateFormat('MMMM d, y').format(selectedDay);
                });
              },
            ),
          );
        }
      ),
    );
  }

  Widget buildSlidingPanel({
    required ScrollController scrollController,
  }) =>
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildTabBar(),
          body: TabBarView(
            children: [
              TabWidget(scrollController: scrollController),
              TabWidget(scrollController: scrollController),
            ],
          ),
        ),
      );

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

  Widget buildDragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 50,
        height: 4,
      );
}