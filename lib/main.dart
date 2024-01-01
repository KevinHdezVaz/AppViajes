import 'package:appviajes/firebase_options.dart';
import 'package:appviajes/screens/Onboarding/OnboardingScreen.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'screens/menuPrincipal/MainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

Stripe.publishableKey = 'pk_test_51OSphTLdrmOjnrTqeTozdtjwduBB8tbznIqcjQSBItWN3vAvx9yCFRKzd0ElsHT9zVNUHZUNL8nEONQ74rD0XKoM00VF5sEmAq';

await dotenv.load(fileName: "assets/.env");


  runApp(  MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
        theme: ThemeData(
        // Define el color primario y los colores de acento
        primaryColor: Color.fromARGB(252, 84, 0, 132) ,
        hintColor: Color.fromARGB(246, 144, 32, 189)
         
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MainMenu();  
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
