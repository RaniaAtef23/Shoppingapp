import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Splash/data/onboarding_model.dart';
import 'package:shopping_app/features/authentication/create_account_view.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState(categories: []);
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController controller;
  final List<Category> categories;

  _OnboardingState({required this.categories});

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: currentIndex > 0
            ? IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
          ),
          onPressed: () {
            controller.previousPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn,
            );
            setState(() {
              currentIndex--;
            });
          },
        )
            : null,
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, left: screenWidth * 0.1, right: screenWidth * 0.1),
                child: Image.asset(
                  contents[i].image,
                  width: screenWidth * 0.5, // 50% of screen width
                  height: screenWidth * 0.5, // 50% of screen width
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, left: screenWidth * 0.1, right: screenWidth * 0.1),
                child: Text(
                  contents[i].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.08, // 10% of screen width
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: EdgeInsets.only(top: 2, left: screenWidth * 0.1, right: screenWidth * 0.1),
                child: Text(
                  contents[i].description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 5% of screen width
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                      (index) => Container(
                    height: screenHeight * 0.013, // Height of the indicator is 1% of screen height
                    width: currentIndex == index ? screenWidth * 0.045 : screenWidth * 0.03, // Width is 5% for the active indicator and 3% for inactive
                    margin: EdgeInsets.only(right: screenWidth * 0.02), // Margin is 2% of screen width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Container(
                height: screenHeight * 0.06, // 6% of screen height
                width: double.infinity,
                margin: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login_view(),
                        ),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceIn,
                      );
                      setState(() {
                        currentIndex++;
                      });
                    }
                  },
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  child: Text("Next", style: TextStyle(
                    fontSize: screenWidth * 0.05
                  ),),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.grey, letterSpacing: 2, fontWeight: FontWeight.w700, fontSize: screenWidth * 0.05),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login_view()));
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
