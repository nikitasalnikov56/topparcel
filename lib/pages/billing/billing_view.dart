import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:topparcel/data/models/app_model/invoice_model.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/parcels/state/parcels_popup_menu_state.dart';
import 'package:topparcel/widgets/empty_state/empty_state_widget.dart';

import '../../navigation/page_manager.dart';
import '../../services/service_locator.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../parcels/cubit/parcels_popup_menu_cubit.dart';
import 'components/top_up_balance_view.dart';
import 'components/withdraw_funds_view.dart';

class BillingView extends StatefulWidget {
  const BillingView({super.key});

  @override
  State<BillingView> createState() => _BillingViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: BillingView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/billing_view';
}

class _BillingViewState extends State<BillingView> {
  final theme = UIThemes();

  @override
  Widget build(BuildContext context) {
    final parcelState = ParcelsCubit.watchState(context);
    final userState = UserCubit.watchState(context);
    final invoices = parcelState.parcelsList
        .where(
          (e) => e.invoice.isNotEmpty,
        )
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Operations',
        ),
      ),
      body: invoices.isNotEmpty
          ? BlocProvider(
              lazy: true,
              create: (_) => ParcelsPopupMenuCubit(
                appMessageCubit: AppMessageCubit.read(_),
                userRepository: sl(),
              ),
              child: BlocBuilder<ParcelsPopupMenuCubit, ParcelsPopupMenuState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 16, left: 20, right: 20),
                          child: Row(
                            children: [
                              _buttonOperationsCell(
                                theme,
                                'Top up balance',
                                () {
                                  PageManager.read(context).push(
                                      TopUpBalance.page(),
                                      rootNavigator: true);
                                },
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              _buttonOperationsCell(
                                theme,
                                'Withdraw funds',
                                () {
                                  PageManager.read(context).push(
                                      WithdrawFunds.page(),
                                      rootNavigator: true);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 70,
                          child: ListView.builder(
                            itemCount: invoices.length,
                            itemBuilder: (context, index) {
                              return _listInfoOperationsCell(
                                userState.email,
                                invoices[index].invoice[0],
                                () {
                                  context
                                      .read<ParcelsPopupMenuCubit>()
                                      .showInvoice(
                                        userState.email,
                                        int.parse(invoices[index]
                                            .invoice[0]
                                            .typeId
                                            .toString()),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     _listInfoOperationsCell(),
                        //     SizedBox(
                        //       height: 16,
                        //     ),
                        //     _listInfoOperationsCell(),
                        //     SizedBox(
                        //       height: 16,
                        //     ),
                        //     _listInfoOperationsCell(),
                        //     SizedBox(
                        //       height: 16,
                        //     ),
                        //     _listInfoOperationsCell(),
                        //     SizedBox(
                        //       height: 16,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  );
                },
              ),
            )
          : EmptyState(type: EmptyStateType.operations),
    );
  }

  Widget _buttonOperationsCell(
      UIThemes theme, String nameButtonOperations, Function() actionOnTab) {
    return InkWell(
      onTap: () => actionOnTab.call(),
      child: Container(
        width: (MediaQuery.of(context).size.width - 49) / 2,
        decoration: BoxDecoration(
          color: theme.disableButtonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            nameButtonOperations,
            style: theme.text14Regular.copyWith(color: theme.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _listInfoOperationsCell(
      String email, InvoiceModel invoice, Function invoiceCallback) {
    return Container(
      //color: theme.white,
      child: Column(children: [
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell(
            'ID', invoice.id.toString(), theme.white, theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell(
            'Date',
            DateFormat('dd.MM.yyyy').format(invoice.createdDt),
            theme.white,
            theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell('Type operation', _typeOperation(invoice.typeId),
            theme.white, theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell(
          'Invoice',
          invoice.number,
          theme.white,
          theme.errorColor,
          invoiceCallback: invoiceCallback,
        ),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell(
            'Income, \€', '0', theme.green.withOpacity(0.2), theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell('Outcome, \€', '-${invoice.total}',
            theme.errorColor.withOpacity(0.2), theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
        _infoOperationsCell(
            'Income, \€', '0', theme.green.withOpacity(0.2), theme.black),
        Container(
          color: theme.white,
          height: 12,
        ),
      ]),
    );
  }

  String _typeOperation(int type) {
    switch (type) {
      case 1:
        return 'Paypal';
      case 2:
        return 'Bank cards';
      case 3:
        return 'Bank transfer';
      default:
        return 'Refund';
    }
  }

  Widget _infoOperationsCell(
      String name1, String name2, Color myColor, Color colorr,
      {Function? invoiceCallback}) {
    return InkWell(
      onTap: () {
        if (invoiceCallback != null) {
          invoiceCallback.call();
        }
      },
      child: Container(
        color: myColor,
        height: 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name1,
                    style: theme.text14Regular.copyWith(color: theme.grey),
                  ),
                  Text(
                    name2,
                    style: theme.text14Regular.copyWith(color: colorr),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
