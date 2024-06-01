import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store App',
        theme: ThemeData(
          fontFamily: 'TildaSans',
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Text('A random idea:'),
            Text(appState.current.asLowerCase),
          ],
        ),
      ),
    );
  }
}
