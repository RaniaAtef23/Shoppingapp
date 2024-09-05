
import 'package:flutter/material.dart';
import 'package:shopping_app/features/authentication/create_account_view.dart';

class Create_account_body extends StatefulWidget {
  const Create_account_body({super.key});

  @override
  _Create_account_bodyState createState() => _Create_account_bodyState();
}

class _Create_account_bodyState extends State<Create_account_body> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstController =TextEditingController();
  final TextEditingController _secondController =TextEditingController();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _isFirstNameValid = false;
  bool _isLastNameValid = false;
  bool _isUsernameValid = false;
  bool _isPhonenumberValid=false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _firstController.dispose();
    _secondController.dispose();

    super.dispose();
  }

  bool _isFormValid() {
    return _isFirstNameValid && _isLastNameValid && _isUsernameValid && _isPasswordValid && _isEmailValid&&_isPhonenumberValid;
  }

  void _validatePassword(String value) {
    // Password should contain at least one letter and one number
    setState(() {
      _isPasswordValid = value.isNotEmpty && value.contains(RegExp(r'(?=.*[a-zA-Z])(?=.*\d)'));
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _isEmailValid = value.isNotEmpty && value.contains('@gmail.com');
    });
  }
  void _validateFirstName(String value) {
    setState(() {
      _isFirstNameValid = value.isNotEmpty;
    });
  }

  void _validateLastName(String value) {
    setState(() {
      _isLastNameValid = value.isNotEmpty;
    });
  }

  void _validateUsername(String value) {
    setState(() {
      _isUsernameValid = value.isNotEmpty;
    });
  }
  void _validatePhonenumber(String value) {
    setState(() {
      _isPhonenumberValid = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      /* appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ListView(),
                ),
              ); // Navigate back to the previous page
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.orangeAccent),
          ),
        ),

        */
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: ListView(

          children: [


            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>const Login_view() ));
                    },
                    child: const Icon(Icons.arrow_back_ios,color: Colors.orange,),

                  ),
                ],
              ),
            ),

            Image.asset(
              "assets/register.gif",
              width: 200,
              height: 200,
            ),
            const Text(
              "Let's Create Your Account......",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: _validateFirstName,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isFormValid() ? Colors.orange : Colors.orange, // Set border color to primary if form is valid, else red
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isFormValid() ? Colors.orange : Colors.orange, // Set border color to primary if form is valid, else red
                        ),
                      ),
                      hintText: "First Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      labelText: "First Name",
                      labelStyle: const TextStyle(
                          color: Colors.orange),
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    onChanged: _validateLastName,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isFormValid() ? Colors.orange : Colors.orange, // Set border color to primary if form is valid, else red
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isFormValid() ? Colors.orange : Colors.orange, // Set border color to primary if form is valid, else red
                        ),
                      ),
                      hintText: "Last Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      labelText: "Last Name",
                      labelStyle: const TextStyle(
                          color: Colors.orange),
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: _validateUsername,
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ?Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ?Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                hintText: "Username",
                prefixIcon: const Icon(
                  Icons.perm_contact_cal_rounded,
                  color: Colors.grey,
                ),
                labelText: "Username",
                labelStyle: const TextStyle(
                    color: Colors.orange),
              ),
              cursorColor: Colors.orangeAccent,
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: _validatePhonenumber,
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPhonenumberValid ? Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPhonenumberValid ? Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                hintText: "PhoneNumber",
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                labelText: "PhoneNumber",
                labelStyle: const TextStyle(
                    color: Colors.orange),
              ),
              cursorColor: Colors.orangeAccent,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              onChanged: _validateEmail, // Validate email on each change
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ? Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ? Colors.orange : Colors.red, // Set border color to primary if email is valid, else red
                  ),
                ),
                hintText: "E-Mail",
                suffixIcon: _isEmailValid
                    ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
                    : null,
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                labelText: "E-Mail",
                labelStyle: const TextStyle(
                    color: Colors.orange),
              ),
              cursorColor: Colors.orangeAccent,
            ),
            if (!_isEmailValid)
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "email should contain example@gmail.com",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              onChanged: _validatePassword, // Validate password on each change
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPasswordValid ? Colors.orange: Colors.red, // Set border color to primary if password is valid, else red
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPasswordValid ? Colors.orange: Colors.red, // Set border color to primary if password is valid, else red
                  ),
                ),
                hintText: "Password",
                suffixIcon: _isPasswordValid
                    ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
                    : null,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                labelText: "Password",
                labelStyle: const TextStyle(
                    color: Colors.orange),
              ),
              cursorColor: Colors.orangeAccent,
              obscureText: true,
            ),
            if (!_isPasswordValid)
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "password should contain letters and numbers...",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: double.infinity,
              height: 40,
              onPressed: () {
                if (_isEmailValid && _isPasswordValid&&_isFirstNameValid&&_isLastNameValid&&_isUsernameValid&&_isPhonenumberValid) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login_view()),
                  );
                }

              },
              color: Colors.orangeAccent,
              child: const Text(
                "Create Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

    );
  }
}