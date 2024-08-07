import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mebook/constants.dart';
import 'package:mebook/util/router.dart';
import 'package:shimmer/shimmer.dart';

import '../details_screen.dart';

class BookAdaptor extends StatelessWidget {
  final String id, title, image, year, author, pages, publisher, type;

  BookAdaptor(
      {super.key,
      required this.title,
      required this.image,
      required this.year,
      required this.author,
      required this.id,
      required this.pages,
      required this.publisher,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ), 
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        author,
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        year,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class bookAdaptorShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7, // Number of shimmer placeholders
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  height: 185,
                  decoration: BoxDecoration(
                    color: Colors.white, // Use white color as a placeholder
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Use white color as a placeholder
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Use white color as a placeholder
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Use white color as a placeholder
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 50,
                        height: 16,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Use white color as a placeholder
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
