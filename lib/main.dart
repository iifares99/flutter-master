import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main_page.dart';
import 'volunteer_form.dart';
import 'login.dart';  // Assuming login_screen.dart contains the login UI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: "AIzaSyBi7yGQydjfQs7Dcf7y90MpnBUGyLao2Dw", 
    appId: "1:953518157135:android:7b5d5ff5d200566355693a",
    messagingSenderId: "953518157135",
    projectId:"fir-2-firebase", )
  );
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/login': (context) => LoginForm(),
      '/volunteer': (context) => const VolunteerForm(),
    },
  ));
}
