import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../themes/colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmNewPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_newPasswordController.text == _confirmNewPasswordController.text) {
      try {
        // Assuming AuthService has a method changePassword
        await Provider.of<AuthService>(context, listen: false).changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password successfully changed')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password and confirm new password do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              //validate Current password
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    // Adds an outline border
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border style when TextFormField is enabled
                    borderSide:
                    const BorderSide(color:Colors.grey, width: 1.0),
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
                  prefixIcon: const Icon(Icons.lock_open),
                  // Icon at the beginning of TextFormField

                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    // Adds an outline border
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border style when TextFormField is enabled
                    borderSide:
                    const BorderSide(color:Colors.grey, width: 1.0),
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
                  prefixIcon: const Icon(Icons.lock_open),
                  // Icon at the beginning of TextFormField

                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    // Adds an outline border
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border style when TextFormField is enabled
                    borderSide:
                    const BorderSide(color:Colors.grey, width: 1.0),
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
                  prefixIcon: const Icon(Icons.lock_open),
                  // Icon at the beginning of TextFormField

                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _changePassword,
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
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }
}
