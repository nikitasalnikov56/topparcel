import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:topparcel/global/states/stripe_state.dart';
import 'package:http/http.dart' as http;
import 'package:topparcel/helpers/constans.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/app/app_page.dart';
import 'package:topparcel/pages/success/success_page.dart';

class StripeCubit extends Cubit<StripeState> {
  StripeCubit() : super(StripeState());

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print('Error in createPaymentIntent: $err');
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully: $value");
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment(
      StripeState state, BuildContext context, String totalCost) async {
    try {
      state.paymentIntent =
          await createPaymentIntent(totalCost.replaceAll(',', ''), 'EUR');

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "EUR",
        currencyCode: "EUR",
        testEnv: true,
      );

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: state
                  .paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Nikita',
              googlePay: gpay,
            ),
          )
          .then((value) {});
      var result = await Stripe.instance.presentPaymentSheet();
      if (result == null) {
        print(state.paymentIntent?['id']);
        await PageManager.read(context).push(
          SuccessPage.page(
            'Payment completed!',
            'Payment was successful!',
            'Back',
            () {
              PageManager.read(context)
                  .clearStackAndPushPage(AppPage.page(), rootNavigator: true);
            },
          ),
          rootNavigator: true,
        );
      } else {
        //STEP 3: Display Payment sheet
        displayPaymentSheet();
      }
    } catch (err) {
      print('Error in makePayment: $err');
    }
  }
}
