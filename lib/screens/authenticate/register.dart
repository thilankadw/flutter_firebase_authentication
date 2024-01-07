import 'package:firebase_auth_test/services/auth.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/description.dart';
import '../../const/styles.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //ref for the AuthServices class
  final AuthServices _auth = AuthServices();

  //form key
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          title: const Text(
            "Register",
            style: TextStyle(color: white),
          ),
          backgroundColor: bgBlack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  description,
                  style: descriptionStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/man.png",
                    height: 120,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email
                        TextFormField(
                          style: const TextStyle(color: white),
                          decoration: inputFieldDecoration,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter an email address.";
                            }

                            // Using RegExp for a valid email format
                            RegExp emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                            );

                            if (!emailRegex.hasMatch(val)) {
                              return "Enter a valid email address.";
                            }

                            return null;
                          },
                          onChanged: (val) {
                            print("Email: $val");
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //password
                        TextFormField(
                          style: const TextStyle(color: white),
                          decoration: inputFieldDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val!.length < 6
                              ? "Enter a valid password."
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),

                        //error text
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Login with Google",
                          style: descriptionStyle,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          child: Center(
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 50,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: mainBlue,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          onTap: () async {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Register error.";
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: bgBlack,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: mainYellow),
                            ),
                            child: const Center(
                              child: Text(
                                "REGISTER",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
