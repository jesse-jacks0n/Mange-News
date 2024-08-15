import 'package:flutter/material.dart';
import 'package:news/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _displayName;
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profaili'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: authService.user?.displayName,
                decoration: InputDecoration(
                  labelText: 'Jina la Kuonyesha',
                  border: OutlineInputBorder(
                    // Adds an outline border
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border style when TextFormField is enabled
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border style when TextFormField is focused
                    borderSide:
                        const BorderSide(color: AppColors.primaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    // Border style when TextFormField has an error
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    // Border style when TextFormField is focused and has an error
                    borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fillColor: Colors.grey[200],
                  // Background color
                  filled: true,
                  // Fill color is enabled
                  prefixIcon: const Icon(Icons.person),
                  // Icon at the beginning of TextFormField
                  suffixIcon: IconButton(
                    // Icon at the end of TextFormField, typically used for clearing text
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // Clear action
                    },
                  ),
                ),
                onSaved: (value) => _displayName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tafadhali ingiza jina la kuonyesha';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   initialValue: authService.user?.phoneNumber,
              //   decoration: InputDecoration(labelText: 'Phone Number'),
              //   onSaved: (value) => _phoneNumber = value,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a phone number';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await authService.updateProfile(
                      displayName: _displayName,
                      phoneNumber: _phoneNumber,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profaili imesasishwa')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.accentColor,
                  backgroundColor: AppColors.primaryColor,
                  // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 5,
                  // Shadow depth
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15), // Padding inside the button
                ),
                child: const Text(
                  'Hifadhi Mabadiliko',
                  style: TextStyle(
                    fontSize: 16, // Adjust font size
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ),
              const Divider(height: 40),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Badilisha Neno la Siri'),
                onTap: () {
                  // Navigate to change password page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.notifications),
              //   title: Text('Notification Settings'),
              //   onTap: () {
              //     // Navigate to notification settings page
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Mipangilio ya Faragha'),
                onTap: () {
                  // Navigate to privacy settings page
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Futa Akaunti'),
                onTap: () {
                  // Navigate to delete account page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
