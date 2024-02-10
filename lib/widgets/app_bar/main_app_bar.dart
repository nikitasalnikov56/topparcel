import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/profile/profile_page.dart';
import 'package:topparcel/widgets/bottom_sheet/filtered_parcels_bottom_sheet.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    required this.title,
    this.isParcelsTab = false,
    this.action,
    this.filteredTypeParcel,
    this.filteredStartDate,
    this.filteredEndDate,
    this.filteredCallback,
  });

  final String title;
  final bool isParcelsTab;
  final List<Widget>? action;
  final String? filteredTypeParcel;
  final DateTime? filteredStartDate;
  final DateTime? filteredEndDate;
  final Function(String, DateTime, DateTime)? filteredCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actions: action ??
          [
            if (isParcelsTab)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: theme.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          builder: (context) {
                            return Wrap(
                              children: [
                                FilteredParcelsBottomSheet(
                                  filteredEndDate: filteredEndDate!,
                                  filteredStartDate: filteredStartDate!,
                                  filteredTypeParcel: filteredTypeParcel!,
                                  filteredCallback: (type, startDate, endDate) {
                                    filteredCallback!
                                        .call(type, startDate, endDate);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        color: theme.black,
                        width: 15,
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 15,
                ),
              )
          ],
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              PageManager.read(context)
                  .push(ProfilePage.page(), rootNavigator: true);
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: theme.extraLightGrey,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SvgPicture.asset(
                  'assets/icons/person.svg',
                  color: theme.white,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: theme.text20Semibold,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }
}
