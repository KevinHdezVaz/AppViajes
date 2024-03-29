import 'dart:convert';

import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:appviajes/screens/login/SignInReal.dart';
import 'package:appviajes/services/Api/apiRest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menuPrincipal/MainMenu.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading2 = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) {
    // Utiliza una expresión regular para validar el correo electrónico
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  Future<void> _register() async {
    final String nombre = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Porfavor introduce un email válido.")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Contraseñas no coinciden, intenta de nuevo.")));
      return;
    }
    setState(() {
      _isLoading2 =
          true; // Activar el indicador de carga solo después de las validaciones
    });
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
 
    var apiRest = ApiRest();
    var response = await apiRest.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _confirmPasswordController.text); 
        
  // Después del registro o inicio de sesión exitoso
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setString('userName', _nameController.text); // Guardar el nombre del usuario
 

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var token = data['access_token'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    print("Token received: $token");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainMenu()),
    );
  } else {
    // Manejar el error
    print('Error: ${response.body}');
  }

        

      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred, please try again.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        _isLoading2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Registrate"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Lottie.asset(
                        'assets/animacion/animacionRegis.json',
                        fit: BoxFit.cover,
                        width: 150, // Establece el ancho deseado
                        height: 150, // Establece el alto deseado
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Crea tu cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Bordes redondeados
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                                252, 84, 0, 132)), // Color del contorno
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132),
                            width: 2), // Contorno más grueso al enfocar
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132),
                            width: 1), // Contorno normal
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction
                        .next, // Cambia la acción del teclado a "Next"
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo electronico',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Esquinas redondeadas
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132),
                            width: 2.0), // Color y grosor del borde
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132), width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(
                              255, 212, 147, 49), // Color naranja más intenso
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132), width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 212, 147, 49),
                          width: 2.0,
                        ),
                      ),
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
                    controller: _confirmPasswordController,
                    obscureText: !_confirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(252, 84, 0, 132), width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 212, 147, 49),
                          width: 2.0,
                        ),
                      ),
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
                    onPressed: () {
                       _register();
 
                    },
                    child: Text("ENTRAR"),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(252, 84, 0, 132),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50)),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿Ya tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInReal()),
                          );
                        },
                        child: Text('INICIAR SESION',
                            style: TextStyle(
                                color: Color.fromARGB(252, 84, 0, 132))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      if (_isLoading2) ...[
        const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.grey)),
        const Center(
          child: SizedBox(
            width: 60, // El ancho del CircularProgressIndicator
            height: 60, // El alto del CircularProgressIndicator
            child: CircularProgressIndicator(
              strokeWidth: 3, // El grosor del indicador de progreso
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(
                    252, 84, 0, 132), // Color del indicador de progreso
              ),
            ),
          ),
        )
      ],
    ]);
  }
 
}
