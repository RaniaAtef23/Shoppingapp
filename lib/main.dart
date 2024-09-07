import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/core/network/service_locator.dart';
import 'package:shopping_app/core/utils/app_router.dart';
import 'package:shopping_app/features/Home/presentation/views/HomeView.dart';
import 'package:shopping_app/features/Home/presentation/views/MainScreen.dart';
import 'package:shopping_app/features/Splash/presentation/views/Splash_view.dart';

void main() {
  setup(); // Initializes any services or dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Specify the design size for responsiveness
      builder: (context, child) {
        return MaterialApp(
          initialRoute: Routes.homeView, // Initial route for the app
          onGenerateRoute: Routes.generateRoute, // Generate routes dynamically
          debugShowCheckedModeBanner: false, // Disable the debug banner
          theme: ThemeData(
            textTheme: GoogleFonts.comfortaaTextTheme(
              Theme.of(context).textTheme, // Apply Google Fonts 'Comfortaa'
            ),
            scaffoldBackgroundColor: Colors.white, // Set background color to white
          ),
        );
      },
    );
  }
}
