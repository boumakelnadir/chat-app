import 'package:chatapp1/helper/constans.dart';
import 'package:chatapp1/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

main() async {
  runApp(const Chatapp1());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Chatapp1 extends StatelessWidget {
  const Chatapp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat app 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimeryColor,
        useMaterial3: false,
      ),
      home: const Scaffold(
        body: LoginView(),
      ),
    );
  }
}
