import 'package:stripe_payment/stripe_payment.dart';

import 'auth_api.dart';
import 'stripe_server.dart';

const API_KEY =
    'pk_test_51Hvyz1D1mkFLDprg0mosv3hxb8hX2vP6oFSVqOnGUQ1jJ4BVMqD3eserGqgU5w6MuweW5I9ZQfNqH9XZOIQ9Pgoz00KQFHpSxT';

class StripeClient {
  void init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: API_KEY,
      merchantId: "Test",
      androidPayMode: 'test',
    ));
  }

  Future<PaymentMethod> addCard() async {
    final method = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest());
    final customerId = await AuthApi().getCustomerId();
    StripeServer().attachPaymentMethod(method.id, customerId);
    return method;
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final customerId = await AuthApi().getCustomerId();
    final data = await StripeServer().getCards(customerId);
    final methods = data.map((item) {
      final method = PaymentMethod.fromJson(item);
      method.card.expYear = item['card']['exp_year'];
      method.card.expMonth = item['card']['exp_month'];
      return method;
    }).toList();
    return methods;
  }

  Future<PaymentIntentResult> pay(int amount, PaymentMethod method) async {
    final customerId = await AuthApi().getCustomerId();
    final currentSecret =
        await StripeServer().generatePayment(customerId, amount, 'inr');
    return StripePayment.confirmPaymentIntent(
        PaymentIntent(clientSecret: currentSecret, paymentMethodId: method.id));
  }
}
