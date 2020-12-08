import 'package:flutter/material.dart';
import 'package:stripe/src/api/api.dart';
import 'package:stripe/src/credit_card_widget/flutter_credit_card.dart';
import 'package:stripe_payment/stripe_payment.dart';

class SavedCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SavedCardsView(),
      ),
    );
  }
}

class SavedCardsView extends StatelessWidget {
  final void Function(PaymentMethod) onTap;

  const SavedCardsView({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PaymentMethod>>(
      future: StripeClient().getPaymentMethods(),
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final model = snapshot.data[index];
                    return GestureDetector(
                      onTap: () {
                        onTap?.call(model);
                      },
                      child: CreditCardWidget(
                        height: 200,
                        showBackView: false,
                        cardHolderName: '',
                        cvvCode: '',
                        brand: model.card.brand,
                        background: 'assets/credit_card_bg.jpg',
                        cardNumber: 'XXXX XXXX XXXX ' + model.card.last4,
                        expiryDate:
                            '${model.card.expMonth}/${model.card.expYear % 100}',
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No Payment Methods Available'),
                )
          : Center(
              child: snapshot.hasError
                  ? Text(snapshot.error.toString())
                  : CircularProgressIndicator(),
            ),
    );
  }
}
