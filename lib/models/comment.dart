class Comment {
  final String id;
  final String author;
  final String text;

  Comment({required this.id, required this.author, required this.text});

  factory Comment.fromMap(String id, Map<String, dynamic> data) {
    return Comment(
      id: id,
      author: data['author'],
      text: data['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'text': text,
    };
  }
}
