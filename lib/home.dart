import 'package:fitness_app/start_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool logInButtonClicked = false;
  bool signUpButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _buildButton(
                    label: 'Log In',
                    onPressed: () {
                      setState(() {
                        logInButtonClicked = true;
                        signUpButtonClicked = false;
                      });
                      _handleGoogleSignIn(context); // Pass context here
                    },
                    clicked: logInButtonClicked,
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between the buttons
                Expanded(
                  flex: 1,
                  child: _buildButton(
                    label: 'Sign Up',
                    onPressed: () {
                      setState(() {
                        signUpButtonClicked = true;
                        logInButtonClicked = false;
                      });
                      _handleGoogleSignIn(context); // Pass context here
                    },
                    clicked: signUpButtonClicked,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool clicked,
  }) {
    return Container(
      width: 45, // 45% of the screen width
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: clicked ? Colors.white : Colors.black,
          backgroundColor: clicked ? Colors.black : Colors.white,
          side: const BorderSide(color: Colors.black),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: clicked ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          // Successfully signed in with Google
          // Redirect to the start screen
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => StartScreen()),
          //);
          if (kDebugMode) {
            print('Google Sign-In Successful! User ID: ${user.uid}');
          }
        } else {
          // Handle sign-in error
          if (kDebugMode) {
            print('Google Sign-In Failed!');
          }
        }
      } else {
        // Handle sign-in error
        if (kDebugMode) {
          print('Google Sign-In Failed!');
        }
      }
    } catch (e) {
      // Handle sign-in error
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      // Revert button colors after a short delay
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        logInButtonClicked = false;
        signUpButtonClicked = false;
      });
    }
  }
}