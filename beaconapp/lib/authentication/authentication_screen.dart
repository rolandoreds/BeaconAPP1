import 'package:flutter/material.dart';
import 'package:beaconapp/authentication/authentication_text_form_field.dart';
import 'package:beaconapp/calendar/calendar_screen.dart';
import 'package:beaconapp/authentication/wave.dart';
import 'package:beaconapp/home.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool employeeSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Wave(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // standard box height 
                  const SizedBox(height: 50),

                  // User Enters User Name here OBV
                  AuthenticationTextFormField(
                    icon: employeeSwitch ? Icons.account_circle_outlined : Icons.assignment_ind_outlined,
                    label: 'Username',
                    textEditingController: emailController,
                  ),

                  // User Enters Password Here OBV
                  AuthenticationTextFormField(
                    icon: Icons.password, 
                    label: 'Password',
                    textEditingController: passwordController,
                  ),

                  // Login Button -- future update authentication
                  const SizedBox(height: 25,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
          );
                    }, 
                    child: Text (
                      'Login',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ) ,

                  // button that switches between student and employee portal
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      setState(() => employeeSwitch = !employeeSwitch);
                      _formKey.currentState?.reset();
                    },
                    child: Text(
                      employeeSwitch == true ? 'Employee Login' : 'Student Login',
                    ),
                  ),

                  // "Ugly" Button that switches to Calendar page by Thetawave_
                  const SizedBox(height: 25,),
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
          ),
        ],
      ),
    );
  }
}