import 'package:flutter/material.dart';
import 'package:beaconapp/authentication_text_form_field.dart';
import 'package:beaconapp/calendar.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            const SizedBox(height: 50),
            AuthenticationTextFormField(
              icon: Icons.email, 
              label: 'Email',
              textEditingController: emailController,
            ),
            AuthenticationTextFormField(
              icon: Icons.password, 
              label: 'Password',
              textEditingController: emailController,
            ),
            ElevatedButton(
              onPressed: () {}, 
              child: const Text('Login'),
              ) ,
             // Button that switches to Calendar page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              }, 
              child: const Text('Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}