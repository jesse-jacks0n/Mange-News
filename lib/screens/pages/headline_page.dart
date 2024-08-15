import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/news.dart';
import '../../services/news_service.dart';
import '../../widgets/category_tab.dart';
import '../../widgets/news_card.dart';

class HeadlinePage extends StatefulWidget {
  const HeadlinePage({super.key});

  @override
  State<HeadlinePage> createState() => _HeadlinePageState();
}

class _HeadlinePageState extends State<HeadlinePage> {
  final NewsService _newsService = NewsService();
  String _selectedCategoryId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<List<Category>>(
            stream: _newsService.getCategoriesStream(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(child: CircularProgressIndicator());
              // } else
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Hakuna jamii zinazopatikana'));
              } else {
                final categories = [
                  Category(
                      id: '',
                      name: 'Zote'
                  )
                ] + snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryTab(
                          category: category,
                          isSelected: _selectedCategoryId == category.id,
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = category.id;
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          Expanded(
            child: _selectedCategoryId.isEmpty
                ? StreamBuilder<List<News>>(
                    stream: _newsService.getNewsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}')
                        );

                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Hakuna habari zinazopatikana'));
                      } else {
                        final newsList = snapshot.data!;
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.builder(
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              final newsItem = newsList[index];
                              return NewsCard(news: newsItem);
                            },
                          ),
                        );
                      }
                    },
                  )
                : StreamBuilder<List<News>>(
                    stream: _newsService
                        .getNewsByCategoryStream(_selectedCategoryId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Hakuna habari zinazopatikana'));
                      } else {
                        final newsList = snapshot.data!;
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.builder(
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              final newsItem = newsList[index];
                              return NewsCard(news: newsItem);
                            },
                          ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
