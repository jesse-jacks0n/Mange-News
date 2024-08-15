import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home_page.dart';
import '../services/auth_service.dart';
import '../services/mpesa_service.dart';
import '../themes/colors.dart';

class SignupPage extends StatefulWidget {

  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _displayNameController = TextEditingController();

  final MPesaService _mpesaService = MPesaService();
  final TextEditingController _phoneController = TextEditingController();

  void _initiateMpesaPayment() async {
    try {
      await _mpesaService.lipaNaMpesa(_phoneController.text, 10.0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment initiated. Please complete the payment on your phone.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initiate payment: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            const Text('Signup', style: TextStyle(fontSize: 40),),
            const SizedBox(height: 30),
            TextFormField(
              controller: _displayNameController,
              decoration:  InputDecoration(
                  labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration:  InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(

                  borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(

                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
            ),
            // TextField(
            //   controller: _phoneController,
            //   decoration: InputDecoration(labelText: 'Phone Number'),
            //   keyboardType: TextInputType.phone,
            // ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration:  InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await context.read<AuthService>().signUpWithEmail(
                    _emailController.text,
                    _passwordController.text,
                    _displayNameController.text,
                  );
                 // _initiateMpesaPayment();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                } catch (e) {
                  // Handle sign up error
                }
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              child: const Text("Signup", style: TextStyle(color: Colors.white),)
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
