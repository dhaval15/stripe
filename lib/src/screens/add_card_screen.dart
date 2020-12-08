import 'package:flutter/material.dart';
import 'package:stripe/src/credit_card_widget/flutter_credit_card.dart';

class AddCardScreen extends StatelessWidget {
  final CreditCardModel model;
  final _creditCardViewKey = GlobalKey<_CreditCardViewState>();

  AddCardScreen({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(
                child: CreditCardView(
                  key: _creditCardViewKey,
                ),
              ),
              CreditCardForm(
                themeColor: Colors.red,
                onCreditCardModelChange: (CreditCardModel data) {
                  _creditCardViewKey.currentState.setModel(data);
                },
              ),
              FlatButton(
                child: Text('Next'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCardView extends StatefulWidget {
  final CreditCardModel model;

  const CreditCardView({Key key, this.model}) : super(key: key);

  @override
  _CreditCardViewState createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  bool showBackView = false;
  CreditCardModel model;

  void setModel(CreditCardModel value) {
    setState(() {
      this.model = value;
    });
  }

  @override
  void initState() {
    super.initState();
    this.model = widget.model ?? CreditCardModel('', '', '', '', false);
  }

  void focusBack() {
    setState(() {
      this.showBackView = true;
    });
  }

  void focusFront() {
    setState(() {
      this.showBackView = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      width: 300,
      height: 200,
      cardHolderName: model.cardHolderName,
      cvvCode: model.cvvCode,
      showBackView: showBackView,
      expiryDate: model.expiryDate,
      cardNumber: model.cardNumber,
      background: 'assets/credit_card_bg.jpg',
    );
  }
}

class CreditCardController extends ValueNotifier<CreditCardModel> {
  CreditCardController(CreditCardModel value) : super(value);
}
