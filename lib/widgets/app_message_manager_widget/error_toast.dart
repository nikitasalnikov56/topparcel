import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

class ErrorToast extends StatefulWidget {
  final String errorMessage;

  const ErrorToast({
    super.key,
    required this.errorMessage,
  });

  @override
  State<ErrorToast> createState() => _ErrorToastState();
}

class _ErrorToastState extends State<ErrorToast> {
  bool showToast = true;
  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return showToast
        ? Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: theme.errorColor.withOpacity(0.3)),
              color: theme.errorColor,
              // boxShadow: [
              //   BoxShadow(
              //     color: UIThemes.of(context).shadowColor,
              //     spreadRadius: 2,
              //     blurRadius: 4,
              //     offset: const Offset(0, 0),
              //   )
              // ],
            ),
            child: _errorToast(
              widget.errorMessage,
              theme,
            ),
          )
        : Container();
  }

  Widget _errorToast(String errorMessage, UIThemes theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0, boldText: false),
            child: Text(
              errorMessage,
              style: theme.text14Regular.copyWith(color: theme.white),
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              showToast = false;
            });
          },
          child: SvgPicture.asset(
            'assets/icons/x.svg',
            color: theme.white,
            width: 24,
            height: 24,
          ),
        )
      ],
    );
  }
}
