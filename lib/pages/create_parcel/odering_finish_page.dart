import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:topparcel/data/models/requests/create_rate_request.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/app/app_page.dart';
import 'package:topparcel/pages/success/success_page.dart';

import '../../data/models/requests/create_parcel_request.dart';
import '../../helpers/constans.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/parcels_widget/cart_details_widget.dart';
import '../../widgets/parcels_widget/pay_bottom_widget.dart';

class OrderingFinishPage extends StatefulWidget {
  const OrderingFinishPage({
    super.key,
  });

  @override
  State<OrderingFinishPage> createState() => _OrderingFinishPageState();

  static MaterialPage<dynamic> page() {
    return MaterialPage(
      child: OrderingFinishPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/ordering_finish_page';
}

class _OrderingFinishPageState extends State<OrderingFinishPage> {
  TypePayment typePayment = TypePayment.payPall;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelsState = ParcelsCubit.watchState(context);
    return BlocListener<ParcelsCubit, ParcelsState>(
      listener: (context, state) {
        if (state.status is SuccessPaymentCreateParcelsStatus) {
          PageManager.read(context).push(
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
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(title: 'Ordering'),
        ),
        body: Column(
          children: [
            Expanded(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                      CartDetailsWidget(
                        dateCollection: DateFormat('MMMM dd, yyyy')
                            .format(parcelsState.newRates[0].dateCollection),
                        cost: parcelsState.selecteCourier.cost
                            .replaceAll('.', ','),
                        detailsFromAndTo: _infoSenderReceptient(
                            parcelsState.newRates[0].collection.city,
                            parcelsState.stepOne!.postcodeFrom,
                            parcelsState.newRates[0].address.city,
                            parcelsState.stepOne!.postcodeTo),
                        fullNameFrom: parcelsState.stepOne!.fullNameFrom,
                        insuarance: parcelsState.isInsuarance ? '\€3' : '\€0',
                        way:
                            '${parcelsState.newRates[0].collection.city}-${parcelsState.newRates[0].address.city}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PayBottomWidget(
              selecteTypePay: typePayment,
              cost: parcelsState.selecteCourier.cost,
              insurance: parcelsState.isInsuarance,
              amount: double.tryParse(parcelsState.selecteCourier.cost
                          .replaceAll('\€', '')
                          .replaceAll(' ', '')
                          .replaceAll(',', '.')) !=
                      null
                  ? double.parse(parcelsState.selecteCourier.cost
                      .replaceAll('\€', '')
                      .replaceAll(' ', '')
                      .replaceAll(',', '.'))
                  : 0,
              paymentCallback: () {
                final requestModel = ParcelsRequest(
                  currency: 'EUR',
                  collection: AddressModel(
                    countryId: parcelsState.newRates[0].collection.countryId,
                    region: parcelsState.newRates[0].collection.city,
                    city: parcelsState.stepOne!.cityFrom,
                    addressLine1: parcelsState.stepOne!.addressline1From,
                    addressLine2: parcelsState.stepOne!.addressline2From,
                    zipcode: parcelsState.stepOne!.postcodeFrom,
                    phone: parcelsState.stepOne!.phoneNumberFrom,
                    lastName: parcelsState.stepOne!.fullNameFrom,
                    firstName: parcelsState.stepOne!.fullNameFrom,
                    email: parcelsState.stepOne!.emailFrom,
                    company: parcelsState.selecteCourier.companyName,
                    vatNumber: parcelsState.newRates[0].vat,
                  ),
                  address: AddressModel(
                    countryId: parcelsState.newRates[0].address.countryId,
                    region: parcelsState.newRates[0].address.city,
                    city: parcelsState.stepOne!.cityTo,
                    addressLine1: parcelsState.stepOne!.addressline1To,
                    addressLine2: parcelsState.stepOne!.addressline2To,
                    zipcode: parcelsState.stepOne!.postcodeTo,
                    phone: parcelsState.stepOne!.phoneNumberTo,
                    lastName: parcelsState.stepOne!.fullNameTo,
                    firstName: parcelsState.stepOne!.fullNameTo,
                    email: parcelsState.stepOne!.emailTo,
                    company: parcelsState.selecteCourier.companyName,
                    vatNumber: parcelsState.newRates[0].vat,
                  ),
                  itemsList: parcelsState.itemsList!
                      .map(
                        (e) => ItemModel(
                            id: typeParcels
                                .indexWhere((element) => element == e.type)
                                .toString(),
                            description: e.type,
                            quantity: e.quantity.toString(),
                            cost: e.value.toString(),
                            sku: '',
                            url: ''),
                      )
                      .toList(),
                  shipments: [
                    Shipment(
                      width: parcelsState.newRates[0].width.toDouble(),
                      height: parcelsState.newRates[0].height.toDouble(),
                      weight: parcelsState.newRates[0].weight,
                      length: parcelsState.newRates[0].length,
                    ),
                  ],
                  serviceId: int.parse(parcelsState.selecteCourier.serviceId),
                  apiParcelId: '111',
                  contentsId: '0',
                  reference: '',
                  insurance: parcelsState.isInsuarance ? 1 : 0,
                  iossNumber: '',
                  packageId: parcelsState.newRates[0].packageId,
                );

                ParcelsCubit.read(context).createParcel(requestModel);
              },
              changeTypePayment: (type) {
                setState(() {
                  typePayment = type;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  String _infoSenderReceptient(String countryFrom, String postcodeFrom,
      String countryTo, String postcodeTo) {
    return 'FROM: ${countryFrom}, ${postcodeFrom} | TO: ${countryTo}, ${postcodeTo}';
  }
}
