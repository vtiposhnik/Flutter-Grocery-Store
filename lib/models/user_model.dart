import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String username;
  final String email;

  UserModel({required this.username, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': username,
    };
  }
}

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? get user => _user;

  Future<Map<String, dynamic>?> fetchUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();
        _user = userDoc.data() as Map<String, dynamic>;
        notifyListeners();
        return _user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
