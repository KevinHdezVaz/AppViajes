import 'package:appviajes/screens/login/SignInReal.dart';
import 'package:appviajes/screens/login/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
Lottie.asset(
  'assets/animacion/animacionLogo.json',
  fit: BoxFit.cover,
  width: 300, // Establece el ancho deseado
  height: 300, // Establece el alto deseado
)
,
              const SizedBox(height: 70.0),
              const Text(
                'Bienvenido a Kave MX\nApp de Viaje',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 20.0),
              const Text(
                "Viaja por el mundo con solo un toque,\ny disfruta de tus vacaciones.",
          textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
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
                  child: Text('INICIAR SESION'),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                 Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                },
                child: Text('Registrarse'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }  
  }