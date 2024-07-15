// ignore_for_file: use_build_context_synchronously

import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/components/my_textfield.dart';
import 'package:auth_app/components/square_tile.dart';
import 'package:auth_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      },
    );
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message popup
  void showErrorMessage(String message) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Lottie.asset('assets/animations/welcome.json'),

                const SizedBox(
                  height: 20,
                ),
                //Welcome text
                Text(
                  'Welcome back, we missed you',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //username field
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                //forgot password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign  in button
                MyButton(
                  onTap: signUserIn,
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 15,
                ),
                // or continue
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //google and apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //apple
                    SquareTile(
                      onTap: () {},
                      imagePath: 'assets/images/apple.png',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
