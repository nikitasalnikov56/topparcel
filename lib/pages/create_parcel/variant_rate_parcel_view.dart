import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/create_parcel/ordering_step_one_page.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:topparcel/widgets/dialogs/information_company_dialog.dart';

class VariantRateParcelView extends StatelessWidget {
  const VariantRateParcelView({super.key});

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: VariantRateParcelView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/variant_rate_parcel_page';

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelsCubit = ParcelsCubit.watchState(context);

    return BlocListener<ParcelsCubit, ParcelsState>(
      listener: (context, state) {
        if (state.status is OrderingStepOneStatus) {
          PageManager.read(context).push(
              OrderingStepOnePage.page(parcelsCubit.newRates[0].dateCollection),
              rootNavigator: true);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(title: 'Parcel'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FROM: ${parcelsCubit.newRates[0].collection.city}, ${parcelsCubit.newRates[0].collection.zipcode} | TO: ${parcelsCubit.newRates[0].address.city}, ${parcelsCubit.newRates[0].address.zipcode}',
                      style: theme.text14Medium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'PARCELS DETAILS: ${parcelsCubit.newRates[0].weight}kg SIZE ${parcelsCubit.newRates[0].length}x${parcelsCubit.newRates[0].width}x${parcelsCubit.newRates[0].height} cm',
                      style: theme.text14Medium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.separated(
                  itemCount: parcelsCubit.newRates[0].couriers.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 12,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RateParcelCellWidget(
                        from:
                            '${parcelsCubit.newRates[0].collection.city}, ${parcelsCubit.newRates[0].collection.zipcode}',
                        to: '${parcelsCubit.newRates[0].address.city}, ${parcelsCubit.newRates[0].address.zipcode}',
                        weight: '${parcelsCubit.newRates[0].weight}kg',
                        size:
                            '${parcelsCubit.newRates[0].length}x${parcelsCubit.newRates[0].width}x${parcelsCubit.newRates[0].height} cm',
                        countDays:
                            parcelsCubit.newRates[0].couriers[index].countDays,
                        pickupDate: DateFormat('MMMM dd, yyyy')
                            .format(parcelsCubit.newRates[0].dateCollection),
                        cost:
                            '${parcelsCubit.newRates[0].couriers[index].cost} | inc. VAT ${parcelsCubit.newRates[0].vat} ',
                        selecteCallback: () {
                          ParcelsCubit.read(context).selecteRateParcel(
                              parcelsCubit.newRates[0].couriers[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RateParcelCellWidget extends StatelessWidget {
  const RateParcelCellWidget({
    super.key,
    required this.from,
    required this.to,
    required this.size,
    required this.countDays,
    required this.pickupDate,
    required this.cost,
    required this.weight,
    required this.selecteCallback,
  });

  final String from;
  final String to;
  final String weight;
  final String size;
  final String countDays;
  final String pickupDate;
  final String cost;
  final Function selecteCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 34,
                        width: 34,
                        child: Image.asset('assets/images/logo_parcel.png'),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'GlobalPost GB Standart',
                              style: theme.header16Bold,
                            ),
                            // Text(
                            //   'FROM: ${from} | TO: ${to}',
                            //   style: theme.text10Regular,
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 2,
                            // ),
                            // Text(
                            //   'PARCELS DETAILS: ${weight} SIZE ${size}',
                            //   style: theme.text10Regular,
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 2,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return InformationCompanyDialog();
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/info.svg',
                    color: theme.lightGrey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // _informationCell(theme, 'Package weight', weight),
            // _informationCell(theme, 'Package size', size),
            _informationCell(theme, 'Printer', 'Need a printer',
                isPrinter: true),
            _informationCell(theme, 'Delivery days', countDays),
            _informationCell(theme, 'Courier pickup date', pickupDate),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 72,
              color: theme.extraLightGrey,
            ),
            SizedBox(
              height: 5,
            ),
            _informationCell(theme, 'Cost', cost, isCost: true),
            SizedBox(
              height: 30,
            ),
            DefaultButton(
              widht: MediaQuery.of(context).size.width - 72,
              title: 'Book',
              onTap: () {
                selecteCallback.call();
              },
              status: ButtonStatus.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationCell(UIThemes theme, String title, String details,
      {bool isCost = false, bool isPrinter = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.text14Regular.copyWith(color: theme.lightGrey),
          ),
          if (!isPrinter)
            Text(
              details,
              style: isCost ? theme.header14Bold : theme.text14Regular,
            )
          else
            Container(
              decoration: BoxDecoration(
                color: theme.printerStatus.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                child: Text(
                  details,
                  style:
                      theme.text12Regular.copyWith(color: theme.printerStatus),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
