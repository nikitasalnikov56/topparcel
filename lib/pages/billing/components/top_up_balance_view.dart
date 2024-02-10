import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';

import '../../../global/cubits/user_cubit.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

class TopUpBalance extends StatefulWidget {
  const TopUpBalance({super.key});

  @override
  State<TopUpBalance> createState() => _TopUpBalanceState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: TopUpBalance(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/top_up_balance_view';
}

class _TopUpBalanceState extends State<TopUpBalance> {
  TextEditingController _amountController = TextEditingController(text: '\€0');

  @override
  void initState() {
    _amountController.addListener(() {
      if (_amountController.text.isEmpty) {
        _amountController.text = '\€';
        _amountController.selection = TextSelection.fromPosition(
          TextPosition(offset: 1),
        );
      }

      if (_amountController.selection.start == 0) {
        _amountController.selection = TextSelection.fromPosition(
          TextPosition(offset: 1),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final userState = UserCubit.watchState(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          if (_amountController.text == '\€') {
            _amountController.text = '\€0';
          }
        });
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'Top up balance',
            backCallback: () {
              if (userState.status is SuccessFetchPaymentLinkStatus) {
                UserCubit.read(context).init();
              } else {
                PageManager.read(context).pop(rootNavigator: true);
              }
            },
          ),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status is SuccessFetchPaymentLinkStatus) {
              final initialURL =
                  (state.status as SuccessFetchPaymentLinkStatus).model.link;
              return SafeArea(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(initialURL)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform:
                        InAppWebViewOptions(useShouldOverrideUrlLoading: true),
                    android:
                        AndroidInAppWebViewOptions(useHybridComposition: true),
                  ),
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    log('🌍🌍🌍: ${url.toString()}');
                    if (url.toString().contains("result-ok")) {
                      controller.stopLoading();
                      UserCubit.read(context).init();
                    }
                  },
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Amount',
                            style: theme.text16Regular
                                .copyWith(color: theme.white),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: TextField(
                              controller: _amountController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: theme.header32Bold
                                  .copyWith(color: theme.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: theme.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        _methodPayCell(
                          theme,
                          'PayPal',
                          () {
                            if (_amountController.text != '\€0') {
                              UserCubit.read(context).topup(
                                userState.user.email,
                                int.parse(_amountController.text
                                    .replaceAll('\€', '')),
                                1,
                              );
                            } else {
                              AppMessageCubit.read(context)
                                  .showErrorMessage('Enter amount');
                            }
                          },
                          pathToIMG: 'assets/images/payPal.png',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        _methodPayCell(
                          theme,
                          'Bank card',
                          () {
                            if (_amountController.text != '\€0') {
                              UserCubit.read(context).topup(
                                userState.user.email,
                                int.parse(_amountController.text
                                    .replaceAll('\€', '')),
                                2,
                              );
                            } else {
                              AppMessageCubit.read(context)
                                  .showErrorMessage('Enter amount');
                            }
                          },
                          pathToSVG: 'assets/icons/card.svg',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _methodPayCell(UIThemes theme, String title, Function callback,
      {String pathToIMG = '', String pathToSVG = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          callback.call();
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (pathToIMG.isNotEmpty)
                          Image.asset(pathToIMG)
                        else
                          SvgPicture.asset(pathToSVG),
                        SizedBox(
                          width: 8,
                        ),
                        Text(title, style: theme.text14Regular),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'commission: £20',
                      style:
                          theme.text12Regular.copyWith(color: theme.darkGrey),
                    ),
                  ],
                ),
                Container(
                  width: 104,
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.extraLightGrey),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Center(
                    child: Text(
                      'Pay',
                      style: theme.text12Regular,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
