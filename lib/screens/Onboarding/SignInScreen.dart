import 'package:appviajes/screens/login/SignInReal.dart';
import 'package:appviajes/screens/login/SignUpScreen.dart';
import 'package:appviajes/screens/menuPrincipal/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    _checkForToken();
  }

  Future<void> _checkForToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/conocec.webp"), // Reemplaza con la ruta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      'assets/animacion/animacionLogo.json',
                      fit: BoxFit.cover,
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 70.0),
                    Card(
                      color: Color.fromARGB(255, 108, 75, 184),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Bienvenido a Lets Party',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Viaja por el mundo con solo un toque,\ny disfruta de tus vacaciones.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 80.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(252, 84, 0, 132),
                          onPrimary: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInReal()),
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
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text('Registrarse', style: TextStyle(fontSize: 20),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
