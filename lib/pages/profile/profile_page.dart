import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/pages/profile/components/personal_info_view.dart';
import 'package:topparcel/pages/profile/components/referrals_view.dart';
import 'package:topparcel/pages/profile/components/safety_view.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';
import 'package:topparcel/widgets/dialogs/action_dialog.dart';

import '../../../helpers/utils/ui_themes.dart';
import '../../../navigation/page_manager.dart';
import '../../global/cubits/auth_cubit.dart';
import '../addresses/addresses_view.dart';
import '../billing/billing_view.dart';
import '../billing/components/top_up_balance_view.dart';
import '../billing/components/withdraw_funds_view.dart';
import '../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: ProfilePage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/profile_page';
}

class _ProfilePageState extends State<ProfilePage> {
  final theme = UIThemes();

  @override
  Widget build(BuildContext context) {
    final userState = UserCubit.watchState(context);
    final email = userState.email;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Profile',
          action: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ActionDialog(
                      title: 'Log out',
                      description:
                          'Do you really want to log out of your account?',
                      okCallback: () {
                        AuthCubit.read(context).logout();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: SvgPicture.asset('assets/icons/logout.svg'),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                          height: 44,
                          width: 44,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/icons/person.svg',
                              color: theme.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: theme.extraLightGrey,
                            borderRadius: BorderRadius.circular(44),
                          )),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userState.user.firstname} ${userState.user.lastname}',
                            style: theme.header16Bold,
                          ),
                          SizedBox(height: 4),
                          Text(
                            email,
                            style:
                                theme.text14Regular.copyWith(color: theme.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your balance',
                            style: theme.text16Regular
                                .copyWith(color: theme.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${userState.user.balance} \€',
                            style:
                                theme.header32Bold.copyWith(color: theme.white),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 85) /
                                        2,
                                decoration: BoxDecoration(
                                  color: theme.white,
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                child: _buttonTopUpOrWithdraw(
                                  'Top up balance',
                                  true,
                                  () {
                                    PageManager.read(context).push(
                                        TopUpBalance.page(),
                                        rootNavigator: true);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 85) /
                                        2,
                                decoration: BoxDecoration(
                                  color: theme.white,
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                child: _buttonTopUpOrWithdraw(
                                  'Withdraw funds',
                                  false,
                                  () {
                                    PageManager.read(context).push(
                                        WithdrawFunds.page(),
                                        rootNavigator: true);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _listDetailsProfile(theme),
            _detailsProfileCell(
              theme,
              'Delete profile',
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ActionDialog(
                      title: 'Delete account',
                      description: 'Do you really want to delete your account?',
                      okCallback: () {
                        AuthCubit.read(context).deleteAccount(userState.email);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              isFirst: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonTopUpOrWithdraw(
      String nameButton, bool isTopUpBalance, Function onTap) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isTopUpBalance
                  ? 'assets/icons/logout_2.svg'
                  : 'assets/icons/share.svg',
              height: 16,
              width: 16,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              nameButton,
              style: theme.text12Semibold,
            )
          ],
        ),
      ),
    );
  }

  Widget _listDetailsProfile(UIThemes theme) {
    return Container(
      child: Column(
        children: [
          _detailsProfileCell(
            theme,
            'Personal information',
            () {
              PageManager.read(context)
                  .push(PersonalInfoView.page(), rootNavigator: true);
            },
          ),
          _detailsProfileCell(
            theme,
            'Safety',
            () {
              PageManager.read(context)
                  .push(SafetyView.page(), rootNavigator: true);
            },
          ),
          _detailsProfileCell(
            theme,
            'Addresses',
            () {
              PageManager.read(context)
                  .push(AddressesView.page(), rootNavigator: true);
            },
          ),
          _detailsProfileCell(
            theme,
            'Billing',
            () {
              PageManager.read(context)
                  .push(BillingView.page(), rootNavigator: true);
            },
          ),
          _detailsProfileCell(
            theme,
            'Referrals',
            () {
              PageManager.read(context)
                  .push(ReferralsView.page(), rootNavigator: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _detailsProfileCell(
      UIThemes theme, String nameDetailsProfile, Function() actionOnTab,
      {bool isFirst = false}) {
    final isIphoneSe = MediaQuery.of(context).size.height == 667;
    return InkWell(
      onTap: () => actionOnTab.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: isFirst
              ? null
              : BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.extraLightGrey))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: isIphoneSe ? 14 : 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(
                    nameDetailsProfile,
                    style: theme.text14Medium,
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
