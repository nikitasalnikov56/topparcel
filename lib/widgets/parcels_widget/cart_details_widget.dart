import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/parcels_widget/logo_parcel_widget.dart';

class CartDetailsWidget extends StatelessWidget {
  const CartDetailsWidget({
    super.key,
    required this.cost,
    required this.detailsFromAndTo,
    required this.insuarance,
    required this.fullNameFrom,
    required this.way,
    required this.dateCollection,
    this.isSelecte = false,
    this.isActivateSelecteCart = false,
    this.seletceCallback,
  });

  final String cost;
  final String detailsFromAndTo;
  final String insuarance;
  final String fullNameFrom;
  final String way;
  final bool isActivateSelecteCart;
  final bool isSelecte;
  final Function? seletceCallback;
  final String dateCollection;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Container(
      // height: 260,
      decoration: BoxDecoration(
        color: theme.white,
        boxShadow: [
          BoxShadow(
            color: theme.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoParcelWidget(details: detailsFromAndTo),
                if (isActivateSelecteCart) ...[
                  InkWell(
                    onTap: seletceCallback != null
                        ? () {
                            seletceCallback!.call();
                          }
                        : null,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelecte ? theme.primaryColor : theme.lightGrey,
                          width: 3,
                        ),
                      ),
                      child: isSelecte
                          ? Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sender name',
                  style: theme.text14Regular,
                ),
                Text(
                  fullNameFrom,
                  style: theme.text12Semibold,
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Way',
                  style: theme.text14Regular,
                ),
                Text(
                  way,
                  style: theme.text12Regular,
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Collection date',
                  style: theme.text14Regular,
                ),
                Text(
                  dateCollection,
                  style: theme.text12Regular,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 80,
              color: theme.extraLightGrey,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Insurance',
                  style: theme.text14Regular,
                ),
                Text(
                  insuarance,
                  style: theme.header14Bold,
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cost',
                  style: theme.text14Regular,
                ),
                Text(
                  cost,
                  style: theme.header14Bold,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
