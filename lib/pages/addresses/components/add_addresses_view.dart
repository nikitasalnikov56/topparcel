import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/requests/create_address_request.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';

import '../../../data/models/response/fetch_country_response.dart';
import '../../../global/cubits/parcels_cubit.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/buttons/default_button.dart';
import '../../../widgets/text_field/default_text_field.dart';
import '../../parcels/components/drop_down_parcel.dart';

class AddAddressesView extends StatefulWidget {
  const AddAddressesView({super.key});

  @override
  State<AddAddressesView> createState() => _AddAddressesViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: AddAddressesView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/add_addresses_view';
}

class _AddAddressesViewState extends State<AddAddressesView> {
  final theme = UIThemes();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vatNumberController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _postCodeController = TextEditingController();

  Country selecteCountryFrom = Country.emptyModel();

  String errorMessageName = '';
  String errorMessageSurName = '';
  String errorMessageEmail = '';
  String errorMessageCountry = '';
  String errorMessageCity = '';
  String errorMessageRegion = '';
  String errorMessageAddressLine1 = '';
  String errorMessageAddressLine2 = '';
  String errorMessagePostCode = '';

  bool filteredAnswer = false;
  bool filteredAddAddress = false;

  bool isVisible = false;
  bool isError = false;

  bool isAddressLine2 = false;

  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);
    final parcelsState = ParcelsCubit.watchState(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Add Address',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            color: theme.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextField(
                    controller: _nameController,
                    title: 'Name*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageName,
                    placeholder: 'Daria',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _surNameController,
                    title: 'Surname*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageSurName,
                    placeholder: 'Zhukovich',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _emailController,
                    title: 'Email*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageEmail,
                    placeholder: 'name@email.com',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/email.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _phoneNumberController,
                    title: 'Phone number',
                    onChanged: () {},
                    errorMessage: '',
                    placeholder: '+375297507755',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/phone.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      DefaultTextField(
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        controller: _vatNumberController,
                        title: 'VAT number',
                        onChanged: () {},
                        errorMessage: '',
                        placeholder: '34',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DefaultTextField(
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        controller: _companyController,
                        title: 'Company',
                        onChanged: () {},
                        errorMessage: '',
                        placeholder: 'XONE',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            color: theme.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownCreateParcel(
                    widht: (MediaQuery.of(context).size.width - 40),
                    placeholder: 'Select',
                    seleteElement: selecteCountryFrom.name,
                    items:
                        parcelsState.countriesList.map((e) => e.name).toList(),
                    onSelected: (element, index) {
                      setState(() {
                        selecteCountryFrom = parcelsState.countriesList[index];
                      });
                    },
                    error: errorMessageCountry,
                    title: 'Country*',
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _cityController,
                    title: 'City*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageCity,
                    placeholder: 'London',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/city.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _regionController,
                    title: 'Region*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageRegion,
                    placeholder: 'Suffolk',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/city.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _addressLine1Controller,
                    title: 'Address line 1*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessageAddressLine1,
                    placeholder: '12 Tower street',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/address.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  InkWell(
                      onTap: () {
                        setState(() {
                          isAddressLine2 = !isAddressLine2;
                        });
                      },
                      child: isAddressLine2
                          ? DefaultTextField(
                              controller: _addressLine2Controller,
                              title: 'Address line 2',
                              onChanged: () {},
                              errorMessage: errorMessageAddressLine2,
                              placeholder: '12 Tower street',
                              preffixIcon: SvgPicture.asset(
                                'assets/icons/address.svg',
                                color: theme.darkGrey,
                              ),
                            )
                          : Text('Add address +',
                              style: theme.text16Medium
                                  .copyWith(color: theme.orangeColor))),

                  SizedBox(
                    height: 20,
                  ),
                  DefaultTextField(
                    controller: _postCodeController,
                    title: 'Postcode*',
                    onChanged: () {
                      _checkEmpty();
                    },
                    errorMessage: errorMessagePostCode,
                    placeholder: 'LW123GX',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/postcode.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultButton(
              widht: MediaQuery.of(context).size.width,
              title: 'Save',
              onTap: () {
                _validation();
                if (!isError) {
                  final requestModel = CreateAddressRequest(
                    // id: userState.id,
                    token: '',
                    region: _regionController.text,
                    countryId: int.parse(selecteCountryFrom.id),
                    city: _cityController.text,
                    addressLine1: _addressLine1Controller.text,
                    addressLine2: _addressLine2Controller.text,
                    zipcode: _postCodeController.text,
                    phone: _phoneNumberController.text,
                    lastname: _surNameController.text,
                    firstname: _nameController.text,
                    email: userState.email,
                    company: _companyController.text,
                    vatNumber: _vatNumberController.text,
                  );
                  UserCubit.read(context).addAddress(requestModel);
                }
              },
              status: isVisible ? ButtonStatus.primary : ButtonStatus.disable,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  void _checkEmpty() {
    setState(() {
      if (_nameController.text.isNotEmpty &&
          _surNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          selecteCountryFrom.name.isNotEmpty &&
          _cityController.text.isNotEmpty &&
          _addressLine1Controller.text.isNotEmpty &&
          _postCodeController.text.isNotEmpty &&
          _regionController.text.isNotEmpty) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  void _validation() {
    setState(() {
      errorMessageEmail = errorMessageAddressLine1 = errorMessageCity =
          errorMessageCountry = errorMessageName = errorMessagePostCode =
              errorMessageSurName = errorMessageRegion = '';
      isError = false;

      if (_nameController.text.isEmpty) {
        errorMessageName = 'Enter Name';
        isError = true;
      }

      if (_surNameController.text.isEmpty) {
        errorMessageSurName = 'Enter Surname';
        isError = true;
      }

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Enter Email';
        isError = true;
      } else if (!EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Invalid email format';
        isError = true;
      }

      if (selecteCountryFrom.name.isEmpty) {
        errorMessageCountry = 'Enter Country';
        isError = true;
      }

      if (_cityController.text.isEmpty) {
        errorMessageCity = 'Enter City';
        isError = true;
      }

      if (_regionController.text.isEmpty) {
        errorMessageCity = 'Enter Region';
        isError = true;
      }

      if (_addressLine1Controller.text.isEmpty) {
        errorMessageAddressLine1 = 'Enter Address Line 1';
        isError = true;
      }

      if (_postCodeController.text.isEmpty) {
        errorMessagePostCode = 'Enter Postcode';
        isError = true;
      }
    });
  }
}
