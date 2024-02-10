import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topparcel/navigation/page_manager.dart';

import '../../helpers/utils/ui_themes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backCallback,
    this.action,
  });

  final String title;
  final Function? backCallback;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: Text(
        title,
        style: theme.text20Semibold,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      actions: [
        if (action != null)
          action!
        else
          SizedBox(
            width: 60,
          )
      ],
      leading: InkWell(
        onTap: () {
          if (backCallback != null) {
            backCallback!.call();
          } else {
            PageManager.read(context).pop(rootNavigator: true);
          }
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: theme.black,
        ),
      ),
    );
  }
}
