import 'package:beaconapp/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
  final double tabBarHeight = 150;

@override
Widget build(BuildContext context) {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  
  return Scaffold(
    appBar: AppBar(title: Text("Academic Calendar")),
    body: SlidingUpPanel(
      minHeight: 175,
      maxHeight: MediaQuery.of(context).size.height,
      panelBuilder: (scrollController) => buildSlidingPanel(
        scrollController: scrollController,
        ),

      body: SingleChildScrollView(
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
                focusedDay: today,
                firstDay: DateTime.utc(2025, 01, 01),
                lastDay: DateTime.utc(2030, 06, 03),
              ),
            ),
          ],
        ),
      ),
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
  
  PreferredSizeWidget buildTabBar() => PreferredSize(
    preferredSize: Size.fromHeight(tabBarHeight),
    child: AppBar(
      title: buildDragIcon(), //Icon(Icons.drag_handle),
      automaticallyImplyLeading: false,
      centerTitle: true, 
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                DateFormat('MMMM d, y').format(DateTime.now()),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )
              ),
            ),

            TabBar(
              tabs: [
                Tab(child: Text('Homework')),
                Tab(child: Text('Events')),
              ],
            )
          ],
        )
      )
      
      
    ),
  );
  
  Widget buildDragIcon() => Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(8)
    ),
    width: 50,
    height: 6,

  );

// Do not pay attention to this
// Keeping just in case
/* 
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
        SlidingUpPanel(
          panel: Center(child: Text("This is the sliding Widget"),),
        )
      ],
    );
  }
  */
}