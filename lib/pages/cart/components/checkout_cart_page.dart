import 'package:flutter/material.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/widgets/parcels_widget/logo_parcel_widget.dart';

import '../../../navigation/page_manager.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/parcels_widget/pay_bottom_widget.dart';
import '../../app/app_page.dart';
import '../../success/success_page.dart';

class CheckoutCartPage extends StatefulWidget {
  const CheckoutCartPage({
    super.key,
    required this.selecteCart,
    required this.initCallback,
  });

  final List<int> selecteCart;
  final Function initCallback;

  @override
  State<CheckoutCartPage> createState() => _CheckoutCartPageState();

  static MaterialPage<dynamic> page(
      List<int> selecteCart, Function initCallback) {
    return MaterialPage(
      child: CheckoutCartPage(
        selecteCart: selecteCart,
        initCallback: initCallback,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/checkout_cart_page';
}

class _CheckoutCartPageState extends State<CheckoutCartPage> {
  TypePayment typePayment = TypePayment.payPall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(title: 'Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.selecteCart.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LogoParcelWidget(
                    details: 'FROM: United Kingdom, LW123GX | TO: Italy, 80100',
                    isDecoration: true,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16,
                );
              },
            ),
          ),
          PayBottomWidget(
            selecteTypePay: typePayment,
            cost: '\€50,97',
            amount: 0,
            insurance: false,
            changeTypePayment: (type) {
              setState(() {
                typePayment = type;
              });
            },
            paymentCallback: () {
              PageManager.read(context).push(
                SuccessPage.page(
                  'Payment completed!',
                  'Payment was successful!',
                  'Back',
                  () {
                    widget.initCallback.call();
                    PageManager.read(context).clearStackAndPushPage(
                        AppPage.page(),
                        rootNavigator: true);
                  },
                ),
                rootNavigator: true,
              );
            },
          )
        ],
      ),
    );
  }
}
