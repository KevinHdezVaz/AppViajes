import 'package:appviajes/screens/login/SignInReal.dart';
import 'package:appviajes/screens/login/SignUpScreen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Centra los widgets horizontalmente
            children: <Widget>[
              Image.asset(
                'assets/images/logooo.jpg',
                width: 200, // Ancho de la imagen
                height: 200, // Alto de la imagen
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Welcome to Our Gozan\nTravel Mobile App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 20.0),
              const Text(
                'Travel around the word with just tap,\nand enjoy your holiday.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Color de fondo del botón
                  onPrimary: Colors.white, // Color del texto del botón
                  minimumSize: Size(double.infinity, 50), // Ancho infinito para el botón
                ),
                onPressed: () {
                   Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInReal()),
                      );
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                 Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                },
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  // Funcionalidad para cuentas existentes
                },
                child: Text('Already have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }  
  }