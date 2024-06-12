import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/screen/auth_page_screen.dart';
import 'package:namer_app/screen/discounts_screen.dart';
import 'package:namer_app/screen/home_screen.dart';
import 'package:namer_app/screen/splash_screen.dart';
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
          theme: ThemeData(fontFamily: 'TildaSans'),
          home: SplashScreen(),
        ));
  }
}

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           print(snapshot.connectionState);
//           print("DISCOUNTS PAGE");
//           return SplashScreen();
//         } else if (snapshot.hasData) {
//           print(snapshot.connectionState);
//           print('HOME PAGE');
//           return HomePage();
//         } else {
//           print('AUTH PAGE');
//           return AuthPage();
//         }
//       },
//     );
//   }
// }
