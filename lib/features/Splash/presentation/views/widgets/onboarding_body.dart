
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Splash/data/onboarding_model.dart';
import 'package:shopping_app/features/authentication/create_account_view.dart';


class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  _onboardingState createState() => _onboardingState(categories: []);
}

class _onboardingState extends State<onboarding> {
  int currentIndex = 0;
  late PageController controller;
  final List<Category> categories;

  _onboardingState({required this.categories});

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: currentIndex > 0
            ? IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.orange
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
                padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
                child: Image.asset(
                  contents[i].image,
                  width: 180,
                  height: 180,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
                child: Text(
                  contents[i].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 40, right: 40),
                child: Text(
                  contents[i].description,
                  style: const TextStyle(
                    fontSize: 18,
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
                    height: 10,
                    width: currentIndex == index ? 20 : 10,
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: index == currentIndex
                          ? Colors.orange[800]
                          : Colors.orange[800],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Container(
                height: 40,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
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
                child:
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const Login_view(),
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
                  child: const Text("Next"),
                ),




              ),
              const SizedBox(height: 20,),
              Container(
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    MaterialButton(
                        child: const Text("Skipe",style: TextStyle(color: Colors.grey,letterSpacing: 2,fontWeight: FontWeight.bold),)
                        ,onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login_view()));
                    }
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