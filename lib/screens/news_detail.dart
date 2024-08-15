import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:news/models/comment.dart';
import 'package:news/themes/colors.dart';
import 'package:provider/provider.dart';
import '../auth/login_page.dart';
import '../models/news.dart';
import '../services/auth_service.dart';
import '../services/news_service.dart';

class NewsDetail extends StatefulWidget {
  final News news;

  const NewsDetail({super.key, required this.news});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late int likes;
  late int dislikes;
  bool hasLiked = false;
  bool hasDisliked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _incrementViews();
    likes = widget.news.likes;
    dislikes = widget.news.dislikes;
    _checkUserReaction();
  }

  void _incrementViews() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('news/${widget.news.id}');
    ref.child('views').get().then((snapshot) {
      if (snapshot.exists) {
        final views = snapshot.value as int;
        ref.update({'views': views + 1});
      } else {
        ref.update({'views': 1});
      }
    });
  }

  void _checkUserReaction() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.user?.uid;

    if (userId != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('news/${widget.news.id}');
      ref.child('likes/$userId').get().then((snapshot) {
        setState(() {
          hasLiked = snapshot.exists && snapshot.value == true;
        });
      });
      ref.child('dislikes/$userId').get().then((snapshot) {
        setState(() {
          hasDisliked = snapshot.exists && snapshot.value == true;
        });
      });
    }
  }

  void _toggleLike() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.user?.uid;

    if (authService.isLoggedIn && userId != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('news/${widget.news.id}/likes/$userId');
      if (hasLiked) {
        ref.remove();
        setState(() {
          likes -= 1;
          hasLiked = false;
        });
      } else {
        ref.set(true);
        setState(() {
          likes += 1;
          hasLiked = true;
          if (hasDisliked) {
            _toggleDislike(); // Remove dislike if already disliked
          }
        });
      }
      _updateLikes(widget.news.id, likes);
    } else {
      // Navigate to login page if user is not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  void _toggleDislike() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.user?.uid;

    if (authService.isLoggedIn && userId != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('news/${widget.news.id}/dislikes/$userId');
      if (hasDisliked) {
        ref.remove();
        setState(() {
          dislikes -= 1;
          hasDisliked = false;
        });
      } else {
        ref.set(true);
        setState(() {
          dislikes += 1;
          hasDisliked = true;
          if (hasLiked) {
            _toggleLike(); // Remove like if already liked
          }
        });
      }
      _updateDislikes(widget.news.id, dislikes);
    } else {
      // Navigate to login page if user is not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  Future<void> _updateLikes(String newsId, int likes) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('news/$newsId');
    await ref.update({'likes': likes});
  }

  Future<void> _updateDislikes(String newsId, int dislikes) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('news/$newsId');
    await ref.update({'dislikes': dislikes});
  }

  void _submitComment() {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (authService.isLoggedIn && authService.user != null) {
      final displayName = authService.user!.displayName ??
          'Anonymous'; // Use display name or default to 'Anonymous'
      postComment(widget.news.id, displayName, _commentController.text);
      _commentController.clear();
      _incrementCommentsCount();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

 void _incrementCommentsCount() {
  DatabaseReference ref = FirebaseDatabase.instance.ref('comments/${widget.news.id}');
  ref.get().then((snapshot) {
    if (snapshot.exists) {
      final commentsCount = snapshot.children.length;
      DatabaseReference newsRef = FirebaseDatabase.instance.ref('news/${widget.news.id}');
      newsRef.update({'commentsCount': commentsCount});
    } else {
      DatabaseReference newsRef = FirebaseDatabase.instance.ref('news/${widget.news.id}');
      newsRef.update({'commentsCount': 0});
    }
  });
}

  Color _getRandomColor(String text) {
    final int hash = text.codeUnits.fold(0, (prev, element) => prev + element);
    final Random random = Random(hash);
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _toggleLike,
            icon: Icon(
              hasLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
              color: hasLiked ? Colors.blue : Colors.grey,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('$likes'),
            ),
          ),
          IconButton(
            onPressed: _toggleDislike,
            icon: Icon(
              hasDisliked
                  ? Icons.thumb_down_alt
                  : Icons.thumb_down_alt_outlined,
              color: hasDisliked ? Colors.red : Colors.grey,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('$dislikes'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.news.title,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Merriweather'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "na ${widget.news.author} mnamo ${widget.news.date}",
                        style:  TextStyle(fontSize: 18, color: Colors.grey[600], fontFamily: 'Merriweather'),
                      ),
                      const SizedBox(height: 16),
                      Image.network(widget.news.imageUrl),
                      const SizedBox(height: 16),
                      Text(
                        widget.news.content,
                        style: const TextStyle(fontSize: 20, fontFamily: 'Merriweather'),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Maoni',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]
                                ),
                              ),
                            ),
                            StreamBuilder<List<Comment>>(
                              stream: getCommentsStream(widget.news.id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final comments = snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2.0,
                                            horizontal: 4.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: _getRandomColor(comments[index].author),
                                            child: Text(
                                              comments[index].author.isNotEmpty ? comments[index].author[0].toUpperCase() : '?',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                          ),
                                          title: Text(
                                            comments[index].author,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800], // Neutral text color
                                            ),
                                          ),
                                          subtitle: Text(
                                            comments[index].text,
                                            style: TextStyle(
                                              color: Colors.grey[700], // Neutral text color
                                            ),
                                          ),
                                        )

                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text('Hitilafu katika kupakia maoni');
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Andika maoni...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.primaryColor),
              onPressed: _submitComment,
            ),
          ],
        ),
      ),
    );
  }
}
