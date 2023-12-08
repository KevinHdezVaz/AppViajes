import 'package:appviajes/screens/Onboarding/OnboardingScreen.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/menuPrincipal/MainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
        theme: ThemeData(
        // Define el color primario y los colores de acento
        primaryColor: Colors.orange,
        hintColor: Colors.orangeAccent,
         
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MainMenu(); // Cambia esto por tu pantalla de usuario autenticado
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
