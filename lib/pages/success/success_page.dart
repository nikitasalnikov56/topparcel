import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage(
      {super.key,
      required this.title,
      required this.description,
      required this.nameButton,
      required this.callbackButton});

  final String title;
  final String description;
  final String nameButton;
  final Function callbackButton;

  @override
  State<SuccessPage> createState() => _PaymentCompletState();

  static MaterialPage<dynamic> page(String title, String description,
      String nameButton, Function callbackButton) {
    return MaterialPage(
      child: SuccessPage(
        title: title,
        description: description,
        nameButton: nameButton,
        callbackButton: callbackButton,
      ),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/success_page';
}

class _PaymentCompletState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 355,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: theme.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 36,
                ),
                Image.asset('assets/images/loading_5.png'),
                SizedBox(
                  height: 22,
                ),
                Text(
                  widget.title,
                  style: theme.text20Semibold,
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
                  widget.description,
                  style: theme.text16Regular,
                ),
                SizedBox(
                  height: 38,
                ),
                DefaultButton(
                  widht: MediaQuery.of(context).size.width - 80,
                  title: widget.nameButton,
                  onTap: () {
                    widget.callbackButton.call();
                  },
                  status: ButtonStatus.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
