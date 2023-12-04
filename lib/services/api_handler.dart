import 'dart:developer';

import 'package:http/http.dart' as http;
import 'json_parser.dart';
import 'book_json_parser.dart';

const apiURL = 'https://mebookapi.onrender.com/api';

class DataFetcher {
  DataFetcher({required this.query});

  final String query;

  Future<List<Book>> fetchBooks() async {
    log("book search api hits");
    final url = Uri.parse("$apiURL/default?query=$query");

    log(url.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log("Data got it.");
      final parsedData = Books.fromRawJson(response.body);
      log("Book Response : " + response.body);
      return parsedData.books;
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  Future<String> downloadBook(String bookId) async {
    final url = '$apiURL/book?id=$bookId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bookData = BookData.fromRawJson(response.body);
      return bookData.download;
    } else {
      throw Exception('Failed to download book');
    }
  }
}


        //   Future<List<Book>> getBooksList(query) =>
                  //       _bookListCache.fetch(() async {
                  //         var bookList =
                  //             await DataFetcher(query: query).booksData();
                  //         return bookList;
                  //       });