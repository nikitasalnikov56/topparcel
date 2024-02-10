import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/create_parcel/odering_finish_page.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';

import '../../navigation/page_manager.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class OrderingStepThreePage extends StatefulWidget {
  const OrderingStepThreePage({
    super.key,
  });

  @override
  State<OrderingStepThreePage> createState() => _OrderingStepThreePageState();

  static MaterialPage<dynamic> page() {
    return MaterialPage(
      child: OrderingStepThreePage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/ordering_step_three_page';
}

class _OrderingStepThreePageState extends State<OrderingStepThreePage> {
  bool isInsuarance = false;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return BlocListener<ParcelsCubit, ParcelsState>(
      listener: (context, state) {
        if (state.status is OrderingPayStatus) {
          PageManager.read(context)
              .push(OrderingFinishPage.page(), rootNavigator: true);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(title: 'Ordering'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Step 3',
                        style: theme.text14Regular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: theme.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Insurance',
                              style: theme.header16Bold,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'In the parcel is insured, we will refound 100% of the value of the parcel in the case of loss or damage',
                              style: theme.text14Regular,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Full cover of your parcel for only ',
                                style: theme.header16Bold,
                                children: [
                                  TextSpan(
                                    text: '\€3',
                                    style: theme.header16Bold.copyWith(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              highlightColor: theme.white,
                              focusColor: theme.white,
                              splashColor: theme.white,
                              overlayColor:
                                  MaterialStateProperty.all(theme.white),
                              onTap: () {
                                setState(() {
                                  isInsuarance = !isInsuarance;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isInsuarance
                                            ? theme.primaryColor
                                            : theme.lightGrey,
                                        width: 3,
                                      ),
                                    ),
                                    child: isInsuarance
                                        ? Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: theme.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Add Insurance',
                                    style: theme.text16Medium,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              children: [
                                if (!isInsuarance) ...[
                                  SvgPicture.asset(
                                    'assets/icons/info.svg',
                                    color: theme.errorColor,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Text(
                                      'You will take the risk. The parcel is NOT covered!',
                                      style: theme.text14Regular
                                          .copyWith(color: theme.errorColor),
                                      maxLines: 3,
                                    ),
                                  ),
                                ] else ...[
                                  SvgPicture.asset(
                                    'assets/icons/valid.svg',
                                    color: theme.green,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                      'Your parcecl is fully protected from lost and damage!',
                                      style: theme.text14Regular
                                          .copyWith(color: theme.green),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                  ),
                                ]
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: DefaultButton(
                  widht: MediaQuery.of(context).size.width - 40,
                  title: 'Next step',
                  onTap: () {
                    ParcelsCubit.read(context)
                        .doneInsuaranceOrdering(isInsuarance);
                  },
                  status: ButtonStatus.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
