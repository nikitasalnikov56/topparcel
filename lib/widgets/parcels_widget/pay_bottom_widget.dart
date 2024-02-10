import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/bottom_sheet_cubit.dart';
import 'package:topparcel/global/cubits/stripe_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/global/states/stripe_state.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/app/app_page.dart';
import 'package:topparcel/pages/create_parcel/payment_paypall_page.dart';
import 'package:topparcel/pages/success/success_page.dart';

import '../../global/cubits/parcels_cubit.dart';
import '../../navigation/page_manager.dart';
import '../../pages/payment_credit_card/payment_credit_card_page.dart';
import '../bottom_sheet/selecte_patment_method_bottom_sheet.dart';
import '../buttons/default_button.dart';
import '../text_field/default_text_field.dart';

class PayBottomWidget extends StatefulWidget {
  const PayBottomWidget({
    super.key,
    required this.selecteTypePay,
    required this.cost,
    required this.amount,
    required this.insurance,
    required this.changeTypePayment,
    required this.paymentCallback,
  });

  final TypePayment selecteTypePay;
  final String cost;
  final double amount;
  final bool insurance;
  final Function(TypePayment) changeTypePayment;
  final Function paymentCallback;

  @override
  State<PayBottomWidget> createState() => _PayBottomWidgetState();
}

class _PayBottomWidgetState extends State<PayBottomWidget> {
  TextEditingController _promocodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final userState = UserCubit.watchState(context);
    final parcelsState = ParcelsCubit.watchState(context);
    final stripeState = StripeState();
    return Container(
      color: theme.black,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 60),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    controller: _promocodeController,
                    title: '',
                    onChanged: () {
                      setState(() {});
                    },
                    errorMessage: '',
                    placeholder: 'Enter promocode',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_right_2.svg',
                      color: theme.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: theme.grey,
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
              ),
            ),
            InkWell(
              onTap: () {
                BottomSheetCubit.read(context).showModalBottomSheet(
                  SelectePaymentMethodBottomSheet(
                    typePayment: widget.selecteTypePay,
                    balance: '${userState.user.balance} \€',
                    changeTypeCallback: (type) {
                      widget.changeTypePayment.call(type);
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.selecteTypePay == TypePayment.payPall)
                        Image.asset('assets/images/payPal.png')
                      else if (widget.selecteTypePay == TypePayment.stripe)
                        Image.asset(
                          'assets/images/stripe.png',
                          width: 20,
                        )
                      else
                        SvgPicture.asset(
                          'assets/icons/card.svg',
                          color: theme.white,
                        ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.selecteTypePay == TypePayment.payPall
                            ? 'Paypal'
                            : widget.selecteTypePay == TypePayment.stripe
                                ? 'Stripe'
                                : 'Balance',
                        style: theme.header14Semibold.copyWith(
                          color: theme.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      if (widget.selecteTypePay == TypePayment.balance) ...[
                        Text(
                          '${userState.user.balance}\€',
                          style: theme.header14Semibold.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    'Edit',
                    style: theme.header14Semibold.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: theme.grey,
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: theme.header14Semibold.copyWith(
                    color: theme.white,
                  ),
                ),
                Text(
                  _totalCost(widget.cost.replaceAll('.', ','),
                      parcelsState.isInsuarance),
                  // widget.cost.replaceAll('.', ','),
                  style: theme.header14Semibold.copyWith(
                    color: theme.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            DefaultButton(
              widht: MediaQuery.of(context).size.width - 40,
              title: 'Pay',
              onTap: () {
                // if (widget.selecteTypePay == TypePayment.payPall) {
                //   PageManager.read(context).push(
                //     PaymentPaypallPage.page(
                //       widget.paymentCallback,
                //       widget.amount.toString(),
                //       parcelsState.selecteCourier.serviceId,
                //     ),
                //     rootNavigator: true,
                //   );
                // } else if (widget.selecteTypePay == TypePayment.balance) {
                //   if (userState.user.balance < widget.amount) {
                //     AppMessageCubit.read(context)
                //         .showErrorMessage('Not enough balance');
                //   }
                // } else {
                //   PageManager.read(context).push(
                //       PaymentCreditCardPage.page(
                //         () {},
                //         () {
                //           widget.paymentCallback.call();
                //         },
                //       ),
                //       rootNavigator: true);
                // }
                if (widget.selecteTypePay == TypePayment.payPall) {
                  print(widget.selecteTypePay);
                } else if (widget.selecteTypePay == TypePayment.stripe) {
                  String totalCost = _totalCost(
                      widget.cost.replaceAll('.', ','),
                      parcelsState.isInsuarance);

                  context.read<StripeCubit>()
                    ..makePayment(
                        stripeState, context, totalCost.replaceAll('€ ', ''));
                } else if (widget.selecteTypePay == TypePayment.balance) {
                  print(widget.selecteTypePay);
                }
                // widget.paymentCallback.call();
              },
              status: ButtonStatus.primary,
            ),
          ],
        ),
      ),
    );
  }

  String totalCost = '';
  String _totalCost(String cost, bool isInsuarance) {
    String result =
        cost.replaceAll(RegExp('[^0-9,,.]'), '').replaceAll(',', '.');
    if (double.tryParse(result) != null) {
      return '€ ${double.parse(result) + (isInsuarance ? 3 : 0)}'
          .replaceAll('.', ',');
    }
    return totalCost = cost;
  }
}
