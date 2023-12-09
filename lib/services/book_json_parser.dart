// To parse this JSON data, do
//
//     final bookParser = bookParserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BookParser {
  BookParser({
    required this.bookData,
    required this.result,
    required this.status,
  });

  final BookData bookData;
  final String result;
  final String status;

  factory BookParser.fromRawJson(String str) =>
      BookParser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookParser.fromJson(Map<String, dynamic> json) => BookParser(
        bookData: BookData.fromJson(json["bookData"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bookData": bookData.toJson(),
        "result": result,
        "status": status,
      };
}

class BookData {
  BookData({
    required this.description,
    required this.download,
  });

  final String description;
  final String download;

  factory BookData.fromRawJson(String str) =>
      BookData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
        description: json["description"] ??
            " Description is not available for this book",
        download: json["download"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "download": download,
      };
}
