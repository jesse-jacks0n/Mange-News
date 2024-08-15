import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/pages/account_page.dart';
import 'package:news/screens/pages/categories_page.dart';
import 'package:news/screens/pages/headline_page.dart';
import 'package:news/screens/pages/saved_news_page.dart';
import 'package:news/screens/pages/search_page.dart';
import 'package:news/themes/colors.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService _notificationService = NotificationService();
  String? _token;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _notificationService.init();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _notificationService.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification taps here
      _handleNotificationTap(message);
    });

    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      setState(() {
        _token = token;
      });
      print("FCM Token: $_token");
    });

    _firebaseMessaging.subscribeToTopic('news');
  }
  void _handleNotificationTap(RemoteMessage message) {
    // Define your navigation or actions when notification is tapped
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Change this to the appropriate page
      ),
    );
  }

  final List<Widget> _pages = [
    const HeadlinePage(),
    const SearchPage(),
    const CategoriesPage(),
    const SavedNewsPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Karibu ${authService.user?.displayName ?? 'Mtumiaji'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        blurEffect: false,
        isFloating: true,
        iconSize: 35,
        borderRadius: const Radius.circular(20),
        selectedColor: Colors.orange,
        unSelectedColor: Colors.grey.shade400,
        strokeColor: Colors.orange,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(
            selectedTitle: const Text("Headlines", style: TextStyle(color: Colors.orange)),
            icon: const Icon(Icons.dashboard_rounded),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.search),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.home_max),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.bookmark),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
