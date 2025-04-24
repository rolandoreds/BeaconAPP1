import 'package:flutter/material.dart';
import 'package:beaconapp/calendar.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                floatingLabelStyle: Theme.of(context).textTheme.titleLarge,
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                labelText: 'Email',
              ),
            ), // eamil getter
            TextFormField(),
            TextFormField(),
            ElevatedButton(
              onPressed: () {}, 
              child: const Text('Register'),
              ) ,
            InkWell(
              onTap: () {},
              child: const Text('Login instead'),
            ),

            // Button that switches to Calendar page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              }, 
              child: const Text('Calendar'),
              ) ,

          ],
        ),
      ),
    );
  }
}