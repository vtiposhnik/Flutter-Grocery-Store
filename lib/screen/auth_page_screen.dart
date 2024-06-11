import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/models/user_model.dart';
import 'home_screen.dart'; // Assuming you have HomePage for the home screen

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  String _errorMessage = '';
  bool isSignIn = false;

  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (!mounted) return;

      await Provider.of<UserProvider>(context, listen: false).fetchUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _signUp() async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      await _db.collection('users').doc(res.user!.uid).set({
        'email': _emailController.text,
        'username': _usernameController.text
      });
      await _db
          .collection('userCart')
          .doc(res.user!.uid)
          .set({'cartItems': []});

      if (!mounted) return;

      await Provider.of<UserProvider>(context, listen: false).fetchUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _toggleSign() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.green),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isSignIn)
              TextField(
                controller: _usernameController,
                decoration: _inputDecoration('Ваше Имя'),
                maxLength: 50,
              ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: _inputDecoration('Электронная почта'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: _inputDecoration('Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green)),
              onPressed: !isSignIn ? _signUp : _signIn,
              child: Text(
                !isSignIn ? 'Регистрация' : 'Войти',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(children: [
              Text(
                !isSignIn ? 'Уже авторизованы?  ' : 'Еще нет аккаунта?  ',
                style: TextStyle(fontSize: 19),
              ),
              GestureDetector(
                  onTap: _toggleSign,
                  child: Text(
                    !isSignIn ? 'Войти' : 'Создать аккаунт',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ))
            ]),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
