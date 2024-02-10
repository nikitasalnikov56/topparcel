//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

import '../../../../widgets/app_bar/custom_app_bar.dart';

class ReferralsView extends StatefulWidget {
  const ReferralsView({super.key});

  @override
  State<ReferralsView> createState() => _ReferralsViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: ReferralsView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/referrals_view';
}

class _ReferralsViewState extends State<ReferralsView> {
  String refferal = 'topparcel.com';

  final theme = UIThemes();
  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);
    refferal = 'https://topparcel.com/send-parcel?ref=${userState.user.id}';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Referrals',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 56),
                    child: Image.asset('assets/images/orange_logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Refer friends and get bonus for every parcel they send',
                          style: theme.header14Bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border(
                                top:
                                    BorderSide(color: theme.disableButtonColor),
                                bottom:
                                    BorderSide(color: theme.disableButtonColor),
                                left:
                                    BorderSide(color: theme.disableButtonColor),
                                right: BorderSide(
                                    color: theme.disableButtonColor)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _rowWithCopy(
                            theme,
                            refferal,
                            () async {
                              await Clipboard.setData(
                                  ClipboardData(text: refferal));
                              AppMessageCubit.read(context)
                                  .showInformationMessage(
                                      'Referral link copied');
                            },
                          ),
                        ),
                        _listCells(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            height: 250,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Text(
                  'Share',
                  style: theme.header14Semibold.copyWith(color: theme.white),
                ),
                SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Share.share(refferal);
                      },
                      child: SvgPicture.asset('assets/icons/facebook.svg'),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    InkWell(
                      onTap: () {
                        Share.share(refferal);
                      },
                      child: SvgPicture.asset('assets/icons/twitter.svg'),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    InkWell(
                      onTap: () {
                        Share.share(refferal);
                      },
                      child: SvgPicture.asset('assets/icons/gmail.svg'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _rowWithCopy(UIThemes theme, String link, Function onTap) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              link,
              style: theme.text14Regular.copyWith(color: theme.orangeColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/folder.svg',
            color: theme.grey,
          ),
          SizedBox(
            width: 8,
          ),
          Text('Copy', style: theme.text14Regular),
        ],
      ),
    );
  }

  Widget _listCells() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _cell('0', 'Earned money'),
          SizedBox(
            width: 11,
          ),
          _cell('0', 'Users referred'),
          SizedBox(
            width: 11,
          ),
          _cell('0', 'Total clicks')
        ],
      ),
    );
  }

  Widget _cell(String number, String description) {
    return Container(
      width: (MediaQuery.of(context).size.width - 62) / 3,
      padding: EdgeInsets.symmetric(
        vertical: 28,
      ),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: theme.disableButtonColor),
            bottom: BorderSide(color: theme.disableButtonColor),
            left: BorderSide(color: theme.disableButtonColor),
            right: BorderSide(color: theme.disableButtonColor)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: theme.text18Medium,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: theme.text12Regular.copyWith(color: theme.grey),
          ),
        ],
      ),
    );
  }
}
