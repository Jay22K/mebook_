import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mebook/screens/selectTopic.dart';
import 'package:mebook/screens/signin_screen.dart';
import 'package:mebook/util/router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../constants.dart';
import '../util/storeageService.dart';
import 'components/snackBar.dart';
import 'components/toast.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final storageService = StorageService();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.00),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 78, vertical: 15),
                    child: SocialLoginButton(
                      borderRadius: 30,
                      text: 'Sign Up',
                      fontSize: 18,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () async {
                        User? user = await _signInWithGoogle();
                        if (user != null) {
                          // Handle successful sign-in
                          log('Signed in as ${user.displayName}');
                          log('Signed in as ${user}');
                          await storageService.saveString(
                              'userName', user.displayName.toString());
                          await storageService.saveString(
                              'userEmail', user.email.toString());
                          await storageService.saveString(
                              'userphotoURL', user.photoURL.toString());
                          await storageService.saveString(
                              'uid', user.uid.toString());
                          showCustomSnackBar(context, "Sign-up successful!");
                          MyRouter.pushPageReplacement(
                              context, TopicSelectionScreen());
                        }
                      },
                      mode: SocialLoginButtonMode.single,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle log in navigation
                      MyRouter.pushPageReplacement(context, SignInScreen());
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account yet? ',
                        style: TextStyle(
                            color: Colors
                                .black54), // Default style for the first part
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              color: kPrimaryColor, // Custom color for "Log In"
                              fontWeight:
                                  FontWeight.bold, // Optional: make it bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
