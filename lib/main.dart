import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_accounting_moby/homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print("You have an error! ${snapshot.error.toString()}");
            return const Text("Something went wrong!");
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
