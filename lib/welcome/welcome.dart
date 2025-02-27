import 'package:auth/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import 'curvepainter.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'type': 'lottie',
      'asset': 'assets/animations/two.json',
      'title': 'Welcome To Reciepter',
      'description': 'Discover amazing features to enhance your health where innovation meets care. Together, we’re shaping a healthier tomorrow.',
    },
    {
      'type': 'lottie',
      'asset': 'assets/animations/one.json',
      'title': 'Stay Organized',
      'description': 'At Reciepter, your well-being is our mission. Let’s create impactful healthcare innovations together."',
    },
    {
      'type': 'lottie',
      'asset': 'assets/animations/turbine.json',
      'title': 'Get Started',
      'description': 'We’re thrilled to have you join our mission of transforming lives through groundbreaking pharmaceutical solutions. '
          'Your journey in shaping the future of healthcare begins here. Welcome aboard!',
    },
  ];

  void _onSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _onNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // JPG Background
          Image.asset(
            'assets/welcome/background.jpg', // Path to your JPG file
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Adjusts the image to fill the background
          ),
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: WelcomeCurvePainter(),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (slide['type'] == 'image')
                    Image.asset(slide['asset']!, height: 300)
                  else if (slide['type'] == 'lottie')
                    Lottie.asset(slide['asset']!, height: 300),
                  const SizedBox(height: 20),
                  Text(
                    slide['title']!,
                    style: const TextStyle(
                      fontSize: 24, color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    slide['description']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onSkip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
                Row(
                  children: List.generate(
                    _slides.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _onNext,
                  child: Text(
                    _currentIndex == _slides.length - 1
                        ? 'Start'
                        : 'Next',
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
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
