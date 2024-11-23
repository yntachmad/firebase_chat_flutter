import 'package:firebase_chat/controllers/signup_controller.dart';
import 'package:firebase_chat/screens/dashboard_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("SignUp"),
      // ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Form(
            key: userForm,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Address is required';
                      }

                      String emailFormat =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(emailFormat);

                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Email Address'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: Text('password'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: country,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Country is required';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Country'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                            if (userForm.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              await SignupController.createAccount(
                                context: context,
                                email: email.text,
                                password: password.text,
                                name: name.text,
                                country: country.text,
                              );
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          child: isLoading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text("Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
