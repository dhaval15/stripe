import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'splash_screen.dart';
import 'saved_cards_screen.dart';
import 'add_card_screen.dart';
import 'new_payment_screen.dart';

class Screens {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const NEW_PAYMENT_SCREEN = '/home/newpayment';
  static const ADD_CARD_SCREEN = '/home/addcard';
  static const SAVED_CARDS_SCREEN = '/home/savedcards';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case HOME:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case SAVED_CARDS_SCREEN:
        return MaterialPageRoute(builder: (context) => SavedCardsScreen());
      case ADD_CARD_SCREEN:
        return MaterialPageRoute(builder: (context) => AddCardScreen());
      case NEW_PAYMENT_SCREEN:
        return MaterialPageRoute(
            builder: (context) => NewPaymentScreen(amount: settings.arguments));
    }
    return null;
  }
}
