import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/news.dart';
import '../../widgets/news_card.dart';

class SavedNewsPage extends StatefulWidget {
  const SavedNewsPage({super.key});

  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  List<News> _savedNews = [];

  @override
  void initState() {
    super.initState();
    _loadSavedNews();
  }

  Future<void> _loadSavedNews() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNews = prefs.getStringList('savedNews') ?? [];
    setState(() {
      _savedNews = savedNews.map((newsJson) => News.fromJson(jsonDecode(newsJson))).toList();
    });
  }

  Future<void> _deleteNews(News news) async {
    final prefs = await SharedPreferences.getInstance();
    final savedNews = prefs.getStringList('savedNews') ?? [];
    savedNews.removeWhere((newsJson) => News.fromJson(jsonDecode(newsJson)).id == news.id);
    await prefs.setStringList('savedNews', savedNews);
    setState(() {
      _savedNews.remove(news);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Habari Zilizohifadhiwa'),
      ),
      body: _savedNews.isEmpty
          ? const Center(child: Text('Hakuna Habari Zilizohifadhiwa'))
          : ListView.builder(
              itemCount: _savedNews.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  news: _savedNews[index],
                  showDeleteButton: true,
                  onDelete: () => _deleteNews(_savedNews[index]),
                );
              },
            ),
    );
  }
}