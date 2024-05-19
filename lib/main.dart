import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mebook/util/storeageService.dart';


import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:mebook/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/splash.dart';
import 'screens/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mebooks',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Start(),
    );
  }
}
