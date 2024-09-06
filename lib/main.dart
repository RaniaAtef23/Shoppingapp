import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/core/network/service_locator.dart';
import 'features/Home/presentation/views/MainScreen.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(390, 844), // Specify the design size
    builder: (context, child) {
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(
            Theme
                .of(context)
                .textTheme,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const SafeArea(child: MainScreen()),
      );
    }
    );
  }
}
