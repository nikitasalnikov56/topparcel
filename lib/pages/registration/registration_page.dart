import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/requests/registration_request.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/app/app_page.dart';
import 'package:topparcel/pages/login/login_page.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/cubits/parcels_cubit.dart';
import '../../widgets/text_field/default_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: RegistrationPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/registration_page';
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isNameError = false;
  bool isSurnameError = false;
  bool isEmailError = false;
  bool isPasswordError = false;
  bool isConfirmPaswordError = false;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  String errorMessageName = '';
  String errorMessageSurname = '';
  String errorMessageEmail = '';
  String errorMessagePassword = '';
  String errorMessageConfirmPassword = '';

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  bool _isVisible = false;
  bool _checkBox = false;
  bool _isError = false;

  double height = 175.0;

  String _validLetters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";

  void _checkField() {
    setState(() {
      if (_nameController.text != '' &&
          _surnameController.text != '' &&
          _emailController.text != '' &&
          _passwordController.text != '' &&
          _confirmPasswordController.text != '' &&
          _checkBox) {
        _isVisible = true;
      } else {
        _isVisible = false;
      }
    });
  }

  void _validation() {
    setState(() {
      errorMessageName = errorMessageSurname = errorMessageEmail =
          errorMessagePassword = errorMessageConfirmPassword = '';
      _isError = false;

      if (_nameController.text.isEmpty) {
        errorMessageName = 'Name must contain only latin symbols';
        _isError = true;
      } else {
        for (var i = 0; i < _nameController.text.length; i++) {
          if (!_validLetters.contains(_nameController.text[i])) {
            errorMessageName = 'Name must contain only latin symbols';
            _isError = true;
          }
        }
      }
      if (_surnameController.text.isEmpty) {
        errorMessageSurname = 'Surname must contain only latin symbols';
        _isError = true;
      } else {
        for (var i = 0; i < _surnameController.text.length; i++) {
          if (!_validLetters.contains(_surnameController.text[i])) {
            errorMessageSurname = 'Surname must contain only latin symbols';
            _isError = true;
          }
        }
      }

      if (!EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Email address is not valid';
        _isError = true;
      }

      if (_passwordController.text.length < 7) {
        errorMessagePassword = 'Password is too short';
        _isError = true;
      }

      if (_confirmPasswordController.text.length < 7) {
        errorMessageConfirmPassword = 'Password is too short';
        _isError = true;
      } else if (_passwordController.text != _confirmPasswordController.text) {
        errorMessageConfirmPassword = 'Passwords don’t match. Try again';
        _isError = true;
      }

      if (!_checkBox) {
        _isError = true;
      }
    });
  }

  _launchPrivacy() async {
    Uri _url = Uri.parse('https://topparcel.com/privacy-policy');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchTerms() async {
    Uri _url = Uri.parse('https://topparcel.com/terms-and-conditions');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status is AuthorisedStatus) {
          ParcelsCubit.read(context).init();
          TrackParcelCubit.read(context).init();

          UserCubit.read(context).init();
          PageManager.read(context)
              .clearStackAndPushPage(AppPage.page(), rootNavigator: true);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              20.0,
              70.0,
              20.0,
              26.0,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Text(
                              'Registration',
                              style: theme.header24Bold,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: _nameController,
                            title: 'Name*',
                            onChanged: () {
                              _checkField();
                            },
                            errorMessage: errorMessageName,
                            placeholder: 'Enter given name',
                            preffixIcon:
                                SvgPicture.asset('assets/icons/person.svg'),
                            // preffixIcon: Icons.person,
                          ),
                          const SizedBox(height: 12),
                          DefaultTextField(
                            controller: _surnameController,
                            title: 'Surname*',
                            onChanged: () {
                              _checkField();
                            },
                            errorMessage: errorMessageSurname,
                            placeholder: 'Enter family name',
                            preffixIcon:
                                SvgPicture.asset('assets/icons/person.svg'),
                          ),
                          const SizedBox(height: 12),
                          DefaultTextField(
                            controller: _emailController,
                            title: 'Email*',
                            onChanged: () {
                              _checkField();
                            },
                            errorMessage: errorMessageEmail,
                            placeholder: 'name@email.com',
                            preffixIcon:
                                SvgPicture.asset('assets/icons/email.svg'),
                          ),
                          const SizedBox(height: 12),
                          DefaultTextField(
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            title: 'Password*',
                            onChanged: () {
                              _checkField();
                            },
                            errorMessage: errorMessagePassword,
                            placeholder: 'Enter password',
                            preffixIcon:
                                SvgPicture.asset('assets/icons/lock.svg'),
                            suffixIcon: IconButton(
                              icon: Icon(_hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          DefaultTextField(
                            controller: _confirmPasswordController,
                            obscureText: _hideConfirmPassword,
                            title: 'Repeat password*',
                            onChanged: () {
                              _checkField();
                            },
                            errorMessage: errorMessageConfirmPassword,
                            placeholder: 'Repeat password',
                            preffixIcon:
                                SvgPicture.asset('assets/icons/lock.svg'),
                            suffixIcon: IconButton(
                              icon: Icon(_hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _hideConfirmPassword = !_hideConfirmPassword;
                                });
                              },
                            ),
                            isRepeatePassword: _passwordController.text ==
                                    _confirmPasswordController.text &&
                                _confirmPasswordController.text.isNotEmpty,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _checkBox,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkBox = !_checkBox;
                                      _checkField();
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  activeColor: Color(0xffea560d),
                                ),
                              ),
                              SizedBox(width: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree with the ',
                                    style: theme.text14Regular
                                        .copyWith(color: theme.black),
                                    children: [
                                      TextSpan(
                                        text: 'Privacy Policy ',
                                        style: theme.text14Regular.copyWith(
                                          color: theme.primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchPrivacy,
                                      ),
                                      TextSpan(
                                        text: 'and ',
                                        style: theme.text14Regular
                                            .copyWith(color: theme.black),
                                      ),
                                      TextSpan(
                                        text: 'Terms of Use',
                                        style: theme.text14Regular.copyWith(
                                          color: theme.primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchTerms,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DefaultButton(
                    widht: MediaQuery.of(context).size.width - 40,
                    title: 'Sign up',
                    onTap: () {
                      _validation();
                      if (!_isError) {
                        final requestModel = RegistrationRequest(
                          email: _emailController.text,
                          password: _passwordController.text,
                          firstName: _nameController.text,
                          lastName: _surnameController.text,
                          phoneNumber: '+0',
                          countryId: 5,
                          addressLine1: 'empty',
                          addressLine2: '',
                          city: 'empty',
                          country: 'empty',
                          postcode: 'empty',
                          sms: 0,
                          subscribe: 1,
                          tine: 'empty',
                        );
                        AuthCubit.read(context).registration(requestModel);
                      }
                    },
                    status: _isVisible
                        ? ButtonStatus.primary
                        : ButtonStatus.disable,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 35),
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff919eab),
                            height: 24 / 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 9),
                        GestureDetector(
                          onTap: () => PageManager.read(context)
                              .clearStackAndPushPage(LoginPage.page(),
                                  rootNavigator: true),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffea560d),
                              height: 24 / 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
