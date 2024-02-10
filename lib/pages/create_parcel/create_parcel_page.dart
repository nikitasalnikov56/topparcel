import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/models/app_model/parcel_content_model.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/helpers/constans.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/create_parcel/variant_rate_parcel_view.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';

import '../../data/models/requests/create_rate_request.dart';
import '../../widgets/buttons/default_button.dart';
import '../../widgets/text_field/default_text_field.dart';
import '../parcels/components/drop_down_parcel.dart';

enum TypeSending { document, parcel }

class CreateParcelPage extends StatefulWidget {
  const CreateParcelPage({super.key});

  @override
  State<CreateParcelPage> createState() => _CreateParcelPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: CreateParcelPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/create_parcel_page';
}

class _CreateParcelPageState extends State<CreateParcelPage> {
  TextEditingController postcodeFromController = TextEditingController();
  TextEditingController postcodeToController = TextEditingController();
  TextEditingController weigthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Country selecteCountryFrom = Country.emptyModel();
  Country selecteCountryTo = Country.emptyModel();

  String errorMessageCountryFrom = '';
  String errorMessageCountryTo = '';
  String errorMessagePostcodeFrom = '';
  String errorMessagePostcodeTo = '';
  String errorMessageWeigth = '';
  String errorMessageLength = '';
  String errorMessageWidth = '';
  String errorMessageHeight = '';

  List<ParcelContentModel> parcelsList = [];

  DateTime startDate = DateTime.now();

  TypeSending typeSending = TypeSending.parcel;

  bool isInsuarance = false;
  bool isErrorFirstInfo = false;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelsState = ParcelsCubit.watchState(context);
    return BlocListener<ParcelsCubit, ParcelsState>(
      listenWhen: (previous, current) {
        return current.status is RateParcelsStatus;
      },
      listener: (context, state) {
        PageManager.read(context).push(VariantRateParcelView.page());
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: CustomAppBar(
              title:
                  'New ${typeSending == TypeSending.document ? 'document' : 'parcel'}',
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DefaultButton(
                              widht:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              title: 'Parcel',
                              onTap: () {
                                setState(() {
                                  typeSending = TypeSending.parcel;
                                });
                              },
                              status: typeSending == TypeSending.parcel
                                  ? ButtonStatus.primary
                                  : ButtonStatus.disable,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            DefaultButton(
                              widht:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              title: 'Document',
                              onTap: () {
                                setState(() {
                                  typeSending = TypeSending.document;
                                });
                                ;
                              },
                              status: typeSending == TypeSending.document
                                  ? ButtonStatus.primary
                                  : ButtonStatus.disable,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your parcel details and we\'ll deliver it!',
                          style: theme.text14Regular,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            DropDownCreateParcel(
                              widht:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              placeholder: 'Select',
                              seleteElement: selecteCountryFrom.name,
                              items: parcelsState.countriesList
                                  .where((element) => element.sendable)
                                  .toList()
                                  .map((e) => e.name)
                                  .toList(),
                              onSelected: (element, index) {
                                setState(() {
                                  selecteCountryFrom = parcelsState
                                      .countriesList
                                      .where((element) => element.sendable)
                                      .toList()[index];
                                });
                              },
                              error: errorMessageCountryFrom,
                              title: 'Country (from)',
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: postcodeFromController,
                                title: 'Postcode',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessagePostcodeFrom,
                                placeholder: '123456',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            DropDownCreateParcel(
                              widht:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              placeholder: 'Select',
                              seleteElement: selecteCountryTo.name,
                              items: parcelsState.countriesList
                                  .where((element) => element.deliverable)
                                  .map((e) => e.name)
                                  .toList(),
                              onSelected: (element, index) {
                                setState(() {
                                  selecteCountryTo =
                                      parcelsState.countriesList[index];
                                });
                              },
                              error: errorMessageCountryTo,
                              title: 'Country (to)',
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: postcodeToController,
                                title: 'Postcode',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessagePostcodeTo,
                                placeholder: '123456',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: weigthController,
                                title: 'Weight',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessageWeigth,
                                placeholder: '0.5 kg',
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: lengthController,
                                title: 'Length',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessageLength,
                                placeholder: '0 cm',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: widthController,
                                title: 'Width',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessageWidth,
                                placeholder: '0 cm',
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 47) / 2,
                              child: DefaultTextField(
                                controller: heightController,
                                title: 'Height',
                                onChanged: () {
                                  setState(() {});
                                },
                                errorMessage: errorMessageHeight,
                                placeholder: '0 cm',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                widht: MediaQuery.of(context).size.width - 40,
                title: 'Next',
                onTap: () async {
                  _validationFirstInfo();
                  if (!isErrorFirstInfo) {
                    final parcels = [
                      Parcel(
                        currency: 'EUR',
                        collection: Address(
                          countryId: int.parse(selecteCountryFrom.id),
                          city: selecteCountryFrom.name,
                          zipcode: postcodeFromController.text,
                        ),
                        address: Address(
                          countryId: int.parse(selecteCountryTo.id),
                          city: selecteCountryTo.name,
                          zipcode: postcodeToController.text,
                        ),
                        shipments: [
                          Shipment(
                            width: double.parse(widthController.text),
                            height: double.parse(heightController.text),
                            weight: double.parse(weigthController.text),
                            length: int.parse(lengthController.text),
                          ),
                        ],
                        // serviceId: 1,
                        packageId:
                            typeSending == TypeSending.parcel ? 100 : 200,
                      ),
                    ];
                    try {
                      await ParcelsCubit.read(context).createRate(parcels);
                    } catch (e) {
                      print('Error during createRate: $e');
                    }
                  }
                },
                status: ButtonStatus.primary,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validationFirstInfo() {
    setState(() {
      errorMessageCountryFrom = errorMessageCountryTo =
          errorMessagePostcodeFrom = errorMessagePostcodeTo =
              errorMessageWeigth = errorMessageLength =
                  errorMessageWidth = errorMessageHeight = '';
      isErrorFirstInfo = false;

      if (selecteCountryFrom.id.isEmpty) {
        errorMessageCountryFrom = 'Selecte country from';
        isErrorFirstInfo = true;
      }
      if (selecteCountryTo.id.isEmpty) {
        errorMessageCountryTo = 'Selecte country to';
        isErrorFirstInfo = true;
      }
      if (postcodeFromController.text.isEmpty) {
        errorMessagePostcodeFrom = 'Enter postcode from';
        isErrorFirstInfo = true;
      }
      if (postcodeToController.text.isEmpty) {
        errorMessagePostcodeTo = 'Enter postcode to';
        isErrorFirstInfo = true;
      }
      if (weigthController.text.isEmpty) {
        errorMessageWeigth = 'Enter weigth';
        isErrorFirstInfo = true;
      }
      if (lengthController.text.isEmpty) {
        errorMessageLength = 'Enter length';
        isErrorFirstInfo = true;
      }
      if (widthController.text.isEmpty) {
        errorMessageWidth = 'Enter width';
        isErrorFirstInfo = true;
      }
      if (heightController.text.isEmpty) {
        errorMessageHeight = 'Enter height';
        isErrorFirstInfo = true;
      }
    });
  }
}
