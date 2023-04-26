import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _changePage = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _changePage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
                const HomeScreen(),
        if (!_changePage)
          FadeOut(
            delay: const Duration(milliseconds: 2600),
            duration: const Duration(milliseconds: 300),
            child: Scaffold(
              body: const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Text(
                    'Catbreeds',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              floatingActionButton: Image.asset(
                'assets/images/image-cat.png',
                width: 130,
              ),
              floatingActionButtonAnimator: null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          ),

      ],
    );
  }
}
