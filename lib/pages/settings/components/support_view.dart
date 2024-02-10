import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/success/success_page.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:topparcel/widgets/text_field/default_text_field.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/text_field/support_message_text_field.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: SupportView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/support_view';
}

class _SupportViewState extends State<SupportView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageTextController = TextEditingController();

  String errorMessageEmail = '';
  String errorMessageText = '';

  bool isError = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'Support',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              DefaultTextField(
                controller: _emailController,
                title: 'Email*',
                onChanged: () {
                  _checkEmpty();
                },
                errorMessage: errorMessageEmail,
                placeholder: 'name@gmail.com',
                preffixIcon: SvgPicture.asset(
                  'assets/icons/email.svg',
                  color:
                      errorMessageEmail.isEmpty ? theme.grey : theme.errorColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SupportMessageTextField(
                  controller: _messageTextController,
                  title: 'Message text',
                  onChanged: () {
                    _checkEmpty();
                    if (_messageTextController.text.length > 2000) {
                      errorMessageText = 'Long';
                      isError = true;
                    }
                  },
                  errorMessage: errorMessageText,
                  placeholder: 'Enter message text',
                  height: 184,
                  maxLines: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: DefaultButton(
                  widht: MediaQuery.of(context).size.width,
                  title: 'Send',
                  onTap: () async {
                    _validation();
                    if (!isError) {
                      try {
                        final Email email = Email(
                          body: _messageTextController.text,
                          subject: 'Support ${_emailController.text}',
                          recipients: ['support@topparcel.com'],
                          isHTML: false,
                        );

                        await FlutterEmailSender.send(email);

                        PageManager.read(context).push(
                            SuccessPage.page(
                              'Your request was successfully sent!',
                              '',
                              'Back',
                              () {
                                PageManager.read(context)
                                    .pop(rootNavigator: true);
                              },
                            ),
                            rootNavigator: true);
                      } catch (e) {}
                    }
                  },
                  status:
                      isVisible ? ButtonStatus.primary : ButtonStatus.disable,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkEmpty() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _messageTextController.text.isNotEmpty) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  void _validation() {
    setState(() {
      errorMessageEmail = errorMessageText = '';
      isError = false;

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Enter email';
        isError = true;
      } else if (!EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Invalid email format';
        isError = true;
      }
      if (_messageTextController.text.isEmpty) {
        errorMessageText = 'Enter message text';
        isError = true;
      }
    });
  }
}
