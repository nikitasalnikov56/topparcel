import 'package:flutter/material.dart';

import '../../../helpers/utils/ui_themes.dart';
import '../../../widgets/drop_down/drop_down_field.dart';

class DropDownCreateParcel extends StatelessWidget {
  const DropDownCreateParcel({
    super.key,
    required this.widht,
    required this.placeholder,
    required this.seleteElement,
    required this.items,
    required this.onSelected,
    required this.error,
    required this.title,
    this.backgroundColor,
  });

  final double widht;
  final String title;
  final String placeholder;
  final String seleteElement;
  final List<String> items;
  final Function(String, int) onSelected;
  final String error;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return SizedBox(
      width: widht,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.header14Semibold,
          ),
          SizedBox(
            height: 8,
          ),
          DropDownField(
            placeholder: placeholder,
            items: items,
            selecteElement: seleteElement,
            onChange: (element, index) {
              onSelected.call(element, index);
            },
            isError: error.isNotEmpty,
            radius: 8,
            backgroundColor: backgroundColor,
          ),
          if (error.isNotEmpty) ...[
            SizedBox(
              height: 3,
            ),
            Text(
              error,
              style: theme.text14Regular.copyWith(color: theme.errorColor),
            )
          ]
        ],
      ),
    );
  }
}
