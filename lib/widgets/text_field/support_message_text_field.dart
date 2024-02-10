import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

class SupportMessageTextField extends StatelessWidget {
  const SupportMessageTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.onChanged,
    required this.errorMessage,
    required this.placeholder,
    this.preffixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.isRepeatePassword = false,
    this.height = 44,
    this.maxLines,
    this.formaters,
    this.keyboardType,
  });

  final String title;
  final TextEditingController controller;
  final Function onChanged;
  final String errorMessage;
  final String placeholder;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isRepeatePassword;
  final double height;
  final int? maxLines;
  final List<TextInputFormatter>? formaters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Text(
              title,
              style: theme.header14Semibold,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height,
          child: TextField(
            cursorColor: theme.darkGrey,
            maxLines: maxLines,
            controller: controller,
            onChanged: (context) {
              onChanged.call();
            },
            obscureText: obscureText,
            inputFormatters: formaters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              suffixIconColor: theme.darkGrey,
              prefixIcon: preffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: preffixIcon,
                    )
                  : null,
              prefixIconColor:
                  errorMessage.isNotEmpty ? theme.errorColor : theme.black,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 1,
                    color: errorMessage.isEmpty
                        ? isRepeatePassword
                            ? theme.green
                            : theme.lightGrey
                        : theme.errorColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 1,
                    color: errorMessage.isEmpty
                        ? isRepeatePassword
                            ? theme.green
                            : theme.lightGrey
                        : theme.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: theme.errorColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: theme.errorColor),
              ),
              hintText: placeholder,
              hintStyle:
                  theme.text14Regular.copyWith(color: theme.extraLightGrey),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: preffixIcon == null ? 10 : 0),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: errorMessage.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (errorMessage.isNotEmpty) ...[
              Text(
                errorMessage,
                style: theme.text14Regular.copyWith(color: theme.errorColor),
              ),
            ],
            if (controller.text.isNotEmpty)
              Text(
                '${controller.text.length} / 2000',
                style: theme.text14Regular.copyWith(
                    color: controller.text.length > 2000
                        ? theme.errorColor
                        : theme.black),
              )
          ],
        ),
      ],
    );
  }
}
