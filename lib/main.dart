import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mebook/screens/auths_screen.dart';
import 'package:mebook/util/storeageService.dart';


import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:mebook/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/splash.dart';
import 'screens/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  final storageService = StorageService();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mebooks',
      theme: _isDarkMode ? darkTheme() : lightTheme(),
      home: Start(),
    );
  }
}
