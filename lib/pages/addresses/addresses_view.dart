import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/response/fetch_addresses_response.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/addresses/components/add_addresses_view.dart';
import 'package:topparcel/pages/addresses/components/edit_addresses_view.dart';
import 'package:topparcel/widgets/dialogs/action_dialog.dart';
import 'package:topparcel/widgets/empty_state/empty_state_widget.dart';

import '../../global/cubits/parcels_cubit.dart';
import '../../helpers/utils/ui_themes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: AddressesView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/addresses_view';
}

class _AddressesViewState extends State<AddressesView> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final userState = UserCubit.watchState(context);
    final parcelsState = ParcelsCubit.watchState(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'Addresses',
          ),
        ),
        body: Stack(
          children: [
            if (userState.addressList.isEmpty)
              EmptyState(type: EmptyStateType.address)
            else
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: userState.addressList.length,
                      itemBuilder: (context, index) {
                        return _listInfoAddressesCell(
                            userState.addressList[index],
                            parcelsState.countriesList,
                            theme);
                      },
                    ),
                  )
                ],
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 40),
                child: InkWell(
                  onTap: () {
                    PageManager.read(context)
                        .push(AddAddressesView.page(), rootNavigator: true);
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
        ));
  }

  Widget _listInfoAddressesCell(
      UserAddress address, List<Country> countryList, UIThemes theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.white,
          boxShadow: [
            BoxShadow(
              color: theme.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(children: [
          Container(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${address.lastname} ${address.firstname}',
                        style: theme.header16Bold),
                    Text(
                      'Recipient',
                      style: theme.text12Regular,
                    ),
                  ],
                ),
                PopupMenuButton(
                  offset: Offset(0, 10),
                  color: theme.primaryColor,
                  child: SvgPicture.asset(
                    'assets/icons/dots.svg',
                    color: theme.orangeColor,
                  ),
                  itemBuilder: (context) {
                    List<PopupMenuEntry<Object>> list = [];
                    list.add(
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {
                            PageManager.read(context).push(
                                EditAddressesView.page(address),
                                rootNavigator: true);
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              'Edit',
                              style: theme.text14Regular
                                  .copyWith(color: theme.white),
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ActionDialog(
                                  title: 'Delete address',
                                  description:
                                      'Do you really want to delete your address?',
                                  okCallback: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              'Delete',
                              style: theme.text14Regular
                                  .copyWith(color: theme.white),
                            ),
                          ),
                        ),
                      ),
                    );

                    return list;
                  },
                ),
              ],
            ),
          ),
          _infoAddressesCell(
            'Country',
            countryList.firstWhere(
                        (element) => element.id == address.countryId) !=
                    null
                ? countryList
                    .firstWhere((element) => element.id == address.countryId)
                    .name
                : '',
            theme,
          ),
          Container(
            height: 12,
          ),
          _infoAddressesCell(
            'City',
            address.city,
            theme,
          ),
          Container(
            height: 12,
          ),
          _infoAddressesCell(
            'Province',
            address.region,
            theme,
          ),
          Container(
            height: 12,
          ),
          _infoAddressesCell(
            'Address',
            address.addressLine1,
            theme,
          ),
          Container(
            height: 12,
          ),
          _infoAddressesCell(
            'Postcode',
            address.zipcode,
            theme,
          ),
          Container(
            height: 12,
          ),
          _infoAddressesCell(
            'Phone number',
            address.phone,
            theme,
          ),
          Container(
            height: 12,
          ),
        ]),
      ),
    );
  }

  Widget _infoAddressesCell(String name1, String name2, UIThemes theme) {
    return Container(
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
                  //style: theme.text14Regular.copyWith(color: colorr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
