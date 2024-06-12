import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:namer_app/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namer_app/screen/auth_page_screen.dart';
import 'package:namer_app/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;

  double logoScale = 1.0;
  Ticker? _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_animate)..start();

    Future.delayed(Duration(seconds: 5), () {
      _checkUserSession();
    });
  }

  void _animate(Duration timeElapsed) {
    setState(() {
      logoScale = 1.0 + 0.2 * (1 + timeElapsed.inMilliseconds / 500 % 2);
    });
  }

  void _checkUserSession() {
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedScale(
          duration: Duration(milliseconds: 500),
          scale: logoScale,
          child: SvgPicture.asset('./assets/logo.svg', height: 150, width: 100),
        ),
      ),
    );
  }
}
