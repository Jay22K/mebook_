import 'package:flutter/material.dart';

import '../../constants.dart';

// Assume kDefaultPadding and other constants are defined

class BookWidget extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final String author;
  final String type;
  final int year;
  final int pages;
  final String publisher;

  const BookWidget({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.author,
    required this.type,
    required this.year,
    required this.pages,
    required this.publisher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // log(id);
              // MyRouter.pushPage(
              //   context,
              //   DetailsScreen(
              //     author: author,
              //     id: id,
              //     image: image,
              //     pages: pages,
              //     publisher: publisher,
              //     title: title,
              //     type: type,
              //     year: year,
              //   ),
              // );
            },
            child: SizedBox(
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
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
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
          const SizedBox(height: 5),
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              'by $author',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
