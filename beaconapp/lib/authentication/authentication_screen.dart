/*
 * Name: Authentication Screen
 * Details: Um I mean its pretty obvious
 * Features: User Interface, username & password authentication
 * By: Edwin
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert'; // LineSplitter

import 'package:beaconapp/calendar/calendar_screen.dart';
import 'package:beaconapp/authentication/wave.dart';
import 'package:beaconapp/home.dart';

/// Global repository instance so any widget can call `authenticate()`.
final AuthRepository authRepo = AuthRepository();

/// Authentication repository that loads usr name & paswrds from text files
class AuthRepository {
  late Map<String, String> _creds; // username → password

  // grabs dat file thats in the repective dir path
  Future<void> grabdat() async { 
    final usernames = await _loadLines('assets/tmpFiles/usernames.txt');
    final passwords = await _loadLines('assets/tmpFiles/passwords.txt');
    final len = usernames.length < passwords.length ? usernames.length : passwords.length;
    _creds = { for (var i = 0; i < len; i++) usernames[i] : passwords[i] };
  }

  // function that laods txt file and trims it to get raw text
  Future<List<String>> _loadLines(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return const LineSplitter().convert(raw)
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  // function called by class to compare text
  bool authenticate(String username, String password) {
    final stored = _creds[username];
    return stored != null && stored == password;
  }
}

/// A reusable text form field for authentication with validation.
class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    super.key,
    required this.icon,
    required this.label,
    required this.textEditingController,
    this.confirmationController,
  });

  final IconData icon;
  final String label;
  final TextEditingController textEditingController;
  final TextEditingController? confirmationController;

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.';
    }

    final isUsername = label.toLowerCase().contains('username');
    final isPassword = label.toLowerCase().contains('password');

    if (isUsername && value.length <= 2) {
      return 'Please enter your username.';
    }

    if (isPassword) {
      if (value.length <= 4) return 'The password must be at least 4 characters.';
      // When both controllers are present, validate credentials.
      if (confirmationController != null &&
          !authRepo.authenticate(confirmationController!.text.trim(), value)) {
        return 'Incorrect Username or Password.';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: textEditingController,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        floatingLabelStyle: theme.textTheme.titleLarge,
        icon: Icon(icon, color: theme.colorScheme.primary),
        labelText: label,
      ),
      validator: _validate,
    );
  }
}

/// main authentication screen that contains the login form
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

/// State class for the authentication screen.
/// It manages the form state and handles user input.
class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool employeeSwitch = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    authRepo.grabdat().whenComplete(() => setState(() => _loading = false));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                  const SizedBox(height: 50),

                  // Username field
                  AuthenticationTextFormField(
                    icon: employeeSwitch
                        ? Icons.account_circle_outlined
                        : Icons.assignment_ind_outlined,
                    label: 'Username',
                    textEditingController: _usernameCtrl,
                  ),

                  // Password field
                  AuthenticationTextFormField(
                    icon: Icons.password,
                    label: 'Password',
                    textEditingController: _passwordCtrl,
                    confirmationController: _usernameCtrl,
                  ),

                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final ok = authRepo.authenticate(
                          _usernameCtrl.text.trim(),
                          _passwordCtrl.text,
                        );
                        if (ok) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Username and password do not match.')),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      setState(() => employeeSwitch = !employeeSwitch);
                      _formKey.currentState?.reset();
                    },
                    child: Text(
                      employeeSwitch ? 'Employee Login' : 'Student Login',
                    ),
                  ),

                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CalendarPage()),
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
