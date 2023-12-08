import 'package:appviajes/screens/login/SignInReal.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../menuPrincipal/MainMenu.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
bool _isEmailValid(String email) {
    // Utiliza una expresión regular para validar el correo electrónico
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
 Future<void> _register() async {
  final String email = _emailController.text.trim();
  final String password = _passwordController.text;
  final String confirmPassword = _confirmPasswordController.text;

  if (!_isEmailValid(email)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid email address.")));
    return;
  }

  

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match.")));
    return;
  }

  try {
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage = "An error occurred, please try again.";
    if (e.code == 'weak-password') {
      errorMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'The account already exists for that email.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              FlutterLogo(size: 100), // Reemplaza esto con tu logo
              SizedBox(height: 60),
              Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Experience the world at your fingertips with our travel mobile app!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Clifton Simmons',
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16),
              TextField(
                controller:
                    _emailController, // Vincula el controlador de texto para el email

                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller:
                    _passwordController, // Vincula el controlador de texto para la contraseña

                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '********',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller:
                    _confirmPasswordController, // Vincula el controlador de texto para confirmar contraseña

                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: '********',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Sign Up'),
              ),
              // Agregar botones de inicio de sesión de redes sociales aquí
              // ...
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInReal()),
                      );
                    },
                    child:
                        Text('Sign In', style: TextStyle(color: Colors.orange)),
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
