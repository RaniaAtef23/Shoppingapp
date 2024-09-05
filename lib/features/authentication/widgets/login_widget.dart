import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/MainScreen.dart';
import 'package:shopping_app/features/authentication/screens/login_view.dart';
import '../screens/create_account_view.dart';


class Login_body extends StatefulWidget {
  const Login_body({super.key});

  @override
  State<Login_body> createState() => _LoginState();
}

class _LoginState extends State<Login_body> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _isPasswordValid && _isEmailValid;
  }

  void _validatePassword(String value) {
    setState(() {
      _isPasswordValid = value.isNotEmpty && value.contains(RegExp(r'(?=.*[a-zA-Z])(?=.*\d)'));
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _isEmailValid = value.isNotEmpty && value.contains('@gmail.com');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20),
              child: Text(
                "Welcome Back,",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Discover Limitless Choices",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _emailController,
                          onChanged: _validateEmail,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "Email",
                            suffixIcon: _isEmailValid
                                ? const Icon(Icons.check, color: Colors.green)
                                : null,
                            prefixIcon: const Icon(Icons.email, color: Colors.black),
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.orange),
                          ),
                          cursorColor: Colors.orangeAccent,
                        ),
                      ),
                      if (!_isEmailValid)
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Enter a valid Email...",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _passwordController,
                          onChanged: _validatePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "Password",
                            suffixIcon: _isPasswordValid
                                ? const Icon(Icons.check, color: Colors.green)
                                : null,
                            prefixIcon: const Icon(Icons.lock, color: Colors.black),
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.orange),
                          ),
                          cursorColor: Colors.orangeAccent,
                        ),
                      ),
                      if (!_isPasswordValid)
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Enter a valid Password...",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25, top: 10, bottom: 40),
                        child: Text(
                          "forgot password?",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                      // Login Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () {
                              if (_isEmailValid && _isPasswordValid) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                );
                              }
                            },
                            color: Colors.orangeAccent,
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Skip Button

                      // Register Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have An Account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Create_account(),
                                ),
                              );
                            },
                            child: const Text(
                              "Register Now",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(), // Adjust the target screen as needed
                                ),
                              );
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(color: Colors.orange,fontSize: 20, ),

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}