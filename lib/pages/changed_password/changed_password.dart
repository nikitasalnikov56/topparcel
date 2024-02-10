import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topparcel/pages/login/login_page.dart';

import '../../data/models/requests/update_password_request.dart';
import '../../global/cubits/auth_cubit.dart';
import '../../helpers/utils/ui_themes.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/buttons/default_button.dart';
import '../../widgets/text_field/default_text_field.dart';

class ChangedPasswordView extends StatefulWidget {
  const ChangedPasswordView(
      {super.key, required this.email, required this.code});

  final String email;
  final String code;

  @override
  State<ChangedPasswordView> createState() => _ChangedPasswordViewState();

  static MaterialPage<dynamic> page(String email, String code) {
    return MaterialPage(
      child: ChangedPasswordView(
        email: email,
        code: code,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/changed_password_page';
}

class _ChangedPasswordViewState extends State<ChangedPasswordView> {
  TextEditingController _enterPassController = TextEditingController();
  TextEditingController _repeatPassController = TextEditingController();

  String errorMessageEnterPass = '';
  String errorMessageRepeatPass = '';

  bool _hidePassword = true;
  bool _hideRepeatPassword = true;

  bool isError = false;
  bool isVisible = false;

  void _checkField() {
    setState(() {
      if (_enterPassController.text.isNotEmpty &&
          _repeatPassController.text.isNotEmpty) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status is UpdatedPasswordStatus) {
          AuthCubit.read(context)
              .login(widget.email, _enterPassController.text);
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
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 56.0, 20.0, 26.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: GestureDetector(
                                onTap: () => PageManager.read(context)
                                    .pop(rootNavigator: true),
                                child: const Icon(Icons.arrow_back_ios),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'New password?',
                              style: theme.header24Bold,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 20),
                            DefaultTextField(
                              controller: _enterPassController,
                              obscureText: _hidePassword,
                              maxLines: 1,
                              title: 'Enter new password',
                              onChanged: () {
                                _checkField();
                              },
                              errorMessage: errorMessageEnterPass,
                              placeholder: 'Enter password',
                              preffixIcon: SvgPicture.asset(
                                'assets/icons/lock.svg',
                                color: theme.grey,
                              ),
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
                            SizedBox(
                              height: 12,
                            ),
                            DefaultTextField(
                              controller: _repeatPassController,
                              obscureText: _hideRepeatPassword,
                              maxLines: 1,
                              title: 'Repeat new password',
                              onChanged: () {
                                _checkField();
                              },
                              errorMessage: errorMessageRepeatPass,
                              placeholder: 'Repeat password',
                              preffixIcon: SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  color: theme.grey),
                              suffixIcon: IconButton(
                                icon: Icon(_hideRepeatPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _hideRepeatPassword = !_hideRepeatPassword;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: DefaultButton(
                          widht: MediaQuery.of(context).size.width - 40,
                          title: 'Save',
                          onTap: () {
                            _validate();
                            if (!isError) {
                              AuthCubit.read(context).updatePassword(
                                UpdatePasswordRequest(
                                  email: widget.email,
                                  password: widget.code,
                                  newPassword: _enterPassController.text,
                                ),
                                isLogin: true,
                              );
                            }
                          },
                          status: isVisible
                              ? ButtonStatus.primary
                              : ButtonStatus.disable,
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
    );
  }

  void _validate() {
    setState(() {
      errorMessageEnterPass = errorMessageRepeatPass = '';
      isError = false;

      if (_enterPassController.text.isEmpty ||
          _enterPassController.text.length < 7) {
        errorMessageEnterPass = 'Password is too short';
        isError = true;
      }
      if (_repeatPassController.text.isEmpty) {
        errorMessageRepeatPass = 'Repeate password is too short';
        isError = true;
      } else if (_repeatPassController.text != _enterPassController.text) {
        errorMessageRepeatPass = 'Passwords don’t match. Try again';
        isError = true;
      }
    });
  }
}
