import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/utils/ui_themes.dart';

class InfoToast extends StatefulWidget {
  final String message;

  const InfoToast({
    super.key,
    required this.message,
  });

  @override
  State<InfoToast> createState() => _InfoToastState();
}

class _InfoToastState extends State<InfoToast> {
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
              border: Border.all(color: theme.green.withOpacity(0.3)),
              color: theme.green,
            ),
            child: _infoToast(
              widget.message,
              theme,
            ),
          )
        : Container();
  }

  Widget _infoToast(
    String errorMessage,
    UIThemes theme,
  ) {
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
            color: theme.green,
            width: 24,
            height: 24,
          ),
        )
      ],
    );
  }
}
