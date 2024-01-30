import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants.dart';
import '../util/router.dart';
import '../util/sesstion_settings.dart';
import 'home.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool enabled = FileDownloader().isLogEnabled;
  // final SessionSettings settings = SessionSettings();
  // int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("sss"),
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
