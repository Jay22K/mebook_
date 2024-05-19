import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mebook/screens/components/toast.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../util/storeageService.dart';
import 'components/snackBar.dart';

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final storageService = StorageService();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      ToastShow(msg: e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: Center(
          child: SocialLoginButton(
            borderRadius: 30,
            text: 'Sign in',
            fontSize: 18,
            buttonType: SocialLoginButtonType.google,
            onPressed: () async {
              User? user = await _signInWithGoogle();
              if (user != null) {
                await storageService.saveString(
                    'userName', user.displayName.toString());
                await storageService.saveString(
                    'userEmail', user.email.toString());
                await storageService.saveString(
                    'userphotoURL', user.photoURL.toString());
                await storageService.saveString('uid', user.uid.toString());
      
                log(user.toString());
                showCustomSnackBar(context, "Sign-in successful!");
              }
            },
            mode: SocialLoginButtonMode.single,
          ),
        ),
      ),
    );
  }
}
