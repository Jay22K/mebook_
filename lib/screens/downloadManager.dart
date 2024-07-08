import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'components/toast.dart';

class downloadManager extends StatefulWidget with WidgetsBindingObserver {
  @override
  _downloadManagerState createState() => _downloadManagerState();
}

class _downloadManagerState extends State<downloadManager> {
  final _urls = [
    'https://file-examples.com/wp-content/storage/2017/10/file-sample_150kB.pdf',
    'https://firebasestorage.googleapis.com/v0/b/test-icurves.appspot.com/o/IntroScreenMediaContent%2Fandroid_apps.jpg?alt=media&token=e02ff99f-d4cf-4756-a782-69d5187af200',
    'https://firebasestorage.googleapis.com/v0/b/test-icurves.appspot.com/o/IntroScreenMediaContent%2Fandroid_apps.jpg?alt=media&token=e02ff99f-d4cf-4756-a782-69d5187af200',
    'https://firebasestorage.googleapis.com/v0/b/test-icurves.appspot.com/o/IntroScreenMediaContent%2Fandroid_apps.jpg?alt=media&token=e02ff99f-d4cf-4756-a782-69d5187af200',
    'https://firebasestorage.googleapis.com/v0/b/test-icurves.appspot.com/o/IntroScreenMediaContent%2Fandroid_apps.jpg?alt=media&token=e02ff99f-d4cf-4756-a782-69d5187af200',
    'https://firebasestorage.googleapis.com/v0/b/test-icurves.appspot.com/o/IntroScreenMediaContent%2Fandroid_apps.jpg?alt=media&token=e02ff99f-d4cf-4756-a782-69d5187af200',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online links'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Downloads'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _urls.length,
          itemBuilder: (BuildContext context, int i) {
            String _fileName = 'File ${i + 1}';
            return Card(
              elevation: 10,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_fileName),
                      ),
                      RawMaterialButton(
                        textStyle: TextStyle(color: Colors.blueGrey),
                        onPressed: () => requestDownload(_urls[i], _fileName),
                        child: Icon(Icons.file_download),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> requestDownload(String _url, String _name) async {
    FileDownloader.downloadFile(
    url: _url,
    downloadDestination: DownloadDestinations.appFiles,
    notificationType: NotificationType.all,
    
    onProgress: (name, progress) {
      log("file name : " + name.toString());
      log('Progress: $progress%');
    },
    onDownloadCompleted: (path) {
      log("downloaded to : " + path.toString());
      ToastShow(msg: 'Downloading Successful..!').showToast(context);
    },
    onDownloadError: (error) {
      log('Download error: $error');
      ToastShow(msg: 'Downloading is canceled or failed due to network issues')
          .showToast(context);
    },
  ).then((file) {
    debugPrint('file path: ${file?.path}');
  });

  log("book URL : " + _url);
  }
}
