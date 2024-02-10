import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

class LogoParcelWidget extends StatelessWidget {
  const LogoParcelWidget({
    super.key,
    required this.details,
    this.isDecoration = false,
  });

  final String details;
  final bool isDecoration;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Container(
      decoration: isDecoration
          ? BoxDecoration(
              color: theme.white,
              boxShadow: [
                BoxShadow(
                  color: theme.black.withOpacity(0.08),
                  spreadRadius: 1,
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            )
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDecoration ? 16 : 0, vertical: isDecoration ? 20 : 0),
        child: Row(
          children: [
            SizedBox(
              height: 34,
              width: 34,
              child: Image.asset('assets/images/logo_parcel.png'),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GlobalPost GB Standart',
                  style: theme.header16Bold,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 270),
                  child: Text(
                    details,
                    style: theme.text12Regular,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
