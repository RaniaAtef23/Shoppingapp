
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/core/network/service_locator.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/HomeView.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/MainScreen.dart';
import 'package:shopping_app/features/Splash/presentation/SCreens/Splash_view.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const MainScreen(),

      );
  }
}