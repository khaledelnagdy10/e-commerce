import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:store_app2/stripe_payment/api_keys.dart';

abstract class PaymentManager {
  static Future<bool> makePayment(int amount, String currency) async {
    try {
      final clientSecret = await _getClientSecret(
        (amount * 100).toString(),
        currency,
      );

      await _initializePaymentSheet(clientSecret);

      try {
        await Stripe.instance.presentPaymentSheet();
        return true; // الدفع نجح
      } on StripeException catch (e) {
        return false; // المستخدم قفل X أو الدفع فشل
      }
    } catch (e) {
      return false; // API error
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

  static Future<void> _presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        print("User canceled the payment");
        return; // مش Error — نخرج وخلاص
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    final response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      },
    );

    return response.data["client_secret"];
  }
}
