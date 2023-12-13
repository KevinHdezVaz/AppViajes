import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:appviajes/screens/login/SignUpScreen.dart';
import 'package:appviajes/screens/menuPrincipal/MainMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInReal extends StatefulWidget {
  @override
  _SignInRealState createState() => _SignInRealState();
}

class _SignInRealState extends State<SignInReal> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
              title: Text("Iniciar sesion"),
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
                          'assets/animacion/animacionLogin.json',
                          fit: BoxFit.cover,
                          width: 200, // Establece el ancho deseado
                          height: 200, // Establece el alto deseado
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    const Text(
                      'Prepara tu viaje con nosotros',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Esquinas redondeadas
                          borderSide: BorderSide(
                              color: Color.fromARGB(252, 84, 0, 132) ,
                              width: 2.0), // Color y grosor del borde
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color.fromARGB(252, 84, 0, 132) , width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 212, 147, 49),
                              width:
                                  2.0), // Color del borde cuando el TextField está enfocado
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Esquinas redondeadas
                          borderSide: BorderSide(
                              color: Color.fromARGB(252, 84, 0, 132) ,
                              width: 2.0), // Color y grosor del borde
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color.fromARGB(252, 84, 0, 132) , width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 212, 147, 49),
                              width:
                                  2.0), // Color del borde cuando el TextField está enfocado
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        _signIn();
                      },
                      child: Text('INICIAR SESION'),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(252, 84, 0, 132) ,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50)),
                    ),
                    SizedBox(height: 16),
                    /*
                    TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?'),
                    ),
                    */
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿No tienes una cuenta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text('Registrarse',
                              style: TextStyle(color: Color.fromARGB(252, 84, 0, 132) )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
         if (_isLoading) ...[
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
                Color.fromARGB(252, 84, 0, 132) , // Color del indicador de progreso
              ),
            ),
          ),
        )
      ],
      ],
    );
  }
}
