import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';

import '../../data/models/requests/create_parcel_request.dart';

class PaymentPaypallPage extends StatefulWidget {
  const PaymentPaypallPage(
      {super.key,
      required this.successPaymentCallback,
      required this.total,
      required this.id});

  final Function successPaymentCallback;
  final String total;
  final String id;

  @override
  State<PaymentPaypallPage> createState() => _PaymentPaypallPageState();

  static MaterialPage<dynamic> page(
      Function successPaymentCallback, String total, String id) {
    return MaterialPage(
      child: PaymentPaypallPage(
        successPaymentCallback: successPaymentCallback,
        total: total,
        id: id,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/payment_paypall_page';
}

class _PaymentPaypallPageState extends State<PaymentPaypallPage> {
  @override
  Widget build(BuildContext context) {
    final parcelState = ParcelsCubit.watchState(context);
    return Scaffold(
      body: SafeArea(
        child: PaypalCheckout(
          sandboxMode: true,
          clientId: "",
          secretKey: "",
          returnURL: "success.snippetcoder.com",
          cancelURL: "cancel.snippetcoder.com",
          transactions: [
            {
              "amount": {
                "total": widget.total,
                "currency": "EUR",
                "details": {
                  "subtotal": widget.total,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": widget.id,
              "item_list": {
                "items": parcelState.itemsList!
                    .map(
                      (e) => ItemModel(
                          id: e.type,
                          description: e.description,
                          quantity: e.quantity.toString(),
                          cost: e.value.toString(),
                          sku: '',
                          url: ''),
                    )
                    .toList(),
              }
            }
          ],
          note: "",
          onSuccess: (Map params) async {
            widget.successPaymentCallback.call();
          },
          onError: (error) {
            if (error is String)
              AppMessageCubit.read(context).showErrorMessage(error);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
