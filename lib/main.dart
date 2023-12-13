import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_ai/firebase_options.dart';
import 'package:scholar_ai/pages/homepage.dart';

import 'package:scholar_ai/pages/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar Ai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomePage();
              } else if (snapshot.hasError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("${snapshot.error}")));
                return LoginPage();
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SafeArea(
                  child: Scaffold(
                body: Center(
                  child: Container(
                      width: 50, height: 50, child: const Text("Loading...")),
                ),
              ));
            }
            return LoginPage();
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
