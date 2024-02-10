import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';

import '../../data/models/response/fetch_country_response.dart';
import '../../data/models/response/tracking_number_response.dart';

class TrackParcelDetailsPage extends StatefulWidget {
  const TrackParcelDetailsPage({super.key});

  @override
  State<TrackParcelDetailsPage> createState() => _TrackParcelDetailsPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: TrackParcelDetailsPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/track_parcel_details_page';
}

class _TrackParcelDetailsPageState extends State<TrackParcelDetailsPage> {
  bool isShowDetails = false;

  List<bool> currentStatus = [false, false, false, false, false];
  List<bool> doneStatus = [false, false, false, false, false];
  String countryAccepted = '';
  String countryCollected = '';
  String countryInTransit = '';
  String countryCustomsClearance = '';
  String countryDelivered = '';

  void _updateStatus(List<Event> listEvents, List<Country> listCountry) {
    if (listEvents
        .where((element) => element.status.contains('Accepted'))
        .toList()
        .isNotEmpty) {
      final findEvent = listEvents
          .where((element) => element.status.contains('Accepted'))
          .toList()[0];
      if (listCountry
          .where((element) => element.code == findEvent.countryCode)
          .toList()
          .isNotEmpty) {
        countryAccepted = listCountry
            .where((element) => element.code == findEvent.countryCode)
            .toList()[0]
            .name;
      }
      currentStatus[0] = true;
    }
    if (listEvents
        .where((element) => element.status.contains('Collected'))
        .toList()
        .isNotEmpty) {
      final findEvent = listEvents
          .where((element) => element.status.contains('Collected'))
          .toList()[0];
      if (listCountry
          .where((element) => element.code == findEvent.countryCode)
          .toList()
          .isNotEmpty) {
        countryCollected = listCountry
            .where((element) => element.code == findEvent.countryCode)
            .toList()[0]
            .name;
      }
      currentStatus[0] = false;
      doneStatus[0] = true;
      currentStatus[1] = true;
    }
    if (listEvents
        .where((element) => element.status.contains('In transit'))
        .toList()
        .isNotEmpty) {
      final findEvent = listEvents
          .where((element) => element.status.contains('In transit'))
          .toList()[0];
      if (listCountry
          .where((element) => element.code == findEvent.countryCode)
          .toList()
          .isNotEmpty) {
        countryInTransit = listCountry
            .where((element) => element.code == findEvent.countryCode)
            .toList()[0]
            .name;
      }
      currentStatus[0] = false;
      doneStatus[0] = true;
      currentStatus[1] = false;
      doneStatus[1] = true;
      currentStatus[2] = true;
    }
    if (listEvents
        .where((element) => element.status.contains('Customs clearance'))
        .toList()
        .isNotEmpty) {
      final findEvent = listEvents
          .where((element) => element.status.contains('Customs clearance'))
          .toList()[0];
      if (listCountry
          .where((element) => element.code == findEvent.countryCode)
          .toList()
          .isNotEmpty) {
        countryCustomsClearance = listCountry
            .where((element) => element.code == findEvent.countryCode)
            .toList()[0]
            .name;
      }
      currentStatus[0] = false;
      doneStatus[0] = true;
      currentStatus[1] = false;
      doneStatus[1] = true;
      currentStatus[2] = false;
      doneStatus[2] = true;
      currentStatus[3] = true;
    }
    if (listEvents
        .where((element) => element.status.contains('Delivered'))
        .toList()
        .isNotEmpty) {
      final findEvent = listEvents
          .where((element) => element.status.contains('Delivered'))
          .toList()[0];
      if (listCountry
          .where((element) => element.code == findEvent.countryCode)
          .toList()
          .isNotEmpty) {
        countryDelivered = listCountry
            .where((element) => element.code == findEvent.countryCode)
            .toList()[0]
            .name;
      }
      currentStatus[0] = false;
      doneStatus[0] = true;
      currentStatus[1] = false;
      doneStatus[1] = true;
      currentStatus[2] = false;
      doneStatus[2] = true;
      currentStatus[3] = false;
      doneStatus[3] = true;
      currentStatus[4] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final trackParcelState = TrackParcelCubit.watchState(context);
    final parcelState = ParcelsCubit.watchState(context);
    _updateStatus(trackParcelState.eventsList, parcelState.countriesList);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Track parcel',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Tracking timeline and details',
                    style: theme.header14Semibold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Keep track of your package delivery with timeline and tracking details',
                    style: theme.text14Regular,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              color: theme.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InkWell(
                      highlightColor: theme.white,
                      focusColor: theme.white,
                      splashColor: theme.white,
                      overlayColor: MaterialStateProperty.all(theme.white),
                      onTap: () {
                        setState(() {
                          isShowDetails = !isShowDetails;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tracking details',
                            style: theme.header16Bold,
                          ),
                          SvgPicture.asset(
                            isShowDetails
                                ? 'assets/icons/arrow_up.svg'
                                : 'assets/icons/arrow_down.svg',
                            color: theme.grey,
                          )
                        ],
                      ),
                    ),
                    if (isShowDetails) ...[
                      SizedBox(
                        height: 13,
                      ),
                      _detailsInformationCell(
                          theme,
                          'Date',
                          DateFormat('dd.MM.yyyy').format(
                              trackParcelState.eventsList.first.dateCreate)),
                      _detailsInformationCell(
                          theme,
                          'Country (From)',
                          parcelState.countriesList
                                  .where((element) =>
                                      element.code ==
                                          trackParcelState
                                              .eventsList.first.countryCode ||
                                      element.code2 ==
                                          trackParcelState
                                              .eventsList.first.countryCode)
                                  .toList()
                                  .isNotEmpty
                              ? parcelState.countriesList
                                  .where((element) =>
                                      element.code ==
                                          trackParcelState
                                              .eventsList.first.countryCode ||
                                      element.code2 ==
                                          trackParcelState
                                              .eventsList.first.countryCode)
                                  .toList()[0]
                                  .name
                              : ''),
                      // _detailsInformationCell(theme, 'Adress (From)',
                      //     trackParcelState.eventsList.first.address),
                      _detailsInformationCell(
                          theme,
                          'Country (To)',
                          parcelState.countriesList
                                  .where((element) =>
                                      element.code ==
                                          trackParcelState
                                              .eventsList.last.countryCode ||
                                      element.code2 ==
                                          trackParcelState
                                              .eventsList.last.countryCode)
                                  .toList()
                                  .isNotEmpty
                              ? parcelState.countriesList
                                  .where((element) =>
                                      element.code ==
                                          trackParcelState
                                              .eventsList.last.countryCode ||
                                      element.code2 ==
                                          trackParcelState
                                              .eventsList.last.countryCode)
                                  .toList()[0]
                                  .name
                              : ''),
                      _detailsInformationCell(theme, 'Adress (To)',
                          trackParcelState.eventsList.last.address),
                      _detailsInformationCell(theme, 'Status',
                          trackParcelState.eventsList.last.status,
                          isStatus: true),
                      _detailsInformationCell(theme, 'Parcel weight', '5 kg'),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: _colorBackgroundStatus(theme, 'Updated...'),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 24),
                      child: Text(
                        _lastUpdateToString(
                            trackParcelState.eventsList.last.dateCreate),
                        style: theme.text14Regular.copyWith(
                          color: _colorTextStatus(
                            theme,
                            'Updated...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Way',
                      style: theme.header14Bold,
                    ),
                  ),
                  _wayWidgetCell(theme, 'Delivered', countryDelivered,
                      currentStatus[4], doneStatus[4]),
                  _wayWidgetCell(theme, 'Customs clearance',
                      countryCustomsClearance, currentStatus[3], doneStatus[3]),
                  _wayWidgetCell(theme, 'In transit', countryInTransit,
                      currentStatus[2], doneStatus[2]),
                  _wayWidgetCell(theme, 'Collected', countryCollected,
                      currentStatus[1], doneStatus[1]),
                  _wayWidgetCell(theme, 'Accepted', countryAccepted,
                      currentStatus[0], doneStatus[0],
                      isLast: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _lastUpdateToString(DateTime lastUpdateDate) {
    String result = 'Updated ';
    Duration difference = DateTime.now().difference(lastUpdateDate);

    if (difference.inDays > 0) {
      result += '${difference.inDays} days ';
    }
    result += '${difference.inHours - (difference.inDays * 24)} hours';

    return result;
  }

  Widget _wayWidgetCell(UIThemes theme, String status, String country,
      bool isCurrent, bool isDone,
      {bool isLast = false}) {
    return Row(
      children: [
        SizedBox(
          height: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isCurrent
                      ? theme.primaryColor
                      : isDone
                          ? theme.grey
                          : theme.extraLightGrey,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 50,
                  color: theme.grey,
                ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        SizedBox(
          height: 66,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                status,
                style: theme.header14Semibold,
              ),
              Text(
                country,
                style: theme.text14Regular.copyWith(color: theme.lightGrey),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailsInformationCell(
      UIThemes theme, String title, String description,
      {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.text14Regular.copyWith(color: theme.lightGrey),
          ),
          if (!isStatus)
            Text(
              description,
              style: theme.text14Regular,
            )
          else
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: _colorBackgroundStatus(theme, description),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                child: Text(
                  description,
                  style: theme.text14Regular
                      .copyWith(color: _colorTextStatus(theme, description)),
                ),
              ),
            )
        ],
      ),
    );
  }

  Color _colorTextStatus(UIThemes theme, String status) {
    switch (status) {
      case 'Accepted':
        return theme.acceptedStatus;
      case 'Collected':
        return theme.collectedStatus;
      case 'Hub sorting':
        return theme.hubSortingStatus;
      case 'Pending':
        return theme.pendingStatus;
      case 'In Transit':
        return theme.transitStatus;
      case 'Exported':
        return theme.exportedStatus;
      case 'Delivered':
        return theme.deliveredStatus;
      case 'Ready':
        return theme.readyStatus;
      case 'Draft':
        return theme.draftStatus;
      case 'Cancelled':
        return theme.cancelledStatus;
      case 'Need a printer':
        return theme.primaryColor;
      case 'Updated...':
        return theme.lastUpdateStatus;
      default:
        return theme.primaryColor;
    }
  }

  Color _colorBackgroundStatus(UIThemes theme, String status) {
    switch (status) {
      case 'Accepted':
        return theme.acceptedStatus.withOpacity(0.2);
      case 'Collected':
        return theme.collectedStatus.withOpacity(0.2);
      case 'Hub sorting':
        return theme.hubSortingStatus.withOpacity(0.2);
      case 'Pending':
        return theme.pendingStatus.withOpacity(0.2);
      case 'In Transit':
        return theme.transitStatus.withOpacity(0.2);
      case 'Exported':
        return theme.exportedStatus.withOpacity(0.2);
      case 'Delivered':
        return theme.deliveredStatus.withOpacity(0.2);
      case 'Ready':
        return theme.readyStatus.withOpacity(0.2);
      case 'Draft':
        return theme.draftStatus.withOpacity(0.2);
      case 'Cancelled':
        return theme.cancelledStatus.withOpacity(0.2);
      case 'Need a printer':
        return theme.primaryColor.withOpacity(0.2);
      case 'Updated...':
        return theme.lastUpdateStatus.withOpacity(0.2);
      default:
        return theme.primaryColor.withOpacity(0.2);
    }
  }
}
