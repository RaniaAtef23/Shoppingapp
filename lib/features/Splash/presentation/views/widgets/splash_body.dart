import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Splash/presentation/views/Onboarding_view.dart';
import '../../../../../core/utils/app_router.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Timer(const Duration(seconds: 1), () {
      _controller.forward();
    });

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.onboardingView);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo.gif",
                width: screenWidth * 0.5,
                height: screenHeight * 0.3,
              ),
            ),
            const SizedBox(height: 10),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.grey,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Shopping App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
