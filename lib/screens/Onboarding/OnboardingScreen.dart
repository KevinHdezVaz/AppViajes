 import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _pages = [
    OnboardingPage(
      title: 'Enjoy tour with open mind',
      content:
          'Exploring new places and trying new things can be intimidating, but successfully navigating these experiences.',
      image: 'assets/onboarding/illustration.png',
    ),
    OnboardingPage(
      title: 'Traveling teaches you',
      content:
          'Traveling allows you to experience different cultures firsthand and gain a greater understanding and appreciation of diversity.',
      image: 'assets/onboarding/illustration1.png',
    ),
    OnboardingPage(
      title: 'Let’s travel destination',
      content:
          'The US is a vast country with diverse cultures, and attractions, making it a great destination for summer vacations.',
      image: 'assets/onboarding/illustration2.png',
    ),
    OnboardingPage(
      title: 'Explore something new',
      content:
          'We overcome new difficulties and problems. In such a manner we get out of our comfort zone.',
      image: 'assets/onboarding/illustration3.png',
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
            child: Text('Skip',
                style: TextStyle(
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
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
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
                    child: Text('Start'),
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
  final String image;

  OnboardingPage({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, fit: BoxFit.cover),
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
