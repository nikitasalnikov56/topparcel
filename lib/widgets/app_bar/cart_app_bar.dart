import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

import '../../navigation/page_manager.dart';
import '../../pages/profile/profile_page.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    super.key,
    required this.title,
    required this.isEmpty,
    required this.isSelecte,
    required this.cancalCallback,
    required this.selecteCallback,
  });

  final String title;
  final bool isEmpty;
  final bool isSelecte;
  final Function cancalCallback;
  final Function selecteCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leadingWidth: 100,
      leading: Container(
        color: theme.backgroundPrimary,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: isSelecte
                  ? InkWell(
                      onTap: () {
                        cancalCallback.call();
                      },
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            'assets/icons/close.svg',
                            color: theme.lightGrey,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        PageManager.read(context)
                            .push(ProfilePage.page(), rootNavigator: true);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: theme.extraLightGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            'assets/icons/person.svg',
                            color: theme.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      title: Text(
        title,
        style: theme.text20Semibold,
        textAlign: TextAlign.center,
      ),
      actions: isEmpty
          ? null
          : [
              Center(
                child: SizedBox(
                  width: 100,
                  child: isSelecte
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cancalCallback.call();
                              },
                              child: Text(
                                'Cancel',
                                style: theme.header14Bold
                                    .copyWith(color: theme.grey),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SvgPicture.asset(
                              'assets/icons/double_check.svg',
                              color: theme.grey,
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            selecteCallback.call();
                          },
                          child: Text(
                            'Selecte item',
                            style:
                                theme.text14Regular.copyWith(color: theme.grey),
                          ),
                        ),
                ),
              )
            ],
    );
  }
}
