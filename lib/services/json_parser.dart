// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Books {
    Books({
        required this.books,
        required this.limit,
        required this.result,
        required this.status,
        required this.totalFiles,
        required this.totalPages,
    });

    final List<Book> books;
    final int limit;
    final String result;
    final int status;
    final int totalFiles;
    final int totalPages;

    factory Books.fromRawJson(String str) => Books.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Books.fromJson(Map<String, dynamic> json) => Books(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        limit: json["limit"],
        result: json["result"],
        status: json["status"],
        totalFiles: json["totalFiles"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "limit": limit,
        "result": result,
        "status": status,
        "totalFiles": totalFiles,
        "totalPages": totalPages,
    };
}

class Book {
    Book({
        required this.author,
        required this.id,
        required this.image,
        //@required this.language,
        required this.pages,
        required this.publisher,
        required this.size,
        required this.title,
        required this.type,
        required this.year,
    });

    final String author;
    final String id;
    final String image;
    //final Language language;
    final String pages;
    final String publisher;
    final String size;
    final String title;
    final String type;
    final String year;

    factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        author: json["author"],
        id: json["id"],
        image: json["image"],
        //language: languageValues.map[json["language"]],
        pages: json["pages"],
        publisher: json["publisher"],
        size: json["size"],
        title: json["title"],
        type: json["type"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "id": id,
        "image": image,
        //"language": languageValues.reverse[language],
        "pages": pages,
        "publisher": publisher,
        "size": size,
        "title": title,
        "type": type,
        "year": year,
    };
}
