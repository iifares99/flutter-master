import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'auth_service.dart'; // Ensure this is the correct path to your auth service

class LoginForm extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth =
      AuthService();

  LoginForm({super.key}); // Instance of AuthService to handle Firebase login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // Call the login function and check the result
                String email = userIdController.text;
                String password = passwordController.text;

                if (email.isNotEmpty && password.isNotEmpty) {
                  // Attempt to login
                  User? user = await _auth.loginWithEmail(email, password);
                  if (user != null) {
                    // If login is successful, navigate to the main page
                    Navigator.pushReplacementNamed(
                        context, '/'); // Navigate to Main Page
                  } else {
                    // Show error dialog if login fails
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Login Failed"),
                          content:
                              const Text("Invalid credentials. Please try again."),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Show error if fields are empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Please fill in both fields."),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

