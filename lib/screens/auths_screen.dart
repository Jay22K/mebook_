import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mebook/screens/selectTopic.dart';
import 'package:mebook/util/router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:video_player/video_player.dart';

import '../constants.dart';
import '../util/storeageService.dart';
import 'components/snackBar.dart';
import 'components/toast.dart';
import 'dashboard.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final storageService = StorageService();

  late VideoPlayerController _controller;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/bakground.mp4')
      ..initialize().then((_) {
        setState(
            () {}); // Ensure the first frame is shown after the video is initialized
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _stopVideo() {
    _controller.pause();
    _controller.seekTo(Duration.zero);
  }

  Future<User?> _signUpWithGoogle(BuildContext context) async {
    // Start the Google sign-in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // If the user successfully signed in with Google
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        // Sign in with the credential (signs up if the user doesn't exist)
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        // If user is successfully authenticated
        if (user != null) {
          // Save user details to storage
          await storageService.saveString('userName', user.displayName ?? '');
          await storageService.saveString('userEmail', user.email ?? '');
          await storageService.saveString('userphotoURL', user.photoURL ?? '');
          await storageService.saveString('uid', user.uid);

          // Determine if the user is signing up or signing in
          bool isNewUser =
              userCredential.additionalUserInfo?.isNewUser ?? false;
          String message = isNewUser ? "Sign-up successful!" : "Welcome back!";

// Show a custom snack bar with the welcome message
          showCustomSnackBar(context, message);

          if (isNewUser) {
            // Navigate to a different screen for new users
            MyRouter.pushPageReplacement(
              context,
              TopicSelectionScreen(uid: user.uid), // Pass the uid here
            );
          } else {
            // Check if the user's Firestore data includes selectedTopics
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get()
                .then((DocumentSnapshot snapshot) async {
              if (snapshot.exists) {
                Map<String, dynamic>? userData =
                    snapshot.data() as Map<String, dynamic>?;

                if (userData != null &&
                    userData.containsKey('selectedTopics')) {
                  List<String> selectedTopics =
                      List<String>.from(userData['selectedTopics']);

                  await storageService.saveStringList(
                      'selectedTopics', selectedTopics.toList());
                  MyRouter.pushPageReplacement(
                    context,
                    DashboardScreen(uid: user.uid, topics: selectedTopics),
                  );
                } else {
                  // If 'selectedTopics' is not present or is null, navigate to topic selection screen
                  MyRouter.pushPageReplacement(
                    context,
                    TopicSelectionScreen(uid: user.uid),
                  );
                }
              } else {
                // Handle the case where the document does not exist
                log('User document does not exist');
              }
            }).catchError((error) {
              // Handle errors such as permission denied, network issues, etc.
              log('Error fetching user data: $error');
            });
          }
        }

        return user;
      } catch (e) {
        // Handle any errors during the sign-in process
        showCustomSnackBar(context, "Error: ${e.toString()}");
        return null;
      }
    }

    // If the Google sign-in was cancelled or failed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            _controller.value.isInitialized
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            // Foreground content
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        spreadRadius: 60,
                        blurRadius: 50,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Find Best Books With Me',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      _isLoading
                          ? CircularProgressIndicator()
                          : SocialLoginButton(
                              borderRadius: 30,
                              fontSize: 18,
                              buttonType: SocialLoginButtonType.google,
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                User? user = await _signUpWithGoogle(context);
                                setState(() {
                                  _isLoading = false;
                                  _stopVideo();
                                });

                                if (user != null) {
                                  // Handle successful sign-in
                                  log('Signed Up as ${user.displayName}');
                                  log('Signed Up as ${user}');
                                }
                              },
                              mode: SocialLoginButtonMode.multi,
                            ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
