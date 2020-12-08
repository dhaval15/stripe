import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

import 'screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      if (FirebaseAuth.instance.currentUser != null)
        Navigator.of(context).pushReplacementNamed(Screens.HOME);
      else
        Navigator.of(context).pushReplacementNamed(Screens.LOGIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(
            'Stripe Payments',
            style: context.headline3,
          ).center(),
        ),
      ),
    );
  }
}
