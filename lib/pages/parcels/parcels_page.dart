import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/pages/parcels/cubit/parcels_popup_menu_cubit.dart';
import 'package:topparcel/pages/parcels/state/parcels_popup_menu_state.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/services/service_locator.dart';
import 'package:topparcel/widgets/app_bar/main_app_bar.dart';
import 'package:topparcel/widgets/empty_state/empty_state_widget.dart';

import '../../data/models/response/fetch_parcels_response.dart';
import '../../global/cubits/parcels_cubit.dart';
import '../../helpers/utils/date_utils.dart';
import '../../navigation/page_manager.dart';
import '../create_parcel/create_parcel_page.dart';

class ParcelsPage extends StatefulWidget {
  const ParcelsPage({super.key});

  @override
  State<ParcelsPage> createState() => _ParcelsPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: ParcelsPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/parcels_page';
}

class _ParcelsPageState extends State<ParcelsPage> {
  List<ParcelModel> filterParcels = [];
  String filteredTypeParcelString = 'All';

  DateTime filteredStartDate = DateTime.now();
  DateTime filteredEndDate = DateTime.now().add(
    Duration(
      days: CustomDateUtils()
          .countDayInMonth(DateTime.now().month, DateTime.now().year),
    ),
  );

  void _filteredParcels(List<ParcelModel> listParcels) {
    filterParcels.clear();
    for (var parcel in listParcels) {
      filterParcels.add(parcel);
    }

    // filter type parcel
    List<ParcelModel> filteredByTypeParcel = [];
    if (filteredTypeParcelString != 'All') {
      for (var parcel in filterParcels) {
        if (parcel.status == filteredTypeParcelString) {
          filteredByTypeParcel.add(parcel);
        }
      }
    } else {
      for (var parcel in filterParcels) {
        filteredByTypeParcel.add(parcel);
      }
    }

    // filter date
    List<ParcelModel> filterDateTarcel = [];
    for (var parcel in filteredByTypeParcel) {
      if (parcel.dateCreate.isAfter(filteredStartDate) &&
          parcel.dateCreate.isBefore(filteredEndDate))
        filterDateTarcel.add(parcel);
    }
    filterParcels = filterDateTarcel;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelsState = ParcelsCubit.watchState(context);
    final userState = UserCubit.watchState(context);
    _filteredParcels(parcelsState.parcelsList);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: MainAppBar(
          title: 'Parcels',
          isParcelsTab: true,
          filteredEndDate: filteredEndDate,
          filteredStartDate: filteredStartDate,
          filteredTypeParcel: filteredTypeParcelString,
          filteredCallback: (type, startDate, endDate) {
            setState(() {
              filteredTypeParcelString = type;
              filteredStartDate = startDate;
              filteredEndDate = endDate;
            });
            _filteredParcels(parcelsState.parcelsList);
          },
        ),
      ),
      body: Stack(
        children: [
          if (filterParcels.isEmpty)
            EmptyState(type: EmptyStateType.parcels)
          else
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ListView.separated(
                itemCount: filterParcels.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 496,
                      decoration: BoxDecoration(
                          color: theme.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: theme.black.withOpacity(0.08),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      child: Text(
                                        '${filterParcels[index].collection.firstName} ${filterParcels[index].collection.lastName}',
                                        style: theme.header16Bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: Text(
                                        'Recipient',
                                        style: theme.text12Regular,
                                      ),
                                    ),
                                  ],
                                ),
                                BlocProvider(
                                  lazy: true,
                                  create: (_) => ParcelsPopupMenuCubit(
                                    appMessageCubit: AppMessageCubit.read(_),
                                    userRepository: sl(),
                                  ),
                                  child: BlocBuilder<ParcelsPopupMenuCubit,
                                      ParcelsPopupMenuState>(
                                    builder: (context, state) {
                                      return PopupMenuButton(
                                        offset: Offset(0, 10),
                                        color: theme.primaryColor,
                                        child: SvgPicture.asset(
                                          'assets/icons/dots.svg',
                                          color: theme.orangeColor,
                                        ),
                                        itemBuilder: (context) {
                                          List<PopupMenuEntry<Object>> list =
                                              [];
                                          list.add(
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          ParcelsPopupMenuCubit>()
                                                      .showInvoice(
                                                        userState.user.email,
                                                        int.parse(
                                                            filterParcels[index]
                                                                .id),
                                                      );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Text(
                                                    'Invoice (print)',
                                                    style: theme.text14Regular
                                                        .copyWith(
                                                            color: theme.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          list.add(
                                            PopupMenuDivider(
                                              height: 1,
                                            ),
                                          );
                                          list.add(
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          ParcelsPopupMenuCubit>()
                                                      .showDeclaration(
                                                        filterParcels[index]
                                                            .address
                                                            .email,
                                                        int.parse(
                                                            filterParcels[index]
                                                                .id),
                                                      );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Text(
                                                    'Declaration (print)',
                                                    style: theme.text14Regular
                                                        .copyWith(
                                                            color: theme.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          list.add(
                                            PopupMenuDivider(
                                              height: 1,
                                            ),
                                          );
                                          list.add(
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          ParcelsPopupMenuCubit>()
                                                      .showLabel(
                                                        filterParcels[index]
                                                            .address
                                                            .email,
                                                        int.parse(
                                                            filterParcels[index]
                                                                .id),
                                                      );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Text(
                                                    'Label (PDF)',
                                                    style: theme.text14Regular
                                                        .copyWith(
                                                            color: theme.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          list.add(
                                            PopupMenuDivider(
                                              height: 1,
                                            ),
                                          );
                                          list.add(
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          ParcelsPopupMenuCubit>()
                                                      .showDocuments(
                                                        filterParcels[index]
                                                            .address
                                                            .email,
                                                        int.parse(
                                                            filterParcels[index]
                                                                .id),
                                                      );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Text(
                                                    'Documents (PDF)',
                                                    style: theme.text14Regular
                                                        .copyWith(
                                                            color: theme.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                          return list;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _parcelsCellWidget(
                                theme, 'ID', filterParcels[index].id,
                                colors: theme.primaryColor),
                            _parcelsCellWidget(
                                theme,
                                'Date, ${filterParcels[index]}',
                                DateFormat('dd.MM.yyyy')
                                    .format(filterParcels[index].dateCreate)),
                            _parcelsCellWidget(
                                theme, 'Status', filterParcels[index].status,
                                isStatus: true),
                            _parcelsCellWidget(theme, 'Phone number',
                                filterParcels[index].collection.phone),
                            _parcelsCellWidget(theme, 'Adress',
                                filterParcels[index].collection.addressline1),
                            _parcelsCellWidget(theme, 'Delivery service',
                                filterParcels[index].collection.company),
                            _parcelsCellWidget(theme, 'Tracking No.',
                                filterParcels[index].track),
                            _parcelsCellWidget(theme, 'Cost',
                                '${filterParcels[index].cost} | inc VAT ${filterParcels[index].collection.vatNumber}'),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: theme.disableButtonColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(
                                filterParcels[index].address.lastName +
                                    filterParcels[index].address.firstName,
                                style: theme.header16Bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(
                                'Sender',
                                style: theme.text12Regular,
                              ),
                            ),
                            _parcelsCellWidget(theme, 'Phone number',
                                filterParcels[index].address.phone),
                            _parcelsCellWidget(theme, 'Address',
                                filterParcels[index].address.addressline1),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: InkWell(
                onTap: () {
                  ParcelsCubit.read(context)
                      .showCreateParcelPage(StepParcel.firstInfo);
                  PageManager.read(context)
                      .push(CreateParcelPage.page(), rootNavigator: true);
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Icon(
                    Icons.add,
                    color: theme.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _parcelsCellWidget(UIThemes theme, String title1, String title2,
      {bool isStatus = false, Color? colors}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: isStatus ? 28 : 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1,
              style: theme.text14Regular.copyWith(color: theme.grey),
            ),
            if (isStatus)
              Container(
                decoration: BoxDecoration(
                  color: _colorBackgroundStatus(theme, title2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                  child: Text(
                    title2,
                    style: theme.text12Regular.copyWith(
                        color: colors ?? _colorTextStatus(theme, title2)),
                  ),
                ),
              )
            else
              Text(
                title2,
                style: theme.text14Regular.copyWith(color: colors),
              ),
          ],
        ),
      ),
    );
  }

  Color _colorTextStatus(UIThemes theme, String status) {
    switch (status) {
      case 'Pending':
        return theme.primaryColor;
      default:
        return theme.primaryColor;
    }
  }

  Color _colorBackgroundStatus(UIThemes theme, String status) {
    switch (status) {
      case 'Pending':
        return theme.orangeColor.withOpacity(0.2);
      default:
        return theme.orangeColor.withOpacity(0.2);
    }
  }
}
