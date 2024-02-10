import 'package:flutter/services.dart';

class RegExpFormatter extends TextInputFormatter {
  final RegExp regExp;
  final String? currency;

  RegExpFormatter(
    this.regExp, {
    this.currency,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty ||
        !newValue.composing.isCollapsed ||
        !newValue.selection.isCollapsed) {
      return newValue;
    }

    String returnValue = newValue.text;
    if (currency != null) {
      returnValue =
          returnValue.replaceAll(currency ?? '', '').replaceAll(' ', '');
    } else {
      returnValue = returnValue.replaceAll(' ', '');
    }
    final matches = regExp.allMatches(returnValue);
    if (matches.length == 1 &&
        matches.first.group(0).toString() == returnValue) {
      return newValue;
    } else if (returnValue.isEmpty) {
      return const TextEditingValue(text: '');
    }
    return oldValue;
  }
}
