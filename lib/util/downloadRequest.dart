import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../screens/components/toast.dart';

class FileDownloaderService {
  Future<void> requestDownload(String url, String name, BuildContext context) async {
    FileDownloader.downloadFile(
      url: url,
      downloadDestination: DownloadDestinations.appFiles,
      notificationType: NotificationType.all,
      onProgress: (name, progress) {
        debugPrint("file name : $name");
        debugPrint('Progress: $progress%');
      },
      onDownloadCompleted: (path) {
        debugPrint("downloaded to : $path");
        ToastShow(msg: 'Downloading Successful..!').showToast(context);
      },
      onDownloadError: (error) {
        debugPrint('Download error: $error');
        ToastShow(msg: 'Downloading is canceled or failed due to network issues')
            .showToast(context);
      },
    ).then((file) {
      debugPrint('file path: ${file?.path}');
    });

    debugPrint("book URL : $url");
  }
}


