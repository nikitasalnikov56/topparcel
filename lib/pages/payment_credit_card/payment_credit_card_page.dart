import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:topparcel/widgets/text_field/default_text_field.dart';

class PaymentCreditCardPage extends StatefulWidget {
  const PaymentCreditCardPage({
    super.key,
    required this.backButtonCallback,
    required this.payCallback,
  });

  final Function payCallback;
  final Function backButtonCallback;

  @override
  State<PaymentCreditCardPage> createState() => _PaymentCreditCardPageState();

  static MaterialPage<dynamic> page(
      Function backButtonCallback, Function payCallback) {
    return MaterialPage(
      child: PaymentCreditCardPage(
        backButtonCallback: backButtonCallback,
        payCallback: payCallback,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/payment_credit_card_page';
}

class _PaymentCreditCardPageState extends State<PaymentCreditCardPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardDateController = TextEditingController();
  TextEditingController _cardCVCController = TextEditingController();
  TextEditingController _nameOnCardController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  String errorMessageEmail = '';
  String errorMessageCardNumber = '';
  String errorMessageCardDate = '';
  String errorMessageCardCVC = '';
  String errorMessageNameOnCard = '';
  String errorMessageCountry = '';

  bool hideCVC = true;
  bool isError = false;
  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(title: 'Pay with card'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, right: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DefaultTextField(
                      controller: _emailController,
                      title: 'Email',
                      onChanged: () {},
                      errorMessage: errorMessageEmail,
                      placeholder: '7-8@tut.by',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DefaultTextField(
                      controller: _cardNumberController,
                      title: 'Card information',
                      onChanged: () {},
                      errorMessage: errorMessageCardNumber,
                      placeholder: '1234 1234 1234 1234',
                      keyboardType: TextInputType.number,
                      formaters: [
                        MaskTextInputFormatter(
                            mask: '#### #### #### ####',
                            filter: {"#": RegExp(r'[0-9]')})
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 47) / 2,
                          child: DefaultTextField(
                            controller: _cardDateController,
                            title: 'MM/YY',
                            onChanged: () {},
                            errorMessage: errorMessageCardDate,
                            placeholder: 'MM/YY',
                            keyboardType: TextInputType.number,
                            formaters: [
                              MaskTextInputFormatter(
                                  mask: '##/##',
                                  filter: {"#": RegExp(r'[0-9]')})
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: DefaultTextField(
                            controller: _cardCVCController,
                            title: 'CVC',
                            onChanged: () {},
                            errorMessage: errorMessageCardCVC,
                            placeholder: 'CVC',
                            suffixIcon: IconButton(
                              icon: Icon(hideCVC
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  hideCVC = !hideCVC;
                                });
                              },
                            ),
                            formaters: [LengthLimitingTextInputFormatter(3)],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DefaultTextField(
                      controller: _nameOnCardController,
                      title: 'Name on card',
                      onChanged: () {},
                      errorMessage: errorMessageNameOnCard,
                      placeholder: 'Name on card',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DefaultTextField(
                      controller: _countryController,
                      title: 'Country or region',
                      onChanged: () {},
                      errorMessage: errorMessageCountry,
                      placeholder: 'Country or region',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: theme.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            children: [
                              Text(
                                'Securely save my information for 1-click checkout',
                                style: theme.text12Semibold,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Enter your phone number to create a Link account and pay faster on Topparcel Ltd and everywhere Link is accepted.',
                                style:
                                    theme.text12Regular.copyWith(height: 1.8),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child: Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width - 80,
                                  color: theme.extraLightGrey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/flags/balarus_flag.svg'),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        '8 029 491-19-11',
                                        style: theme.text12Regular,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: theme.lightGrey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 2),
                                      child: Text(
                                        'Optional',
                                        style: theme.text12Regular,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'More info',
                      style: theme.text14Regular
                          .copyWith(color: theme.primaryColor),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DefaultButton(
                widht: MediaQuery.of(context).size.width - 40,
                title: 'Pay',
                onTap: () {
                  _validate();
                  if (!isError) widget.payCallback.call();
                },
                status: ButtonStatus.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkField() {
    setState(() {
      if (_emailController.text.isEmpty ||
          _cardNumberController.text.isEmpty ||
          _cardDateController.text.isEmpty ||
          _cardCVCController.text.isEmpty ||
          _nameOnCardController.text.isEmpty ||
          _countryController.text.isEmpty) {
        isValidate = false;
      } else {
        isValidate = true;
      }
    });
  }

  void _validate() {
    setState(() {
      errorMessageEmail = errorMessageCardNumber = errorMessageCardDate =
          errorMessageCardCVC = errorMessageCardDate = errorMessageCountry = '';
      isError = false;

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Enter email';
        isError = true;
      } else if (!EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Email address is not valid';
        isError = true;
      }
      if (_cardNumberController.text.isEmpty) {
        errorMessageCardNumber = 'Enter card number';
        isError = true;
      } else if (_cardCVCController.text.length < 16) {
        errorMessageCardNumber = 'Number card is too short';
        isError = true;
      }
      if (_cardDateController.text.isEmpty) {
        errorMessageCardDate = 'Enter card date';
        isError = true;
      }
      if (_cardCVCController.text.isEmpty) {
        errorMessageCardCVC = 'Enter CVC';
        isError = true;
      } else if (_cardCVCController.text.length < 3) {
        errorMessageCardNumber = 'CVC is too short';
        isError = true;
      }
      if (_nameOnCardController.text.isEmpty) {
        errorMessageNameOnCard = 'Enter name on card';
        isError = true;
      }
      if (_countryController.text.isEmpty) {
        errorMessageCountry = 'Enter country or region';
        isError = true;
      }
    });
  }
}
