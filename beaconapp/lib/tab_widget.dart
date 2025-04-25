import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.all(16),
    controller: scrollController,
    children: [
      Text(
        'To-Do List Test',
        textAlign: TextAlign.center,
      )
    ],
  );

}