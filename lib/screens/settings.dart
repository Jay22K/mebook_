import 'dart:developer';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mebook/screens/start.dart';

import '../constants.dart';
import '../util/router.dart';

import '../util/storeageService.dart';
import 'components/customAlertDialog.dart';
import 'components/snackBar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool enabled = FileDownloader().isLogEnabled;
  // final SessionSettings settings = SessionSettings();
  // int _selectedIndex = 2;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 final storageService = StorageService();
  String username = '';
  String userphotoURL = '';

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    final storageService = StorageService();

    // Retrieve the data asynchronously
    final retrievedUsername = await storageService.getString('userName');
    final retrievedUserPhotoURL =
        await storageService.getString('userphotoURL');

    // Update the state after the asynchronous calls are completed
    setState(() {
      username = retrievedUsername!;
      userphotoURL = retrievedUserPhotoURL!;
    });

    log(username);
    log(userphotoURL);
  }

  void _signOut(BuildContext context) async {
    await _auth.signOut();
    final storageService = StorageService();

    // Clear all SharedPreferences
    //navigate to the login screen or show a message

    CustomAlertDialog(
      title: "Confirm Logout",
      content: "Are you sure you want to Logout your account?",
      cancelText: "Cancel",
      deleteText: "Logout",
      onDelete: () {
        // Handle delete action
        storageService.clear();
        Navigator.of(context).pop();
        MyRouter.pushPageReplacement(context, Start());
      },
    ).show(context);
  }

  void _deleteAccountConfirm(BuildContext context) async {
    CustomAlertDialog(
      title: "Confirm Deletion",
      content:
          "Are you sure you want to delete your account? This action cannot be undone",
      cancelText: "Cancel",
      deleteText: "Delete",
      onDelete: () {
        // Handle delete action

        Accountdelete(context);
  
      },
    ).show(context);
  }

  void Accountdelete(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        storageService.clear();
        Navigator.of(context).pop(); // Close the dialog if it's open
        showCustomSnackBar(context, "Account deleted successfully.");
        // Example: Navigate to a different screen after deleting account
        MyRouter.pushPageReplacement(context, Start());
      }
    } catch (e) {
      // Navigator.of(context).pop(); // Close the dialog if it's open
      showCustomSnackBar(
          context, "Failed to delete account. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: kSecondColor, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // user card
            SmallUserCard(
              cardColor: kSecondColor,
              userName: username,
              userProfilePic: NetworkImage(userphotoURL),
              onTap: () {},
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title:
                      'Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance',
                  subtitle:
                      "Make Ziar'App yours Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance Appearance",
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Privacy',
                  subtitle: "Lock Ziar'App to improve your privacy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () => _signOut(context),
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.repeat,
                  title: "Change email",
                ),
                SettingsItem(
                  onTap: () => _deleteAccountConfirm(context),
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // String convertCamelCaseToText(final String text) {
  //   if (text.isEmpty) return text;
  //   StringBuffer buffer = StringBuffer();
  //   buffer.write(text[0].toUpperCase());
  //   for (var i = 1; i < text.length; i++) {
  //     if (text[i] == text[i].toUpperCase()) {
  //       buffer.write(' ');
  //     }
  //     buffer.write(text[i]);
  //   }
  //   return buffer.toString();
  // }
}
