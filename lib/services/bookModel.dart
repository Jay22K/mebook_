class BookModel {
  final String id;
  final String title;
  final String author;
  final String image;
  final String pages;
  final String description;
  final String type;
  final String downloadUrl;
  final String filepath;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.pages,
    required this.description,
    required this.type,
    required this.downloadUrl,
    required this.filepath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'image': image,
      'pages': pages,
      'description': description,
      'type': type,
      'downloadUrl': downloadUrl,
      'filepath': filepath,
    };
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      image: json['image'],
      pages: json['pages'],
      description: json['description'],
      type: json['type'],
      downloadUrl: json['downloadUrl'],
      filepath: json['filepath'],
    );
  }
}
