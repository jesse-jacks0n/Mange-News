import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news.dart';
import '../screens/news_detail.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final bool showDeleteButton;
  final VoidCallback? onDelete;

  const NewsCard({
    super.key,
    required this.news,
    this.showDeleteButton = false,
    this.onDelete,
  });

  Future<void> _saveNews() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNews = prefs.getStringList('savedNews') ?? [];
    savedNews.add(jsonEncode(news.toJson()));
    await prefs.setStringList('savedNews', savedNews);

    Fluttertoast.showToast(
      msg: 'News saved',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade700,
            width: 0.2,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        elevation: 0,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetail(news: news),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff15024d),
                            fontFamily: 'Merriweather',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          news.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontFamily: 'Merriweather',
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: showDeleteButton
                              ? [
                            GestureDetector(
                              onTap: onDelete,
                              child: const Icon(Icons.delete, color: Colors.red, size: 17),
                            ),
                          ]
                              : [
                            GestureDetector(
                              onTap: _saveNews,
                              child: const Icon(Icons.bookmark_add_outlined, color: Colors.grey, size: 17),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const Icon(Icons.comment_outlined, color: Colors.grey, size: 17),
                                const SizedBox(width: 4),
                                Text('${news.commentsCount}', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 17),
                                const SizedBox(width: 4),
                                Text('${news.views}', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    news.imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.webp',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
