import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shopping_app/features/Splash/presentation/views/widgets/onboarding_body.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LiquidSwipe(
        pages: [
          // First page with the splash image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.yellow, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/splash.png',
                width: screenWidth * 0.8, // Adjust width to 80% of screen width
                height: screenHeight * 0.4, // Adjust height to 40% of screen height
                fit: BoxFit.cover, // Cover the container while maintaining aspect ratio
              ),
            ),
          ),
          // Onboarding view as the second page
          const Onboarding(),
        ],
        enableLoop: false, // Disable looping if you want to go directly to onboarding_view
        fullTransitionValue: 300, // Customize this value as needed
      ),
    );
  }
}
