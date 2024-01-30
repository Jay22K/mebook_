import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mebook/util/router.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import '../../services/json_parser.dart';
import '../details_screen.dart';

class RecomendsBooks extends StatelessWidget {
  final List<Book> books; // List of books received from the API call

  RecomendsBooks({required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return _buildShimmerPlaceholder(); // Show shimmer if books list is empty
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: books.map((book) {
            return BookCard(
              id: book.id,
              image: book.image,
              title: book.title,
              author: book.author,
              pages: book.pages,
              publisher: book.publisher,
              type: book.type,
              year: book.year,
            );
          }).toList(),
        ),
      );
    }
  }

  Widget _buildShimmerPlaceholder() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5, // Number of shimmer placeholders
          (index) => _buildShimmerItem(),
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image at the top
            Container(
              width: 130,
              height: 185, // Height of the image
              decoration: BoxDecoration(
                color: Colors.white, // Use white color as a placeholder
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(height: 5), // Spacer
            // Book name
            Container(
              width: 130,
              height: 14, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.white, // Use white color as a placeholder
                borderRadius: BorderRadius.circular(3),
              ), // Use white color as a placeholder
            ),
            // Author's name
            SizedBox(height: 5),
            Container(
              width: 100,
              height: 11, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.white, // Use white color as a placeholder
                borderRadius: BorderRadius.circular(3),
              ), // Use white color as a placeholder
            ),
          ],
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String id, image, title, author, pages, publisher, type, year;

  BookCard({
    required this.author,
    required this.id,
    required this.image,
    required this.pages,
    required this.publisher,
    required this.title,
    required this.type,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        // right: kDefaultPadding-10,
        bottom: kDefaultPadding,
      ),
      child: Column(
        children: [
          // Image at the top
          InkWell(
            onTap: () {
              log(id);
              MyRouter.pushPage(
                  context,
                  DetailsScreen(
                    author: author,
                    id: id,
                    image: image,
                    pages: pages,
                    publisher: publisher,
                    title: title,
                    type: type,
                    year: year,
                  ));
            },
            child: Container(
              width: 130,
              height: 185, // Height of the image
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5), // Spacer
          // Book name
          Container(
            width: 130,
            child: Text(
              title,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2, // Set max lines for overflow
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Author's name
          Container(
            width: 130,
            child: Text('by $author',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
                maxLines: 1, // Set max lines for overflow
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
