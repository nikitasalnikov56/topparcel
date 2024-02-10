import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

enum ButtonStatus { disable, primary }

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.height = 52,
    required this.widht,
    required this.title,
    required this.onTap,
    required this.status,
    this.child,
  });

  final double height;
  final double widht;
  final String title;
  final Function onTap;
  final ButtonStatus status;
  final Widget? child;

  Color _colorButton(UIThemes theme) {
    if (status == ButtonStatus.disable) {
      return theme.disableButtonColor;
    }
    if (status == ButtonStatus.primary) {
      return theme.primaryColor;
    }
    return theme.extraLightGrey;
  }

  Color _textColor(UIThemes theme) {
    if (status == ButtonStatus.disable) {
      return theme.lightGrey;
    }
    if (status == ButtonStatus.primary) {
      return theme.white;
    }
    return theme.lightGrey;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return InkWell(
      highlightColor: theme.white,
      focusColor: theme.white,
      splashColor: theme.white,
      overlayColor: MaterialStateProperty.all(theme.white),
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: height,
        width: widht,
        decoration: BoxDecoration(
          color: _colorButton(theme),
          borderRadius: BorderRadius.circular(36),
        ),
        child: child ??
            Center(
              child: Text(
                title,
                style: theme.text16Medium.copyWith(color: _textColor(theme)),
                textAlign: TextAlign.center,
              ),
            ),
      ),
    );
    // return SizedBox(
    //   width: widht,
    //   height: height,
    //   child: ElevatedButton(
    //     style: ButtonStyle(
    //       backgroundColor: (MaterialStatePropertyAll(_colorButton(theme))),
    //       foregroundColor: MaterialStatePropertyAll(theme.white),
    //       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(50)))),
    //           elevation: ,
    //     ),
    //     onPressed: () {
    //       onTap.call();
    //     },
    //     child: Text(
    //       title,
    //       style: theme.text16Medium.copyWith(color: _textColor(theme)),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
  }
}
