import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

class SelectePaymentMethodBottomSheet extends StatelessWidget {
  const SelectePaymentMethodBottomSheet({
    super.key,
    required this.typePayment,
    required this.changeTypeCallback,
    required this.balance,
  });

  final TypePayment typePayment;
  final String balance;
  final Function(TypePayment) changeTypeCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: theme.black,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: theme.grey,
                      borderRadius: BorderRadius.circular(3)),
                  height: 3,
                  width: 40,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Select payment method',
              style: theme.header16Bold.copyWith(color: theme.white),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                changeTypeCallback.call(TypePayment.payPall);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/payPal.png'),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Paypal',
                        style: theme.header14Semibold.copyWith(
                          color: theme.white,
                        ),
                      ),
                    ],
                  ),
                  if (typePayment == TypePayment.payPall)
                    SvgPicture.asset(
                      'assets/icons/check.svg',
                      color: theme.primaryColor,
                    )
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
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                changeTypeCallback.call(TypePayment.stripe);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/stripe.png',
                        width: 20,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Stripe',
                        style: theme.header14Semibold.copyWith(
                          color: theme.white,
                        ),
                      ),
                    ],
                  ),
                  if (typePayment == TypePayment.stripe)
                    SvgPicture.asset(
                      'assets/icons/check.svg',
                      color: theme.primaryColor,
                    )
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
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                changeTypeCallback.call(TypePayment.balance);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/card.svg',
                        color: theme.white,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Balance',
                        style: theme.header14Semibold.copyWith(
                          color: theme.white,
                        ),
                      ),
                    ],
                  ),
                  if (typePayment == TypePayment.balance)
                    SvgPicture.asset(
                      'assets/icons/check.svg',
                      color: theme.primaryColor,
                    )
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     changeTypeCallback.call(TypePayment.creditCard);
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           SvgPicture.asset(
            //             'assets/icons/card.svg',
            //             color: theme.white,
            //           ),
            //           SizedBox(
            //             width: 16,
            //           ),
            //           Text(
            //             'Credit card',
            //             style: theme.header14Semibold.copyWith(
            //               color: theme.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //       if (typePayment == TypePayment.creditCard)
            //         SvgPicture.asset(
            //           'assets/icons/check.svg',
            //           color: theme.primaryColor,
            //         )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
