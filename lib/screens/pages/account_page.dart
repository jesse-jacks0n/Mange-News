import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/screens/about.dart';
import 'package:news/screens/pages/profile_page.dart';
import 'package:news/screens/privacy_policy.dart';
import 'package:provider/provider.dart';
import '../../auth/login_page.dart';
import '../../services/auth_service.dart';
import '../help_support.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          if (authService.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(authService.user?.email ?? 'Mtumiaji'),
              subtitle: const Text('Profaili'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          if (!authService.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Ingia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Ondoka'),
            onTap: () async {
              await authService.signOut();
              Fluttertoast.showToast(
                  msg: "Logout Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Faragha'),
            onTap: () {
              // Navigate to privacy settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Msaada na Usaidizi'),
            onTap: () {
              // Navigate to help & support page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpSupport()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Kuhusu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
        ],
      ),
    );
  }
}
