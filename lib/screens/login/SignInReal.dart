import 'package:appviajes/services/login/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInReal extends StatefulWidget {
  @override
  _SignInRealState createState() => _SignInRealState();
}

class _SignInRealState extends State<SignInReal> {
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth

 @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

   Future<void> _signIn() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Si el inicio de sesión es exitoso, navegar a la pantalla principal
      if (userCredential.user != null) {
         Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInReal()),
                      );
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores de autenticación
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'An error occurred. Please try again later.';
      }
      // Mostrar el mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Permite desplazamiento en dispositivos con pantallas pequeñas
        child: Padding(
          padding: EdgeInsets.all(16.0), // Añade un padding a todo el contenido
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60), // Espacio adicional en la parte superior
              // Agrega tu logo aquí
              FlutterLogo(size: 100),
              SizedBox(height: 60), // Espacio después del logo
              Text(
                'Sign in to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8), // Espacio antes del subtítulo
              Text(
                'Experience the world at your fingertips with our travel mobile app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32), // Espacio antes de los campos de texto
              // Campo de texto para el email
              TextField(
                controller: _emailController, // Utiliza el TextEditingController

                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16), // Espacio entre los campos de texto
              // Campo de texto para la contraseña
              TextField(
                   controller: _passwordController, // Utiliza el TextEditingController

                obscureText:
                    !_passwordVisible, // La contraseña se oculta o muestra
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  // Ícono para mostrar u ocultar la contraseña
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Cambiar el ícono dependiendo de si la contraseña está visible
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Actualizar el estado para cambiar la visibilidad
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                  height: 24), // Espacio antes del botón de inicio de sesión
              // Botón de inicio de sesión

              // Asume que tienes un TextEditingController para email y password
              ElevatedButton(
               onPressed: _signIn, 
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Color de fondo del botón
                  onPrimary: Colors.white, // Color del texto del botón
                  minimumSize: Size(double.infinity, 50), // Tamaño del botón
                ),
                child: Text('Sign In'),
              ),

              SizedBox(
                  height: 16), // Espacio después del botón de inicio de sesión
              TextButton(
                onPressed: () {
                  // Implementar funcionalidad de "Olvidé mi contraseña"
                },
                child: Text('Forgot Password?'),
              ),
              SizedBox(
                  height: 16), // Espacio antes de los botones de redes sociales
              // Agregar botones de inicio de sesión de redes sociales aquí
              // ...
              SizedBox(
                  height:
                      16), // Espacio después de los botones de redes sociales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                    },
                    child:
                        Text('Sign Up', style: TextStyle(color: Colors.orange)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
