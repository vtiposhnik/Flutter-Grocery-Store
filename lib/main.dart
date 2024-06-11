import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/pages/auth_page_screen.dart';
import 'package:namer_app/pages/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kushay',
          theme: ThemeData(
            fontFamily: 'TildaSans',
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
          ),
          home: IntroPage(),
        ));
  }
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('./assets/logo.svg', height: 300, width: 300),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Плати и Кушай',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                      border: Border.all(color: Colors.greenAccent.shade200)),
                  child: Text(
                    'Начнем!',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
