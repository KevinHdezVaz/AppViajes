import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

   @override
  void initState() {
    super.initState();
    _checkOnboardingComplete();
  }

void _checkOnboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    if (onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }
  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  final List<Widget> _pages = [
  OnboardingPage(
    title: 'Disfruta el tour con una mente abierta',
    content:
        'Explorar nuevos lugares y probar cosas nuevas puede ser intimidante, pero navegar exitosamente estas experiencias.',
    lottieAnimation: 'assets/animacion/animacion4.json',
  ),
  OnboardingPage(
    title: 'Viajar te enseña',
    content:
        'Viajar te permite experimentar diferentes culturas de primera mano y ganar un mayor entendimiento y apreciación de la diversidad.',
    lottieAnimation: 'assets/animacion/animacion2.json',
  ),
  OnboardingPage(
    title: 'Vamos al destino de viaje',
    content:
        'Cancún ciudad con culturas diversas y atracciones, lo que lo convierte en un gran destino para las vacaciones de verano.',
    lottieAnimation: 'assets/animacion/animacion1.json',
  ),
  OnboardingPage(
    title: 'Explora algo nuevo',
    content:
        'Superamos nuevas dificultades y problemas. De tal manera salimos de nuestra zona de confort.',
    lottieAnimation: 'assets/animacion/animacion3.json',
  ),
];


  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _pageController.jumpToPage(_pages.length - 1);
            },
            child: Text('Omitir',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _pages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          _currentPage == _pages.length - 1
              ? Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                     onPressed: _completeOnboarding,

                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: Size(
                          double.infinity, 50), // Ancho infinito para el botón
                    ),
                    child: Text('Comenzar'),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String content;
  final String lottieAnimation;

  OnboardingPage({
    required this.title,
    required this.content,
    required this.lottieAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(lottieAnimation, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
