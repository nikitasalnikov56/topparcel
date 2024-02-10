import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/changed_password/enter_code_view.dart';

import '../../global/cubits/auth_cubit.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/buttons/default_button.dart';
import '../../widgets/text_field/default_text_field.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: RecoverPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/recover_page';
}

class _RecoverPageState extends State<RecoverPage> {
  String errorMessageEmail = '';

  bool isError = false;

  TextEditingController _emailController = new TextEditingController();

  void _validate() {
    setState(() {
      errorMessageEmail = '';
      isError = false;

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Email address wasn"t found';
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status is EnterCodeChangedPasswordStatus) {
          PageManager.read(context)
              .push(EnterCodeView.page(_emailController.text));
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
                            Text(
                              'Enter your email address that is linked to your account. We"ll send you a code to recover your password.',
                              style: theme.text16Regular,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 24),
                            DefaultTextField(
                              controller: _emailController,
                              title: 'Email*',
                              onChanged: () {
                                setState(() {});
                              },
                              errorMessage: errorMessageEmail,
                              placeholder: 'name@email.com',
                              preffixIcon:
                                  SvgPicture.asset('assets/icons/email.svg'),
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
                            if (_emailController.text.isNotEmpty) {
                              AuthCubit.read(context)
                                  .sendCodeToEmail(_emailController.text);
                            }
                          },
                          status: _emailController.text.isNotEmpty
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
