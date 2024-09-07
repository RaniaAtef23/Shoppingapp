import 'package:flutter/material.dart';
import 'package:shopping_app/features/Categories/data/models/Category.dart';
import 'package:shopping_app/features/Splash/data/onboarding_model.dart';
import '../../../../../core/utils/app_router.dart';

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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Image.asset(
                  contents[i].image,
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Text(
                  contents[i].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.08,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Text(
                  contents[i].description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
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
                    height: screenHeight * 0.013,
                    width: currentIndex == index ? screenWidth * 0.045 : screenWidth * 0.03,
                    margin: EdgeInsets.only(right: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Container(
                height: screenHeight * 0.06,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 20),
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
                      Navigator.pushNamed(context, Routes.loginView);
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
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
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
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.loginView);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
