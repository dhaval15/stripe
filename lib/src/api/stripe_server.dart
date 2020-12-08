import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const SECRET =
    'sk_test_51Hvyz1D1mkFLDprg6xTxy2dYsytRjRZHmvN895qKnJliCqbanHE9T1zBGjn0pFcuKG45jdSAbB2LtLxEfNVdUBYW00Jmj36dpx';

class StripeServer {
  Future<String> generatePayment(
      String customerId, int amount, String currency) async {
    final result = await http.post(
      'https://api.stripe.com/v1/payment_intents',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $SECRET',
      },
      body: {
        'amount': amount.toString(),
        'currency': currency,
        'customer': customerId,
      },
    );
    return JsonDecoder().convert(result.body)['client_secret'];
  }

  Future<String> createCustomer(String emailId) async {
    final result = await http.post(
      'https://api.stripe.com/v1/customers',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $SECRET',
      },
      body: {
        'email': emailId,
      },
    );
    return JsonDecoder().convert(result.body)['id'];
  }

  Future attachPaymentMethod(String paymentMethodId, String customerId) async {
    await http.post(
      'https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $SECRET',
      },
      body: {
        'customer': customerId,
      },
    );
  }

  Future<List<dynamic>> getCards(String customerId) async {
    final result = await http.get(
      'https://api.stripe.com/v1/payment_methods?type=card&customer=$customerId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $SECRET',
      },
    );
    return JsonDecoder().convert(result.body)['data'];
  }
}
