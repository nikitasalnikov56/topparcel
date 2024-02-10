import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/cubits/auth_cubit.dart';
import '../../helpers/utils/ui_themes.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/buttons/default_button.dart';
import '../../widgets/text_field/default_text_field.dart';
import 'changed_password.dart';

class EnterCodeView extends StatefulWidget {
  const EnterCodeView({super.key, required this.email});

  final String email;

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();

  static MaterialPage<dynamic> page(String email) {
    return MaterialPage(
      child: EnterCodeView(
        email: email,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/enter_code_page';
}

class _EnterCodeViewState extends State<EnterCodeView> {
  String errorMessageCode = '';

  bool isError = false;

  TextEditingController _codeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _validate() {
    setState(() {
      errorMessageCode = '';
      isError = false;

      if (_codeController.text.isEmpty) {
        errorMessageCode = 'Provided code is not valid';
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status is UpdatingPasswordStatus) {
          PageManager.read(context).push(
              ChangedPasswordView.page(widget.email, _codeController.text),
              rootNavigator: true);
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
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Forgot your password?',
                              style: theme.header24Bold,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 12),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        width: 68,
                                        height: 68,
                                        child: Icon(
                                          Icons.local_post_office_rounded,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'The code was sent to your email',
                                        style: theme.text16Medium,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        widget.email,
                                        style: theme.header16Bold,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )
                                ]),
                            const SizedBox(height: 24),
                            DefaultTextField(
                              controller: _codeController,
                              title: 'Enter code',
                              onChanged: () {
                                setState(() {});
                              },
                              errorMessage: errorMessageCode,
                              placeholder: '126886',
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      AuthCubit.read(context).sendCodeToEmail(
                                          widget.email,
                                          repeateSendCode: true);
                                    });
                                  },
                                  child: Text(
                                    'Request again',
                                    style: theme.text16Regular.copyWith(
                                        height: 19 / 16,
                                        color: theme.primaryColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
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
                          title: 'Next',
                          onTap: () {
                            _validate();
                            if (_codeController.text.isNotEmpty) {
                              AuthCubit.read(context).checkEnterCode(
                                  _codeController.text, widget.email);
                            }
                          },
                          status: _codeController.text.isNotEmpty
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
}
