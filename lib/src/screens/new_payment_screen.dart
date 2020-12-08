import 'package:flutter/material.dart';
import 'package:stripe/src/api/api.dart';
import 'package:stripe/src/screens/screens.dart';
import 'package:stripe/src/widgets/widgets.dart';
import 'package:toast/toast.dart';

import 'saved_cards_screen.dart';

class NewPaymentScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int amount;

  NewPaymentScreen({Key key, this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: SavedCardsView(
          onTap: (paymentMethod) async {
            showDialog(context: context, builder: (context) => LoadingDialog());
            try {
              final result =
                  await StripeClient().pay(amount * 100, paymentMethod);
              Navigator.of(context).pushReplacementNamed(Screens.HOME);
              print('>>>>>>>>>>>>>>>>>>');
              print(result.toJson());
              if (result != null && result.status == 'succeeded')
                Toast.show('Payment Successful', context);
            } catch (e) {
              Navigator.of(context).pushReplacementNamed(Screens.HOME);
              Toast.show('Payment Failed', context);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final paymentMethod = await StripeClient().addCard();
          if (paymentMethod != null) {
            final result = StripeClient().pay(amount * 100, paymentMethod);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
