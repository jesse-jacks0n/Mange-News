import 'package:firebase_database/firebase_database.dart';
import '../models/category.dart';
import '../models/comment.dart';
import '../models/news.dart';

class NewsService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Stream<List<Category>> getCategoriesStream() {
    return _dbRef.child('categories').onValue.map((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> categoriesMap = snapshot.value as Map<dynamic, dynamic>;
        List<Category> categories = [];
        categoriesMap.forEach((key, value) {
          categories.add(Category.fromMap(key, Map<String, dynamic>.from(value)));
        });
        return categories;
      }
      return [];
    });
  }

  Stream<List<News>> getNewsStream() {
    return _dbRef.child('news').orderByChild('date').onValue.map((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> newsMap = snapshot.value as Map<dynamic, dynamic>;
        List<News> newsList = [];
        newsMap.forEach((key, value) {
          newsList.add(News.fromMap(key, Map<String, dynamic>.from(value)));
        });
        return newsList;
      }
      return [];
    });
  }

  Stream<List<News>> getNewsByCategoryStream(String categoryId) {
    return _dbRef.child('news').orderByChild('category').equalTo(categoryId).onValue.map((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> newsMap = snapshot.value as Map<dynamic, dynamic>;
        List<News> newsList = [];
        newsMap.forEach((key, value) {
          newsList.add(News.fromMap(key, Map<String, dynamic>.from(value)));
        });
        return newsList;
      }
      return [];
    });
  }
}



Future<void> postComment(String newsId, String author, String text) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('comments/$newsId').push();
  await ref.set({'author': author, 'text': text});
}

Stream<List<Comment>> getCommentsStream(String newsId) {
  return FirebaseDatabase.instance.ref('comments/$newsId').onValue.map((event) {
    final commentsMap = event.snapshot.value as Map<dynamic, dynamic>?;
    if (commentsMap != null) {
      List<Comment> comments = [];
      commentsMap.forEach((commentId, commentData) {
        if (commentData != null) {
          comments.add(Comment.fromMap(commentId, Map<String, dynamic>.from(commentData)));
        }
      });
      return comments;
    }
    return [];
  });
}

