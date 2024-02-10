import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/changed_password/recover_page.dart';
import 'package:topparcel/pages/registration/registration_page.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';

import '../../global/cubits/parcels_cubit.dart';
import '../../widgets/text_field/default_text_field.dart';
import '../app/app_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: LoginPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/login_page';
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorMessageEmail = '';
  String errorMessagePassword = '';

  bool _hidePassword = true;

  bool isError = false;
  bool isVisible = false;

  void _checkField() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  void _validate() {
    setState(() {
      errorMessageEmail = errorMessagePassword = '';
      isError = false;

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Email address wasn"t found';
        isError = true;
      }

      if (_passwordController.text.isEmpty) {
        errorMessagePassword = 'Wrong password. Try again';
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIphoneSe = MediaQuery.of(context).size.height == 667;
    final screenHeight = MediaQuery.of(context).size.height;
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                            child: Container(
                                color: theme.primaryColor,
                                child: const SizedBox(
                                  width: 118,
                                  height: 60,
                                  child: Image(
                                    image: AssetImage('assets/images/logo.png'),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 26.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            // height: isIphoneSe
                            //     ? screenHeight - 300
                            //     : screenHeight - 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontFamily: "SF Pro",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff172027),
                                    height: 29 / 24,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                DefaultTextField(
                                  controller: _emailController,
                                  title: 'Email',
                                  onChanged: () {
                                    _checkField();
                                  },
                                  errorMessage: errorMessageEmail,
                                  placeholder: 'name@email.com',
                                  preffixIcon: SvgPicture.asset(
                                      'assets/icons/email.svg'),
                                ),
                                const SizedBox(height: 12),
                                DefaultTextField(
                                  controller: _passwordController,
                                  obscureText: _hidePassword,
                                  title: 'Password',
                                  onChanged: () {
                                    _checkField();
                                  },
                                  maxLines: 1,
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
                                const SizedBox(height: 16),
                                SizedBox(
                                  child: GestureDetector(
                                    onTap: () => PageManager.read(context).push(
                                        RecoverPage.page(),
                                        rootNavigator: true),
                                    child: const Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffea560d),
                                        height: 24 / 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DefaultButton(
                    widht: MediaQuery.of(context).size.width - 40,
                    title: 'Log in',
                    onTap: () {
                      _validate();
                      if (!isError) {
                        AuthCubit.read(context).login(
                            _emailController.text, _passwordController.text);
                      }
                    },
                    status:
                        isVisible ? ButtonStatus.primary : ButtonStatus.disable,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
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
                              .clearStackAndPushPage(RegistrationPage.page(),
                                  rootNavigator: true),
                          child: const Text(
                            "Sign up",
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
                  ),
                  SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
