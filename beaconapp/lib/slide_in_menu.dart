import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
   const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 168, 207, 172),
            ),
            child: Text(
              'Directory',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: const Color.fromARGB(255, 0, 28, 4)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/home');
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ]
      ),
    );
  }
} 
