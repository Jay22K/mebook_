import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../constants.dart';


class BookShelfScreen extends StatefulWidget {
  const BookShelfScreen({super.key});

  @override
  _BookShelfScreenState createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  List<File> files = [];
  int _pageNumber = 1; // Change the page number as needed
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getFilesList();
  }

  Future<void> getFilesList() async {
    Directory directory = Directory(
        'storage/emulated/0/Android/data/com.example.mebook/files/data/user/0/com.example.mebook/files/');
    List<FileSystemEntity> fileList = directory.listSync();

    List<File> tempFiles = [];
    for (FileSystemEntity file in fileList) {
      if (file is File) {
        tempFiles.add(file);
      }
    }

    setState(() {
      files = tempFiles;
    });
  }

  IconData getFileIcon(String path) {
    IconData iconData;
    if (path.endsWith('.txt')) {
      iconData = Icons.description; // Use your preferred icon for text files
    } else if (path.endsWith('.pdf')) {
      iconData = Icons.picture_as_pdf; // Use your preferred icon for PDFs
    } else if (path.endsWith('.jpg') ||
        path.endsWith('.png') ||
        path.endsWith('.jpeg')) {
      iconData = Icons.image; // Use your preferred icon for images
    } else {
      iconData = Icons.insert_drive_file; // Default icon for other file types
    }
    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('Downloaded Books'),
      ),
      body: files.isEmpty
          ? Center(
              child: Text('No files found'),
            )
          : StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(8.0),
            crossAxisCount: 2, // Number of columns
            physics: BouncingScrollPhysics(),
            itemCount: files.length,
            // reverse: true,
            staggeredTileBuilder: (int index) =>
                StaggeredTile.fit(1), // Tile size, here 1 means full width
            mainAxisSpacing: 8.0, // Spacing between rows
            crossAxisSpacing: 8.0, // Spacing between columns
            itemBuilder: (BuildContext context, int index) {
              IconData iconData = getFileIcon(files[index].path);

              log(files[index].path); // this is path of pdf
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Handle file tap action here
                      log(files[index].path); // this is path of pdf
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(iconData, size: 50),

                        Container(
                          height: 185,
                          child: Center(
                            child:
                                // _isLoading
                                //     ? CircularProgressIndicator()
                                //     :
                                iconData == Icons.picture_as_pdf
                                    ? PDFView(
                                        filePath:
                                            files[index].path.toString(),
                                        enableSwipe:
                                            false, // Enables swiping to change pages
                                        autoSpacing:
                                            true, // Adjust spacing automatically
                                        pageFling:
                                            true, // Allows flinging to change pages
                                        pageSnap:
                                            true, // Snaps to the nearest page
                                        defaultPage:
                                            0, // Set the default page index
                                        fitPolicy: FitPolicy
                                            .WIDTH, // Set the fit policy
                                      )
                                    : Icon(iconData, size: 50),
                            // add pdf Widget show pdf 1st page...
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          files[index].path.split('/').last,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
