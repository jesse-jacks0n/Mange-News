class News {
  final String id;
  final String title;
  final String description;
  final String content;
  final String author;
  final String date;
  final String category;
  final String imageUrl;
  int likes;
  int dislikes;
  int views;
  int commentsCount;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.date,
    required this.category,
    required this.imageUrl,
    this.likes = 0,
    this.dislikes = 0,
    this.views = 0,
    this.commentsCount = 0,
  });

  factory News.fromMap(String id, Map<String, dynamic> data) {
    return News(
      id: id,
      title: data['title'] as String,
      description: data['description'] as String,
      content: data['content'] as String,
      author: data['author'] as String,
      date: data['date'] as String,
      category: data['category'] as String,
      imageUrl: data['imageUrl'] as String,
      likes: (data['likes'] ?? 0) as int,
      dislikes: (data['dislikes'] ?? 0) as int,
      views: (data['views'] ?? 0) as int,
      commentsCount: (data['commentsCount'] ?? 0) as int,
    );
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'author': author,
      'date': date,
      'category': category,
      'imageUrl': imageUrl,
      'likes': likes,
      'dislikes': dislikes,
      'views': views,
      'commentsCount': commentsCount,
    };
  }
}