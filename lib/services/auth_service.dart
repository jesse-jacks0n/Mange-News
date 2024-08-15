import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  bool _isDarkMode = false;

  AuthService() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmail(String email, String password, String displayName) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await _firebaseAuth.currentUser?.updateProfile(displayName: displayName);
    await _firebaseAuth.currentUser?.reload();
    _user = _firebaseAuth.currentUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateEmail(String email) async {
    try {
      await _user?.updateEmail(email);
      await _user?.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
    } catch (e) {
      print('Failed to update email: $e');
    }
  } 

  Future<void> updateProfile({String? displayName, String? phoneNumber}) async {
    try {
      await _user?.updateDisplayName(displayName);
      // await _user?.updatePhoneNumber(PhoneAuthProvider.credential(
      //   verificationId: '', // The verification ID received from Firebase
      //   smsCode: '', // The SMS code sent to the user's phone
      // ));
      await _user?.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
    } catch (e) {
      print('Failed to update profile: $e');
    }
  }

  changePassword({required String currentPassword, required String newPassword}) {
    _firebaseAuth.currentUser?.reauthenticateWithCredential(EmailAuthProvider.credential(email: _firebaseAuth.currentUser!.email!, password: currentPassword));
    _firebaseAuth.currentUser?.updatePassword(newPassword);
  }


}
