import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/response/fetch_addresses_response.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

import '../../../data/models/requests/create_address_request.dart';
import '../../../data/models/response/fetch_country_response.dart';
import '../../../global/cubits/parcels_cubit.dart';
import '../../../global/cubits/user_cubit.dart';
import '../../../navigation/page_manager.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/buttons/default_button.dart';
import '../../../widgets/text_field/default_text_field.dart';
import '../../parcels/components/drop_down_parcel.dart';

class EditAddressesView extends StatefulWidget {
  const EditAddressesView({super.key, required this.address});

  final UserAddress address;

  @override
  State<EditAddressesView> createState() => _EditAddressesViewState();

  static MaterialPage<dynamic> page(UserAddress address) {
    return MaterialPage(
      child: EditAddressesView(
        address: address,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/edit_addresses_view';
}

class _EditAddressesViewState extends State<EditAddressesView> {
  final theme = UIThemes();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vatNumberController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _postCodeController = TextEditingController();
  TextEditingController _regionController = TextEditingController();

  Country selecteCountryFrom = Country.emptyModel();

  String errorMessageName = '';
  String errorMessageSurName = '';
  String errorMessageEmail = '';
  String errorMessageCountry = '';
  String errorMessageCity = '';
  String errorMessageAddressLine1 = '';
  String errorMessageAddressLine2 = '';
  String errorMessagePostCode = '';

  bool filteredAnswer = false;
  bool filteredAddAddress = false;

  bool isError = false;
  bool isAddressLine2 = false;

  @override
  Widget build(BuildContext context) {
    final parcelsState = ParcelsCubit.watchState(context);
    selecteCountryFrom = parcelsState.countriesList.firstWhere(
                (element) => element.id == widget.address.countryId) !=
            null
        ? parcelsState.countriesList
            .firstWhere((element) => element.id == widget.address.countryId)
        : Country.emptyModel();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Editing',
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
                    onChanged: () {},
                    errorMessage: errorMessageName,
                    placeholder: widget.address.firstname,
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
                    onChanged: () {},
                    errorMessage: errorMessageSurName,
                    placeholder: widget.address.lastname,
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
                    onChanged: () {},
                    errorMessage: errorMessageEmail,
                    placeholder: widget.address.email,
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
                    placeholder: widget.address.phone,
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
                        placeholder: widget.address.vatNumber,
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
                        placeholder: widget.address.company,
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
                    controller: _regionController,
                    title: 'Region*',
                    onChanged: () {},
                    errorMessage: '',
                    placeholder: widget.address.region,
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/city.svg',
                      color: theme.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: _cityController,
                    title: 'City*',
                    onChanged: () {},
                    errorMessage: errorMessageCity,
                    placeholder: widget.address.city,
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
                    onChanged: () {},
                    errorMessage: errorMessageAddressLine1,
                    placeholder: widget.address.addressLine1,
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
                      child: widget.address.addressLine2.isNotEmpty
                          ? DefaultTextField(
                              controller: _addressLine2Controller,
                              title: 'Address line 2',
                              onChanged: () {},
                              errorMessage: errorMessageAddressLine2,
                              placeholder: widget.address.addressLine2,
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
                    onChanged: () {},
                    errorMessage: errorMessagePostCode,
                    placeholder: widget.address.zipcode,
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/postcode.svg',
                      color: theme.darkGrey,
                    ),
                  ),
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
                    id: int.parse(widget.address.id),
                    token: '',
                    region: _regionController.text.isNotEmpty
                        ? _regionController.text
                        : widget.address.region,
                    countryId: int.parse(selecteCountryFrom.id),
                    city: _cityController.text.isNotEmpty
                        ? _cityController.text
                        : widget.address.city,
                    addressLine1: _addressLine1Controller.text.isNotEmpty
                        ? _addressLine1Controller.text
                        : widget.address.addressLine1,
                    addressLine2: _addressLine2Controller.text.isNotEmpty
                        ? _addressLine2Controller.text
                        : widget.address.addressLine2,
                    zipcode: _postCodeController.text.isNotEmpty
                        ? _postCodeController.text
                        : widget.address.zipcode,
                    phone: _phoneNumberController.text.isNotEmpty
                        ? _phoneNumberController.text
                        : widget.address.phone,
                    lastname: _surNameController.text.isNotEmpty
                        ? _surNameController.text
                        : widget.address.lastname,
                    firstname: _nameController.text.isNotEmpty
                        ? _nameController.text
                        : widget.address.firstname,
                    email: _emailController.text.isNotEmpty
                        ? _emailController.text
                        : widget.address.email,
                    company: _companyController.text.isNotEmpty
                        ? _companyController.text
                        : widget.address.company,
                    vatNumber: _vatNumberController.text.isNotEmpty
                        ? _vatNumberController.text
                        : widget.address.vatNumber,
                  );
                  UserCubit.read(context)
                      .addAddress(requestModel, isEdit: true);
                }
              },
              status: ButtonStatus.primary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  void _validation() {
    setState(() {
      errorMessageEmail = errorMessageAddressLine1 = errorMessageCity =
          errorMessageCountry = errorMessageName =
              errorMessagePostCode = errorMessageSurName = '';
      isError = false;

      if (_emailController.text.isNotEmpty &&
          !EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Invalid email format';
        isError = true;
      }
    });
  }
}
