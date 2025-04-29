import 'package:beaconapp/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final ValueNotifier<List<Event>> homework;
  final ValueNotifier<List<Event>> events;
  final ScrollController scrollController;

  const TabWidget({
    super.key,
    required this.homework,
    required this.events,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Build Homework tab
        buildList(homework, 'No Homework'),

        // Build Events tab
        buildList(events, 'No Events'),
      ],
    );
  }

  Widget buildList(ValueNotifier<List<Event>> list, String emptyMessage) {
    return ValueListenableBuilder(
      valueListenable: list, 
      builder: (context, value, _) {
        if (value.isEmpty) {
          return Center(child: Text(emptyMessage));
        }
        return ListView.builder(
      controller: scrollController,
      itemCount: value.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            title: Text('${value[index]}'),
          ),
        );
      },
    );
      }
    );
  }

}