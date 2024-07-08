import 'package:flutter/material.dart';
import 'package:al_downloader/al_downloader.dart';

class downloadManager extends StatefulWidget {
  const downloadManager({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<downloadManager> createState() => _downloadManagerState();
}

class _downloadManagerState extends State<downloadManager> {
  @override
  void initState() {
    super.initState();

    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(fit: StackFit.expand, children: [
        Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text('You are testing batch download',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Expanded(child: theListview)
            ]),
        Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 10,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: theActionLists
                    .map((e) => Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                minWidth: 20,
                                height: 50,
                                color: Colors.blue,
                                textTheme: ButtonTextTheme.primary,
                                onPressed: e[1],
                                child: Text(
                                  e[0],
                                  style: const TextStyle(fontSize: 10),
                                )))))
                    .toList()))
      ]),
    );
  }

  /// Core data in listView
  get theListview => ListView.separated(
        padding: EdgeInsets.only(
            top: 20, bottom: MediaQuery.of(context).padding.bottom + 75),
        shrinkWrap: true,
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          final model = models[index];
          final order = index + 1;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$order',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.url,
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                    )),
                SizedBox(
                    height: 30,
                    child: Stack(fit: StackFit.expand, children: [
                      LinearProgressIndicator(
                        value: model.progress,
                        backgroundColor: Colors.grey,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'progress = ${model.progressForPercent}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            model.status.alDescription,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ))
                    ]))
              ]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 10, color: Colors.transparent),
      );

  /// The action lists
  late final theActionLists = <List>[
    ['download', _batchDownloadAction],
    ['pause', _pauseAllAction],
    ['cancel', _cancelAllAction],
    ['remove', _removeAllAction]
  ];

  /* ----------------------------------------------Action---------------------------------------------- */

  void _batchDownloadAction() {
    batchDownload();
  }

  void _pauseAllAction() {
    ALDownloader.pauseAll();
  }

  void _cancelAllAction() {
    ALDownloader.cancelAll();
  }

  void _removeAllAction() {
    ALDownloader.removeAll();
  }

  /* ----------------------------------------------ALDownloader---------------------------------------------- */

  /// Initialize
  void initialize() {
    /// ALDownloader initilize
    ALDownloader.initialize();

    /// Configure print
    ALDownloader.configurePrint(false, frequentEnabled: false);

    // It is for download. It is a forever interface.
    addForeverHandlerInterface();

    // It is for batch download. It is an one-off interface.
    addHandlerInterfaceForBatch();
  }

  /// Batch download
  void batchDownload() {
    final urls = models.map((e) => e.url).toList();
    final id = ALDownloaderBatcher.download(urls,
        handlerInterface:
            ALDownloaderHandlerInterface(progressHandler: (progress) {
          debugPrint('ALDownloader | batch | download progress = $progress\n');
        }, succeededHandler: () {
          debugPrint('ALDownloader | batch | download succeeded\n');
        }, failedHandler: () {
          debugPrint('ALDownloader | batch | download failed\n');
        }, pausedHandler: () {
          debugPrint('ALDownloader | batch | download paused\n');
        }));

    if (id != null) _handlerInterfaceIdsForBatch.add(id);
  }

  /// Add a forever handler interface
  void addForeverHandlerInterface() {
    for (final model in models) {
      final url = model.url;
      final id = ALDownloader.addForeverHandlerInterface(
          ALDownloaderHandlerInterface(progressHandler: (progress) {
            debugPrint(
                'ALDownloader | download progress = $progress, url = $url\n');

            model.status = ALDownloaderStatus.downloading;
            model.progress = progress;

            setState(() {});
          }, succeededHandler: () {
            debugPrint('ALDownloader | download succeeded, url = $url\n');

            model.status = ALDownloaderStatus.succeeded;

            setState(() {});
          }, failedHandler: () async {
            debugPrint('ALDownloader | download failed, url = $url\n');

            final status = await ALDownloader.getStatusForUrl(url);
            model.status = status;

            setState(() {});
          }, pausedHandler: () {
            debugPrint('ALDownloader | download paused, url = $url\n');

            model.status = ALDownloaderStatus.paused;

            setState(() {});
          }),
          url);

      _handlerInterfaceIds.add(id);
    }
  }

  /// Add a handler interface for batch
  void addHandlerInterfaceForBatch() {
    final urls = models.map((e) => e.url).toList();
    final id = ALDownloaderBatcher.addHandlerInterface(
        ALDownloaderHandlerInterface(progressHandler: (progress) {
          debugPrint('ALDownloader | batch | download progress = $progress\n');
        }, succeededHandler: () {
          debugPrint('ALDownloader | batch | download succeeded\n');
        }, failedHandler: () {
          debugPrint('ALDownloader | batch | download failed\n');
        }, pausedHandler: () {
          debugPrint('ALDownloader | batch | download paused\n');
        }),
        urls);

    _handlerInterfaceIdsForBatch.add(id);
  }

  /// Remove handler interface for batch
  void removeHandlerInterfaceForBatch() {
    for (final element in _handlerInterfaceIdsForBatch) {
      ALDownloaderBatcher.removeHandlerInterfaceForId(element);
    }

    _handlerInterfaceIdsForBatch.clear();
  }

  /// Manage [ALDownloaderHandlerInterface] by [ALDownloaderHandlerInterfaceId]
  final _handlerInterfaceIds = <ALDownloaderHandlerInterfaceId>[];

  /// Manage batch [ALDownloaderHandlerInterface] by [ALDownloaderHandlerInterfaceId]
  final _handlerInterfaceIdsForBatch = <ALDownloaderHandlerInterfaceId>[];
}

/* ----------------------------------------------Model class---------------------------------------------- */

class DownloadModel {
  final String url;

  double progress = 0;

  String get progressForPercent {
    int aProgress = (progress * 100).toInt();
    return '$aProgress%';
  }

  ALDownloaderStatus status = ALDownloaderStatus.unstarted;

  DownloadModel(this.url);
}

extension _ALDownloaderStatusExtension on ALDownloaderStatus {
  String get alDescription =>
      ['unstarted', 'downloading', 'paused', 'failed', 'succeeded'][index];
}

/* ----------------------------------------------Data---------------------------------------------- */

final models = kTestVideos.map((e) => DownloadModel(e)).toList();

final kTestVideos = [
  'https://media.w3.org/2010/05/sintel/trailer.mp4',
  'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
  'http://vjs.zencdn.net/v/oceans.mp4',
  'http://mirror.aarnet.edu.au/pub/TED-talks/911Mothers_2010W-480p.mp4',
  'http://downsc.chinaz.net/Files/DownLoad/sound1/201906/11582.mp3'
];