// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_fap/components/button.dart';
import 'package:no_fap/components/sign_in_tile.dart';
import 'package:no_fap/components/textfield.dart';
import 'package:no_fap/constants.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final unController = TextEditingController();

  final emController = TextEditingController();

  final pwController = TextEditingController();

  final cpwController = TextEditingController();

  //register method
  Future<void> register(String email, String password, String username) async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.brown,
          ),
        );
      },
    );

    //try to register the user
    try {
      if (pwController.text == cpwController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emController.text,
          password: pwController.text,
        );

        //get the user ID
        User? user = userCredential.user;

        if (user != null) {
          //store user data in firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'username': username,
            'email': email,
          });
        }
      } else {
        showErrorMessage("Passwords don't match");
      }

      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                //logo
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'lib/assets/images/coffee-cup.png',
                    height: 40,
                  ),
                ),
                const SizedBox(height: 20),
                //heading
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                //username field
                MyTextField(
                  labelText: 'Username',
                  controller: unController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //email field
                MyTextField(
                  labelText: 'Email',
                  controller: emController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //password field
                MyTextField(
                  labelText: 'Password',
                  controller: pwController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  labelText: 'Confirm Password',
                  controller: cpwController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Already a member? ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //button
                MyButton(
                  onTap: () {
                    register(
                      emController.text,
                      pwController.text,
                      unController.text,
                    );
                  },
                  text: "Sign Up",
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or Sign Up Quick",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //sign in with google
                    SignInTile(
                      imagePath: 'lib/assets/images/google.png',
                    ),
                    SizedBox(width: 10),
                    //sign in with apple
                    SignInTile(
                      imagePath: 'lib/assets/images/apple-logo.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
