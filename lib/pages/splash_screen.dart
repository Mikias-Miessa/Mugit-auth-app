import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _animationController.forward();

    Future.delayed(Duration(milliseconds: 3500), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginPage.routeName,
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = 150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashscreen.jpg',
              width: imageSize,
              height: imageSize,
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _animationController.value,
                  child: child,
                );
              },
              child: Text(
                'MUGIT',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 44,
                  letterSpacing: 1,
                  color: Color.fromARGB(255, 0, 0, 85),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
