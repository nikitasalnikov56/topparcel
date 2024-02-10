import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.okCallback,
  });

  final String title;
  final String description;
  final Function okCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            title,
            style: theme.header14Bold,
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  description,
                  style: theme.text14Regular,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                height: 42,
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: theme.extraLightGrey))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          highlightColor: theme.white,
                          focusColor: theme.white,
                          splashColor: theme.white,
                          overlayColor: MaterialStateProperty.all(theme.white),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: theme.text16Regular
                                .copyWith(color: theme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 42,
                        color: theme.extraLightGrey,
                      ),
                      Expanded(
                        child: InkWell(
                          highlightColor: theme.white,
                          focusColor: theme.white,
                          splashColor: theme.white,
                          overlayColor: MaterialStateProperty.all(theme.white),
                          onTap: () {
                            okCallback.call();
                          },
                          child: Text(
                            'Yes',
                            style: theme.text16Regular
                                .copyWith(color: theme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.only(top: 2),
        ),
      ],
    );
  }
}
