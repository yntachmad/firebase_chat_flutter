import 'package:firebase_chat/controllers/login_controller.dart';
import 'package:firebase_chat/screens/dashboard_screen.dart';
import 'package:firebase_chat/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userLoginForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login Screen"),
      // ),
      body: Form(
        key: userLoginForm,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  label: Text("password"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      onPressed: () async {
                        if (userLoginForm.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          await LoginController.loginAccount(
                              context: context,
                              email: email.text,
                              password: password.text);

                          isLoading = false;
                          setState(() {});
                        }
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const DashboardScreen(),
                        //     ), (route) {
                        //   return false;
                        // });
                      },
                      child: isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text("Sign In"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Don't have account ?"),
                    Text(
                      "Sign Up here",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[300]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
