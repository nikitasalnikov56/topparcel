import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/settings/components/contact_view.dart';
import 'package:topparcel/pages/settings/components/language_view.dart';
import 'package:topparcel/pages/settings/components/privacy_policy_view.dart';
import 'package:topparcel/pages/settings/components/support_view.dart';
import 'package:topparcel/pages/settings/components/terms_of_use_view.dart';
import 'package:topparcel/widgets/app_bar/main_app_bar.dart';
import 'package:topparcel/widgets/dialogs/action_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/cubits/auth_cubit.dart';
import '../../helpers/utils/ui_themes.dart';
import '../login/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: SettingsPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/settings_page';
}

class _SettingsPageState extends State<SettingsPage> {
  bool isTrackingTimeline = false;

  String? _version;

  @override
  void initState() {
    super.initState();
    _setVersion();
  }

  _setVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version} (${info.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: MainAppBar(
              title: 'Settings',
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 12, bottom: 20),
                    //   child: Container(
                    //     color: theme.white,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 12, horizontal: 20),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.only(bottom: 10),
                    //                 child: Text(
                    //                   'Tracking timeline and details',
                    //                   style: theme.text14Medium,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width:
                    //                     MediaQuery.of(context).size.width - 120,
                    //                 child: Text(
                    //                   'Keep track of your package delivery with timeline and tracking details',
                    //                   style: theme.text14Regular,
                    //                   maxLines: 4,
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //           CupertinoSwitch(
                    //               activeColor: isTrackingTimeline
                    //                   ? theme.primaryColor
                    //                   : theme.extraLightGrey,
                    //               value: isTrackingTimeline,
                    //               onChanged: ((bool value) {
                    //                 setState(() {
                    //                   isTrackingTimeline = !isTrackingTimeline;
                    //                 });
                    //               }))
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    _listSettingsCells(theme),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 20),
                child: Text(
                  'Application version ${_version ?? '1.0.0'}',
                  style: theme.text14Regular.copyWith(color: theme.lightGrey),
                ),
              )
            ],
          )),
    );
  }

  Widget _listSettingsCells(UIThemes theme) {
    return Container(
      color: theme.white,
      child: Column(
        children: [
          _settingsCell(
            theme,
            'assets/icons/microphone.svg',
            'Support',
            () {
              PageManager.read(context)
                  .push(SupportView.page(), rootNavigator: true);
            },
            isFirst: true,
          ),
          _settingsCell(
            theme,
            'assets/icons/globe.svg',
            'Language',
            () {
              PageManager.read(context)
                  .push(LanguageView.page(), rootNavigator: true);
            },
          ),
          _settingsCell(
            theme,
            'assets/icons/file.svg',
            'Privacy Policy',
            () {
              _launchPrivacy.call();
            },
          ),
          _settingsCell(
            theme,
            'assets/icons/file.svg',
            'Terms of Use',
            () {
              _launchTerms.call();
            },
          ),
          _settingsCell(
            theme,
            'assets/icons/phone.svg',
            'Contact',
            () {
              PageManager.read(context)
                  .push(ContactView.page(), rootNavigator: true);
            },
          ),
          _settingsCell(
            theme,
            'assets/icons/logout.svg',
            'Log out',
            () {
              showDialog(
                context: context,
                builder: (context) => ActionDialog(
                  title: 'Log out',
                  description: 'Do you really want to log out of your account?',
                  okCallback: () {
                    AuthCubit.read(context).logout();
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _launchPrivacy() async {
    Uri _url = Uri.parse('https://topparcel.com/privacy-policy');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchTerms() async {
    Uri _url = Uri.parse('https://topparcel.com/terms-and-conditions');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  Widget _settingsCell(UIThemes theme, String pathToIcons, String nameIcons,
      Function() actionOnTab,
      {bool isFirst = false}) {
    return InkWell(
      onTap: () => actionOnTab.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: isFirst
              ? null
              : BoxDecoration(
                  border: Border(top: BorderSide(color: theme.extraLightGrey))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SvgPicture.asset(
                    pathToIcons,
                    //color: theme.grey,
                    width: 24,
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.83),
                    child: Text(
                      nameIcons,
                      style: theme.text14Medium,
                    ),
                  ),
                ]),
                SvgPicture.asset(
                  'assets/icons/errow_right.svg',
                  color: theme.grey,
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
