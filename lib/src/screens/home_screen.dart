import 'package:flutter/material.dart';
import 'package:stripe/src/screens/screens.dart';
import 'package:stripe/src/widgets/widgets.dart';

import 'saved_cards_screen.dart';

class HomeScreen extends StatelessWidget {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            AcceptPaymentView(),
            SavedCardsPage(),
          ],
        ),
      ),
      bottomNavigationBar: PageBottomNavigationBar(
        controller: controller,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp),
            label: 'Pay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Saved Cards',
          ),
        ],
      ),
    );
  }
}

class AcceptPaymentView extends StatefulWidget {
  @override
  _AcceptPaymentViewState createState() => _AcceptPaymentViewState();
}

class _AcceptPaymentViewState extends State<AcceptPaymentView> {
  final controller = TextEditingController();
  String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Pay',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 48),
          Text(
            'Minimum Transaction is 10',
          ),
          SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              final amount = int.tryParse(text);
              setState(() {
                error = amount == null || amount < 10 ? 'Invalid Amount' : null;
              });
            },
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Amount',
              errorText: error,
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
            child: Text(
              'Pay',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              final amount = int.tryParse(controller.text);
              if (amount == null || amount < 10) {
                setState(() {
                  error = 'Invalid Amount';
                });
                return;
              }
              Navigator.of(context)
                  .pushNamed(Screens.NEW_PAYMENT_SCREEN, arguments: amount);
            },
          ),
        ],
      ),
    );
  }
}

class SavedCardsPage extends StatefulWidget {
  @override
  _SavedCardsPageState createState() => _SavedCardsPageState();
}

class _SavedCardsPageState extends State<SavedCardsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return super.build(context) ?? SavedCardsView();
  }

  @override
  bool get wantKeepAlive => true;
}
