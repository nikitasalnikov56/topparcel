import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/requests/update_user_request.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/parcels/components/drop_down_parcel.dart';
import 'package:topparcel/widgets/loading_widget.dart';

import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/buttons/default_button.dart';
import '../../../../widgets/text_field/default_text_field.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: PersonalInfoView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/personal_info_view';
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final theme = UIThemes();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _postCodeController = TextEditingController();
  Country selecteCountryFrom = Country.emptyModel();

  String errorMessageCountryFrom = '';
  String errorMessageName = '';
  String errorMessageSurname = '';
  String errorMessageCity = '';
  String errorMessageAddressLine1 = '';
  String errorMessageAddressLine2 = '';
  String errorMessagePostCode = '';
  String errorMessageCountry = '';

  TextEditingController _countryController = TextEditingController();
  TextEditingController _phoneNumber1Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _vatNumberController = TextEditingController();
  TextEditingController _eoriNumberController = TextEditingController();
  TextEditingController _iossNumberController = TextEditingController();

  String errorMessageEmail = '';

  bool filteredAnswer = false;
  bool filteredAddAddress = false;
  bool isAddressLine2 = false;

  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);
    final parcelState = ParcelsCubit.watchState(context);
    final countries = ParcelsCubit.watchState(context).countriesList;
    // final countryModel = getCountryFromId(userState.user.countryId, countries);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Personal information',
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 108,
                  width: 108,
                  decoration: BoxDecoration(
                    color: theme.extraLightGrey,
                    borderRadius: BorderRadius.circular(54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: theme.white,
                    ),
                  ),
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
                        'Personal information',
                        style: theme.header16Bold,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextField(
                        controller: _nameController,
                        title: 'Name*',
                        onChanged: () {},
                        errorMessage: errorMessageName,
                        placeholder: userState.user.firstname,
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
                        errorMessage: errorMessageSurname,
                        placeholder: userState.user.lastname,
                        preffixIcon: SvgPicture.asset(
                          'assets/icons/person.svg',
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
                        placeholder: userState.user.phone != '+0'
                            ? userState.user.phone
                            : '',
                        preffixIcon: SvgPicture.asset(
                          'assets/icons/phone.svg',
                          color: theme.darkGrey,
                        ),
                      ),
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
                      Text(
                        'Address',
                        style: theme.header16Bold,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropDownCreateParcel(
                        widht: double.infinity,
                        placeholder: userState.user.county,
                        seleteElement: selecteCountryFrom.name,
                        items: parcelState.countriesList
                            .map((e) => e.name)
                            .toList(),
                        onSelected: (element, index) {
                          setState(() {
                            selecteCountryFrom =
                                parcelState.countriesList[index];
                          });
                        },
                        error: errorMessageCountryFrom,
                        title: 'Country*',
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      DefaultTextField(
                        controller: _cityController,
                        title: 'City*',
                        onChanged: () {},
                        errorMessage: errorMessageCity,
                        placeholder: userState.user.city != 'empty'
                            ? userState.user.city
                            : '',
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
                        placeholder: userState.user.addressLine1 != 'empty'
                            ? userState.user.addressLine1
                            : '',
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
                                  placeholder:
                                      userState.user.addressLine2 != 'empty'
                                          ? userState.user.addressLine2
                                          : '',
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
                        placeholder: userState.user.postcode != 'empty'
                            ? userState.user.postcode
                            : '',
                        preffixIcon: SvgPicture.asset(
                          'assets/icons/postcode.svg',
                          color: theme.darkGrey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _filteredTypeAnswer(
                        theme,
                        'Do you have a business?',
                        filteredAnswer,
                        () {
                          setState(() {
                            filteredAnswer = !filteredAnswer;
                          });
                        },
                      ),
                      if (filteredAnswer == true)
                        _visionAdditionalQuestion(countries, parcelState)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultButton(
                  widht: MediaQuery.of(context).size.width,
                  child: userState.status is LoadingUserStatus
                      ? SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        )
                      : null,
                  title: 'Save',
                  onTap: () {
                    if (!(userState.status is LoadingUserStatus)) {
                      final requestModel = _createRequest(countries, userState);
                      UserCubit.read(context).updateUser(requestModel);
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
        ],
      ),
    );
  }

  UpdateUserRequest _createRequest(
      List<Country> countries, UserState userState) {
    final UpdateUserRequest requestModel = UpdateUserRequest(
      email: userState.email,
      password: 'password',
      firstname: _nameController.text == ''
          ? userState.user.firstname
          : _nameController.text,
      lastname: _surNameController.text == ''
          ? userState.user.lastname
          : _surNameController.text,
      phone: _phoneNumberController.text == ''
          ? userState.user.phone
          : _phoneNumberController.text,
      county: selecteCountryFrom.name == ''
          ? userState.user.county
          : selecteCountryFrom.name,
      city: _cityController.text == ''
          ? userState.user.city
          : _cityController.text,
      addressLine1: _addressLine1Controller.text == ''
          ? userState.user.addressLine1
          : _addressLine1Controller.text,
      addressLine2: _addressLine2Controller.text == ''
          ? userState.user.addressLine2
          : _addressLine2Controller.text,
      postcode: _postCodeController.text == ''
          ? userState.user.postcode
          : _postCodeController.text,
      countryId: getIdFromCountry(countries, selecteCountryFrom.name) == -1
          ? int.parse(userState.user.countryId)
          : getIdFromCountry(countries, selecteCountryFrom.name),
    );

    return requestModel;
  }

  int getIdFromCountry(List<Country> countries, String name) {
    for (var country in countries) {
      if (country.name == name) {
        return int.parse(country.id);
      }
    }
    return -1;
  }

  Widget _visionAdditionalQuestion(
      List<Country> countries, ParcelsState parcelsState) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        DefaultTextField(
          controller: _countryController,
          title: 'Country',
          onChanged: () {},
          errorMessage: '',
          placeholder: '123456',
          preffixIcon: SvgPicture.asset(
            'assets/icons/country.svg',
            color: theme.darkGrey,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        DefaultTextField(
          controller: _phoneNumber1Controller,
          title: 'Phone number',
          onChanged: () {},
          errorMessage: '',
          placeholder: '+375',
          preffixIcon: SvgPicture.asset(
            'assets/icons/phone.svg',
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
          controller: _vatNumberController,
          title: 'VAT number',
          onChanged: () {},
          errorMessage: '',
          placeholder: 'Enter VAT number',
          preffixIcon: SvgPicture.asset(
            'assets/icons/doc.svg',
            color: theme.darkGrey,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        DefaultTextField(
          controller: _eoriNumberController,
          title: 'EORI number',
          onChanged: () {},
          errorMessage: '',
          placeholder: 'Enter EORI number',
          preffixIcon: SvgPicture.asset(
            'assets/icons/doc.svg',
            color: theme.darkGrey,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        DefaultTextField(
          controller: _iossNumberController,
          title: 'IOSS number',
          onChanged: () {},
          errorMessage: '',
          placeholder: 'Enter IOSS number',
          preffixIcon: SvgPicture.asset(
            'assets/icons/doc.svg',
            color: theme.darkGrey,
          ),
        ),
      ],
    );
  }

  Widget _filteredTypeAnswer(
      UIThemes theme, String title, bool isSelecte, Function onTap) {
    return InkWell(
      highlightColor: theme.white,
      focusColor: theme.white,
      splashColor: theme.white,
      overlayColor: MaterialStateProperty.all(theme.white),
      onTap: () {
        onTap.call();
      },
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelecte ? theme.primaryColor : theme.lightGrey,
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
          SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: theme.text14Regular,
          ),
        ],
      ),
    );
  }
}
