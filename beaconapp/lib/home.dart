import 'package:flutter/material.dart';
import 'package:beaconapp/profile.dart'; // Ensure this path matches your project structure
import 'package:beaconapp/slide_in_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer slides in from the left.
      drawer: MenuWidget(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Text(
            'Home Page',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 8, 35, 3),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 149, 193, 154),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      // Using a ListView to allow vertical scrolling like an Instagram feed.
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // First container: COMPUTER SCIENCE NEWS
          InkWell(
            onTap: () {
              // Action when tapped.
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'COMPUTER SCIENCE NEWS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Join us in our collaboration project!'),
                ],
              ),
            ),
          ),
          // Second container: INTERNSHIP OPPORTUNITY
          InkWell(
            onTap: () {
              // Action when tapped.
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'INTERNSHIP OPPORTUNITY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Stanford Department of Aeronautics and Astronautics offers a unique summer research program that provides community college students with an opportunity to explore careers in aerospace engineering.',
                  ),
                ],
              ),
            ),
          ),
          // Third container: TO-DO
          InkWell(
            onTap: () {
              // Action when tapped.
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'TO-DO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('4/25/2024 present app to smccd hackathon'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}