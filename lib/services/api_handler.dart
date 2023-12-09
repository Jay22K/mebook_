import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mebook/constants.dart';
import 'book_json_parser.dart';
import 'json_parser.dart';
import 'book_json_parser.dart';

const apiURL = 'https://mebookapi.onrender.com/api';

class DataFetcher {
  DataFetcher({required this.query, required this.page});
  int page;
  final String query;

  Future<Books> fetchBooks() async {
    log("book search api hits");
    final url = Uri.parse("$apiURL/default?query=$query&page=$page");

    log(url.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log("Data got it.");
      final parsedData = Books.fromRawJson(response.body);
      log("Book List Response : " + response.body);
      if (parsedData.books.isEmpty) {
        // If no books are returned, create a temporary book object or placeholder
        final placeholderBook = Book(
          author: "N/A",
          id: "N/A",
          image: imgUrl,
          pages: "0",
          publisher: "N/A",
          size: "N/A",
          title: "No books found",
          type: "N/A",
          year: "N/A",
        );

        // Create a Books object with the placeholder book
        final emptyBooks = Books(
          books: [placeholderBook],
          limit: 0,
          result: "success",
          status: 200,
          totalFiles: 0,
          totalPages: 0,
        );

        return emptyBooks;
      } else {
        // Return the list of books if available
        return parsedData;
      }
    } else {
      throw Exception('Failed to fetch books List');
    }
  }

  Future<BookData> downloadBook(String bookId) async {
    log("book download api hits");
    final url = '$apiURL/book?id=$bookId';
    log(url.toString());
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Data download got it.");
      final parsedBook = BookParser.fromRawJson(response.body);
      log("Book Description Response : " + response.body);
      return parsedBook.bookData;
    } else {
      throw Exception('Failed to fetch book Description');
    }
  }
}

// Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Pagination(
//               height: 30,
//               // width: 20,
//               paginateButtonStyles: PaginateButtonStyles(
//                   backgroundColor: kPrimaryColor,
//                   activeBackgroundColor: kSecondColor),
//               prevButtonStyles: PaginateSkipButton(
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                     size: 13,
//                   ),
//                   buttonBackgroundColor: kPrimaryColor,
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       bottomLeft: Radius.circular(20))),
//               nextButtonStyles: PaginateSkipButton(
//                   icon: const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 13,
//                   ),
//                   buttonBackgroundColor: kPrimaryColor,
//                   borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(20),
//                       bottomRight: Radius.circular(20))),
//               onPageChange: (number) {
//                 setState(() {
//                   currentPage = number;
//                 });
//               },
//               useGroup: false,
//               totalPage: 2,
//               show: 1,
//               currentPage: currentPage,
//             ),
//           )



        //   Future<List<Book>> getBooksList(query) =>
                  //       _bookListCache.fetch(() async {
                  //         var bookList =
                  //             await DataFetcher(query: query).booksData();
                  //         return bookList;
                  //       });