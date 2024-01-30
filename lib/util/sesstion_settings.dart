// import 'package:flutter_file_downloader/flutter_file_downloader.dart';

// class SessionSettings {
//   static SessionSettings? _instance;
//   var _notificationType = NotificationType.progressOnly;
//   var _downloadDestination = DownloadDestinations.publicDownloads;
//   var _maximumParallelDownloads = FileDownloader().maximumParallelDownloads;

//   SessionSettings._();

//   factory SessionSettings() => _instance ??= SessionSettings._();

//   void setNotificationType(NotificationType notificationType) =>
//       _notificationType = notificationType;

//   void setDownloadDestination(DownloadDestinations downloadDestination) =>
//       _downloadDestination = downloadDestination;

//   void setMaximumParallelDownloads(int maximumParallelDownloads) {
//     if (maximumParallelDownloads <= 0) return;
//     _maximumParallelDownloads = maximumParallelDownloads;
//     FileDownloader.setMaximumParallelDownloads(maximumParallelDownloads);
//   }

//   NotificationType get notificationType => _notificationType;

//   DownloadDestinations get downloadDestination => _downloadDestination;

//   int get maximumParallelDownloads => _maximumParallelDownloads;
// }





// UI



//Settings
// Text(
//               'Enable logs',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(enabled ? 'Enabled' : 'Disabled',
//                       style: Theme.of(context).textTheme.titleMedium),
//                 ),
//                 const SizedBox(width: 16),
//                 Switch(
//                     value: enabled,
//                     onChanged: (value) {
//                       setState(() => enabled = value);
//                       FileDownloader.setLogEnabled(enabled);
//                     })
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Divider(color: Colors.grey, height: 1),
//             const SizedBox(height: 32),
//             Text(
//               'Display Notifications',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<NotificationType>(
//               items: [
//                 for (final type in NotificationType.values) ...[
//                   DropdownMenuItem(
//                       child: Text(convertCamelCaseToText(type.name)),
//                       value: type),
//                 ]
//               ],
//               onChanged: (final NotificationType? type) {
//                 if (type == null) return;
//                 settings.setNotificationType(type);
//               },
//               isExpanded: true,
//               value: settings.notificationType,
//               decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
//             ),
//             const SizedBox(height: 16),
//             const Divider(color: Colors.grey, height: 1),
//             const SizedBox(height: 32),
//             Text(
//               'Download destination',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<DownloadDestinations>(
//               items: [
//                 for (final type in DownloadDestinations.values) ...[
//                   DropdownMenuItem(
//                       child: Text(convertCamelCaseToText(type.name)),
//                       value: type),
//                 ]
//               ],
//               onChanged: (final DownloadDestinations? destination) {
//                 if (destination == null) return;
//                 settings.setDownloadDestination(destination);
//               },
//               isExpanded: true,
//               value: settings.downloadDestination,
//               decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
//             ),
//             const SizedBox(height: 16),
//             const Divider(color: Colors.grey, height: 1),
//             const SizedBox(height: 32),
//             Text(
//               'Maximum parallel downloads',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(settings.maximumParallelDownloads.toString(),
//                       style: Theme.of(context).textTheme.subtitle1),
//                 ),
//                 const SizedBox(width: 16),
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         settings.setMaximumParallelDownloads(
//                             settings.maximumParallelDownloads - 1);
//                       });
//                     },
//                     icon: const Icon(Icons.arrow_downward)),
//                 const SizedBox(width: 8),
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         settings.setMaximumParallelDownloads(
//                             settings.maximumParallelDownloads + 1);
//                       });
//                     },
//                     icon: const Icon(Icons.arrow_upward)),
//               ],
//             ),