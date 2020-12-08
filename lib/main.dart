import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stripe/src/api/api.dart';
import 'package:stripe/src/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    StripeClient().init();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          centerTitle: true,
        ),
      ),
      initialRoute: Screens.SPLASH,
      onGenerateRoute: Screens.onGenerateRoute,
    );
  }
}
