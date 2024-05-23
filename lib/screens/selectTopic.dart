import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../util/router.dart';
import '../util/storeageService.dart';
import 'components/snackBar.dart';
import 'dashboard.dart';

class TopicSelectionScreen extends StatefulWidget {
  final String uid;

  TopicSelectionScreen({required this.uid});

  @override
  _TopicSelectionScreenState createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen> {
  List<String> topics = [
    "Geography",
    "Biology",
    "Law",
    "Literature",
    "Physics",
    "Technology",
    "CS",
    "Economy",
    "Linguistics",
    "Housekeeping, leisure",
    "Education",
    "Mathematics",
    "Jurisprudence",
    "Other Social Sciences",
    "Geology",
    "Religion",
    "Psychology",
    "Art",
    "Science (General)",
    "Business",
    "Chemistry",
    "Physical Educ. and Sport",
    "Computers",
    "Medicine",
    "History"
  ];

  Set<String> selectedTopics = Set<String>();
  final storageService = StorageService();

  bool _isLoading = false;

  Future<void> registerUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          'selectedTopics': selectedTopics.toList(),
        });
        setState(() {
          _isLoading = false;
        });
        MyRouter.pushPageReplacement(context, DashboardScreen());
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('Error registering user: $e');
      showCustomSnackBar(context, "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Topic Selection'),
      //   backgroundColor: Colors.green,
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60.0),
              Expanded(
                flex: 0,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Select up to 3 interest",
                      style: TextStyle(fontFamily: 'Utopia', fontSize: 25),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'You can change these later',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Work_Sans", fontSize: 18.5),
                  )),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: topics.map((topic) {
                  bool isSelected = selectedTopics.contains(topic);
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          selectedTopics.remove(topic);
                        } else {
                          if (selectedTopics.length < 3) {
                            selectedTopics.add(topic);
                          } else {
                            // Show a snackbar or alert that only 3 topics are allowed.
                            showCustomSnackBar(
                                context, 'You can only select up to 3 topics.');
                          }
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isSelected
                          ? kPrimaryColor.withOpacity(0.8)
                          : Colors.white,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    child: Text(
                      topic,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Handle the selected topics

                  log("Selected Topics: $selectedTopics");
                  registerUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Utopia'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
