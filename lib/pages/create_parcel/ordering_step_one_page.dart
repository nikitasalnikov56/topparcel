import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topparcel/data/models/app_model/ordering_step_one_model.dart';
import 'package:topparcel/data/models/response/fetch_addresses_response.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/country_to_id.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/text_field/default_text_field.dart';

import '../../helpers/utils/date_utils.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/buttons/default_button.dart';
import 'ordering_step_two_page.dart';

enum TypeActionAddress { add, selecte }

class OrderingStepOnePage extends StatefulWidget {
  const OrderingStepOnePage({
    super.key,
    required this.pickupDate,
  });

  final DateTime pickupDate;

  @override
  State<OrderingStepOnePage> createState() => _OrderingStepOnePageState();

  static MaterialPage<dynamic> page(DateTime pickupDate) {
    return MaterialPage(
      child: OrderingStepOnePage(
        pickupDate: pickupDate,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/ordering_step_one_page';
}

class _OrderingStepOnePageState extends State<OrderingStepOnePage> {
  TextEditingController fullNameSenderController = TextEditingController();
  TextEditingController emailSenderController = TextEditingController();
  TextEditingController phoneNumberSenderController = TextEditingController();
  TextEditingController countrySenderController = TextEditingController();
  TextEditingController citySenderController = TextEditingController();
  TextEditingController addressLine1SenderController = TextEditingController();
  TextEditingController postcodeSenderController = TextEditingController();
  TextEditingController? additionalAddressLineSenderController;

  TextEditingController fullNameReciptientController = TextEditingController();
  TextEditingController emailReciptientController = TextEditingController();
  TextEditingController phoneNumberReciptientController =
      TextEditingController();
  TextEditingController countryReciptientController = TextEditingController();
  TextEditingController cityReciptientController = TextEditingController();
  TextEditingController addressLine1ReciptientController =
      TextEditingController();
  TextEditingController postcodeReciptientController = TextEditingController();
  TextEditingController? additionalAddressLineReciptientController;

  bool isVisibleSender = false;
  bool isVisibleReciptient = false;

  bool isError = false;

  bool validated = false;

  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);

    final theme = UIThemes();
    return BlocListener<ParcelsCubit, ParcelsState>(
      listener: (context, state) {
        if (state.status is OrderingStepTwoStatus) {
          PageManager.read(context)
              .push(OrderingStepTwoPage.page(), rootNavigator: true);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(title: 'Ordering'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Step 1',
                    style: theme.text14Regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                _sartDateWidget(theme),
                SizedBox(
                  height: 16,
                ),
                _AddressWidget(
                  title: 'Sender details',
                  fullNameController: fullNameSenderController,
                  emailController: emailSenderController,
                  phoneNumberController: phoneNumberSenderController,
                  countryController: countrySenderController,
                  cityController: citySenderController,
                  addressLine1Controller: addressLine1SenderController,
                  postcodeController: postcodeSenderController,
                  selectAddress: userState.addressList,
                  additionalAddressLineController:
                      additionalAddressLineSenderController,
                  addAdditionalAddress: () {
                    setState(() {
                      additionalAddressLineSenderController =
                          TextEditingController();
                    });
                  },
                  isVisible: (value) {
                    setState(() {
                      isVisibleSender = value;
                    });
                  },
                  isError: (value) {
                    setState(() {
                      isError = value;
                    });
                  },
                  isSelectedAddress: (value) {
                    setState(() {
                      fullNameSenderController.text = value.firstname;
                      emailSenderController.text = value.email;
                      phoneNumberSenderController.text = value.phone;
                      countrySenderController.text = value.countryId;
                      citySenderController.text = value.city;
                      addressLine1SenderController.text = value.addressLine1;
                      postcodeSenderController.text = value.zipcode;
                      additionalAddressLineSenderController =
                          TextEditingController(text: value.addressLine2);
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                _AddressWidget(
                  title: 'Recipient address',
                  fullNameController: fullNameReciptientController,
                  emailController: emailReciptientController,
                  phoneNumberController: phoneNumberReciptientController,
                  countryController: countryReciptientController,
                  cityController: cityReciptientController,
                  addressLine1Controller: addressLine1ReciptientController,
                  postcodeController: postcodeReciptientController,
                  selectAddress: userState.addressList,
                  additionalAddressLineController:
                      additionalAddressLineReciptientController,
                  addAdditionalAddress: () {
                    setState(() {
                      additionalAddressLineReciptientController =
                          TextEditingController();
                    });
                  },
                  isVisible: (value) {
                    setState(() {
                      isVisibleReciptient = value;
                    });
                  },
                  isError: (value) {
                    setState(() {
                      isError = value;
                    });
                  },
                  isSelectedAddress: (value) {
                    setState(() {
                      fullNameReciptientController.text = value.firstname;
                      emailReciptientController.text = value.email;
                      phoneNumberReciptientController.text = value.phone;
                      countryReciptientController.text = value.countryId;
                      cityReciptientController.text = value.city;
                      addressLine1ReciptientController.text =
                          value.addressLine1;
                      postcodeReciptientController.text = value.zipcode;
                      additionalAddressLineReciptientController =
                          TextEditingController(text: value.addressLine2);
                    });
                  },
                ),
                DefaultButton(
                  widht: MediaQuery.of(context).size.width - 40,
                  title: 'Next step',
                  onTap: () {
                    _validation();
                    if (!isError) {
                      final orderingStepOneModel = OrderingStepOneModel(
                        createdDate: widget.pickupDate,
                        fullNameFrom: fullNameSenderController.text,
                        emailFrom: emailSenderController.text,
                        phoneNumberFrom: phoneNumberSenderController.text,
                        countryFrom: countrySenderController.text,
                        cityFrom: citySenderController.text,
                        addressline1From: addressLine1SenderController.text,
                        addressline2From:
                            (additionalAddressLineSenderController ??
                                    TextEditingController())
                                .text,
                        postcodeFrom: postcodeSenderController.text,
                        fullNameTo: fullNameReciptientController.text,
                        emailTo: emailReciptientController.text,
                        phoneNumberTo: phoneNumberReciptientController.text,
                        countryTo: countryReciptientController.text,
                        cityTo: cityReciptientController.text,
                        addressline1To: addressLine1ReciptientController.text,
                        addressline2To:
                            (additionalAddressLineReciptientController ??
                                    TextEditingController())
                                .text,
                        postcodeTo: postcodeReciptientController.text,
                      );
                      ParcelsCubit.read(context)
                          .doneStepOneOrdering(orderingStepOneModel);
                    }
                  },
                  status: isVisibleSender && isVisibleReciptient
                      ? ButtonStatus.primary
                      : ButtonStatus.disable,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validation() {
    setState(() {
      if (fullNameSenderController.text.isEmpty &&
          emailSenderController.text.isEmpty &&
          phoneNumberSenderController.text.isEmpty &&
          countrySenderController.text.isEmpty &&
          citySenderController.text.isEmpty &&
          addressLine1SenderController.text.isEmpty &&
          postcodeSenderController.text.isEmpty &&
          fullNameReciptientController.text.isEmpty &&
          emailReciptientController.text.isEmpty &&
          phoneNumberReciptientController.text.isEmpty &&
          countryReciptientController.text.isEmpty &&
          cityReciptientController.text.isEmpty &&
          addressLine1ReciptientController.text.isEmpty &&
          postcodeReciptientController.text.isEmpty) {
        isError = true;
      } else {
        isError = false;
      }
    });
  }

  Widget _sartDateWidget(UIThemes theme) {
    return Container(
      color: theme.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Collection date',
              style: theme.header14Semibold,
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 44,
              decoration: BoxDecoration(
                  color: theme.backgroundPrimary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.grey,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        color: theme.darkGrey,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      CustomDateUtils().dateForFiltere(widget.pickupDate),
                      style: theme.text14Regular,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressWidget extends StatefulWidget {
  const _AddressWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.countryController,
    required this.cityController,
    required this.addressLine1Controller,
    required this.postcodeController,
    this.additionalAddressLineController,
    required this.title,
    required this.addAdditionalAddress,
    required this.isVisible,
    required this.isError,
    required this.selectAddress,
    required this.isSelectedAddress,
  });

  final String title;

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController addressLine1Controller;
  final TextEditingController postcodeController;
  final TextEditingController? additionalAddressLineController;
  final List<UserAddress> selectAddress;
  final Function(bool) isVisible;
  final Function(bool) isError;
  final Function(UserAddress) isSelectedAddress;

  final Function addAdditionalAddress;

  @override
  State<_AddressWidget> createState() => __AddressWidgetState();
}

class __AddressWidgetState extends State<_AddressWidget> {
  TypeActionAddress typeActionAddress = TypeActionAddress.add;

  TextEditingController _searchController = TextEditingController();

  String errorMessageFullname = '';
  String errorMessageEmail = '';
  String errorMessagePhoneNumber = '';
  String errorMessageCountry = '';
  String errorMessageCity = '';
  String errorMessageAddessLine1 = '';
  String errorMessagePostcode = '';

  String errorMessageSearch = '';

  void _checkEmptyField() {
    if ((widget.fullNameController.text.isEmpty ||
            widget.emailController.text.isEmpty ||
            widget.phoneNumberController.text.isEmpty ||
            widget.countryController.text.isEmpty ||
            widget.cityController.text.isEmpty ||
            widget.addressLine1Controller.text.isEmpty ||
            widget.postcodeController.text.isEmpty) &&
        typeActionAddress == TypeActionAddress.add) {
      widget.isVisible.call(false);
    }
    // else if (typeActionAddress == TypeActionAddress.selecte) {
    //   widget.isVisible.call(false);
    // }
    else {
      widget.isVisible.call(true);
    }
    _validation();
  }

  void _validation() {
    setState(
      () {
        errorMessageAddessLine1 = errorMessageCity = errorMessageCountry =
            errorMessageEmail = errorMessageFullname = errorMessagePhoneNumber =
                errorMessagePostcode = errorMessageSearch = '';
        widget.isError.call(false);

        if (widget.fullNameController.text.isEmpty) {
          errorMessageFullname = 'Enter full name';
          widget.isError.call(true);
        }
        if (widget.emailController.text.isEmpty) {
          errorMessageEmail = 'Enter email';
          widget.isError.call(true);
        }
        if (widget.phoneNumberController.text.isEmpty) {
          errorMessagePhoneNumber = 'Enter phone number';
          widget.isError.call(true);
        }
        if (widget.countryController.text.isEmpty) {
          errorMessageCountry = 'Enter country';
          widget.isError.call(true);
        }
        if (widget.cityController.text.isEmpty) {
          errorMessageCity = 'Enter city';
          widget.isError.call(true);
        }
        if (widget.addressLine1Controller.text.isEmpty) {
          errorMessageAddessLine1 = 'Enter address line';
          widget.isError.call(true);
        }
        if (widget.postcodeController.text.isEmpty) {
          errorMessagePostcode = 'Enter postcode';
          widget.isError.call(true);
        }
      },
    );
  }

  bool isSelected = false;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final countries = ParcelsCubit.watchState(context).countriesList;
    final theme = UIThemes();
    return Container(
      color: theme.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: theme.header14Semibold,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DefaultButton(
                    widht: (MediaQuery.of(context).size.width - 47) / 2,
                    title: 'Add address',
                    onTap: () {
                      setState(() {
                        typeActionAddress = TypeActionAddress.add;
                      });
                    },
                    status: typeActionAddress == TypeActionAddress.add
                        ? ButtonStatus.primary
                        : ButtonStatus.disable,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  DefaultButton(
                    widht: (MediaQuery.of(context).size.width - 47) / 2,
                    title: 'Select address',
                    onTap: () {
                      setState(() {
                        typeActionAddress = TypeActionAddress.selecte;
                      });
                    },
                    status: typeActionAddress == TypeActionAddress.selecte
                        ? ButtonStatus.primary
                        : ButtonStatus.disable,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (typeActionAddress == TypeActionAddress.add) ...[
                DefaultTextField(
                  controller: widget.fullNameController,
                  title: 'Full name*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessageFullname,
                  placeholder: 'Enter full name',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/person.svg',
                    color: theme.darkGrey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DefaultTextField(
                  controller: widget.emailController,
                  title: 'Email*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessageEmail,
                  placeholder: 'name@email.com',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/email.svg',
                    color: theme.darkGrey,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 12,
                ),
                DefaultTextField(
                  controller: widget.phoneNumberController,
                  title: 'Phone number*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessagePhoneNumber,
                  placeholder: '+375',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/phone.svg',
                    color: theme.darkGrey,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width - 40,
                  color: theme.extraLightGrey,
                ),
                SizedBox(
                  height: 12,
                ),
                DefaultTextField(
                  controller: widget.countryController,
                  title: 'Country*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessageCountry,
                  placeholder: 'Enter country',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/country.svg',
                    color: theme.darkGrey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DefaultTextField(
                  controller: widget.cityController,
                  title: 'City*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessageCity,
                  placeholder: 'Enter city',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/city.svg',
                    color: theme.darkGrey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DefaultTextField(
                  controller: widget.addressLine1Controller,
                  title: 'Address line 1*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessageAddessLine1,
                  placeholder: 'Enter street',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/address.svg',
                    color: theme.darkGrey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.additionalAddressLineController != null) ...[
                  Column(
                    children: [
                      DefaultTextField(
                        controller: widget.additionalAddressLineController!,
                        title: 'Address line 2',
                        onChanged: () {},
                        errorMessage: '',
                        placeholder: 'Enter street',
                        preffixIcon: SvgPicture.asset(
                          'assets/icons/address.svg',
                          color: theme.darkGrey,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
                if (widget.additionalAddressLineController == null) ...[
                  InkWell(
                    onTap: () {
                      widget.addAdditionalAddress.call();
                    },
                    child: Text(
                      'Add address line +',
                      style: theme.header14Semibold
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
                DefaultTextField(
                  controller: widget.postcodeController,
                  title: 'Postcode*',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: errorMessagePostcode,
                  placeholder: 'Enter postcode',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/postcode.svg',
                    color: theme.darkGrey,
                  ),
                ),
              ] else ...[
                DefaultTextField(
                  controller: _searchController,
                  title: '',
                  onChanged: () {
                    _checkEmptyField();
                  },
                  errorMessage: '',
                  placeholder: 'Search...',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: theme.darkGrey,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.selectAddress.length,
                  itemBuilder: (context, index) {
                    final country = getCountryFromId(
                        widget.selectAddress[index].countryId, countries);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.isSelectedAddress.call(
                          widget.selectAddress[index],
                        );
                        _checkEmptyField();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: theme.black,
                            border: selectedIndex == index
                                ? Border.all(color: theme.orangeColor, width: 3)
                                : null,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.selectAddress[index].firstname} ${widget.selectAddress[index].lastname}',
                                      style: theme.header14Semibold.copyWith(
                                        color: theme.white,
                                      ),
                                    ),
                                    Text(
                                      '${country.name}, ${widget.selectAddress[index].city}, ${widget.selectAddress[index].addressLine1},  ${widget.selectAddress[index].zipcode}',
                                      style: theme.text14Regular.copyWith(
                                        color: Color(0xFFFFFBF9),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.topCenter,
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/edit_address.svg',
                                  color: theme.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
