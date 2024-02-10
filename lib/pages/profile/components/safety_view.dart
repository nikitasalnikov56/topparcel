import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/requests/update_password_request.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';

import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/buttons/default_button.dart';
import '../../../../widgets/text_field/default_text_field.dart';

class SafetyView extends StatefulWidget {
  const SafetyView({super.key});

  @override
  State<SafetyView> createState() => _SafetyViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: SafetyView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/safety_view';
}

class _SafetyViewState extends State<SafetyView> {
  TextEditingController _enterPassController = TextEditingController();
  TextEditingController _repeatPassController = TextEditingController();
  String errorMessageEnterPass = '';
  String errorMessageRepeatPass = '';
  bool isError = false;

  bool _hidePassword = true;
  bool _hideRepeatPassword = true;

  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);
    final authState = AuthCubit.watchState(context);
    final theme = UIThemes();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Safety',
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status is UpdatedPasswordStatus) {
            AppMessageCubit.read(context)
                .showInformationMessage('Password updated successfully');
            AuthCubit.read(context)
                .login(userState.email, _enterPassController.text);
            PageManager.read(context).pop(rootNavigator: true);
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Change password',
                      style: theme.header16Bold,
                    ),
                  ),
                  DefaultTextField(
                    controller: _enterPassController,
                    obscureText: _hidePassword,
                    maxLines: 1,
                    title: 'Enter new password',
                    onChanged: () {},
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
                    onChanged: () {},
                    errorMessage: errorMessageRepeatPass,
                    placeholder: 'Repeat password',
                    preffixIcon: SvgPicture.asset('assets/icons/lock.svg',
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
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 20),
                    child: DefaultButton(
                        widht: MediaQuery.of(context).size.width,
                        title: 'Save',
                        onTap: () {
                          _validation();
                          if (!isError) {
                            AuthCubit.read(context).updatePassword(
                              UpdatePasswordRequest(
                                  email: userState.email,
                                  password: 'pass',
                                  newPassword: _enterPassController.text),
                            );
                          }
                        },
                        status: ButtonStatus
                            .primary //isVisible ? ButtonStatus.primary : ButtonStatus.disable,
                        ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: (authState.status is UpdatedPasswordStatus ||
                      authState.status is UpdatingPasswordStatus)
                  ? 1.0
                  : 0.0,
              duration: Duration(milliseconds: 300),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validation() {
    setState(() {
      errorMessageEnterPass = errorMessageRepeatPass = '';
      isError = false;

      if (_enterPassController.text.isEmpty) {
        errorMessageEnterPass = 'Enter password';
        isError = true;
      }
      if (_repeatPassController.text.isEmpty) {
        errorMessageRepeatPass = 'Repeat password';
        isError = true;
      }

      if (_enterPassController.text != _repeatPassController.text) {
        errorMessageEnterPass =
            errorMessageRepeatPass = 'Passwords don\'t match';
        isError = true;
      }
    });
  }
}
