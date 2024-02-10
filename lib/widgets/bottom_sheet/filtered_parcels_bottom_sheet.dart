import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:topparcel/helpers/utils/date_utils.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';

class FilteredParcelsBottomSheet extends StatefulWidget {
  const FilteredParcelsBottomSheet({
    super.key,
    required this.filteredTypeParcel,
    required this.filteredStartDate,
    required this.filteredEndDate,
    required this.filteredCallback,
  });

  final String filteredTypeParcel;
  final DateTime filteredStartDate;
  final DateTime filteredEndDate;
  final Function(String, DateTime, DateTime) filteredCallback;

  @override
  State<FilteredParcelsBottomSheet> createState() =>
      _FilteredParcelsBottomSheetState();
}

class _FilteredParcelsBottomSheetState
    extends State<FilteredParcelsBottomSheet> {
  String filteredTypeParcel = 'All';

  DateTime filteredStartDate = DateTime.now();
  DateTime filteredEndDate = DateTime.now();

  bool isShowDatePicker = false;
  bool isStartPicker = false;

  @override
  void initState() {
    filteredEndDate = widget.filteredEndDate;
    filteredStartDate = widget.filteredStartDate;
    filteredTypeParcel = widget.filteredTypeParcel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // decoration: BoxDecoration(
          //   border: Border(
          //     left: BorderSide(color: Colors.red),
          //     right: BorderSide(color: Colors.red),
          //   ),
          // ),
          // color: Colors.red,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Show first',
                  style: theme.header16Bold,
                ),
                SizedBox(
                  height: 20,
                ),
                _filteredTypeParcel(theme),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  color: theme.disableButtonColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Date',
                  style: theme.header16Bold,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _date(
                      theme,
                      CustomDateUtils().dateForFiltere(filteredStartDate),
                      'Start date',
                      () {
                        setState(() {
                          isShowDatePicker = !isShowDatePicker;
                          isStartPicker = true;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'to',
                        style: theme.text14Regular,
                      ),
                    ),
                    _date(
                      theme,
                      CustomDateUtils().dateForFiltere(filteredEndDate),
                      'End date',
                      () {
                        setState(() {
                          isShowDatePicker = !isShowDatePicker;
                          isStartPicker = false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  widht: MediaQuery.of(context).size.width - 40,
                  title: 'Show',
                  onTap: () {
                    widget.filteredCallback.call(
                        filteredTypeParcel, filteredStartDate, filteredEndDate);
                  },
                  status: ButtonStatus.primary,
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  highlightColor: theme.white,
                  focusColor: theme.white,
                  splashColor: theme.white,
                  overlayColor: MaterialStateProperty.all(theme.white),
                  onTap: () {
                    setState(() {
                      filteredTypeParcel = 'All';
                      filteredStartDate = DateTime.now();
                      filteredEndDate = DateTime.now().add(
                        Duration(
                          days: CustomDateUtils().countDayInMonth(
                              DateTime.now().month, DateTime.now().year),
                        ),
                      );
                    });
                    widget.filteredCallback.call(filteredTypeParcel,
                        filteredStartDate, filteredStartDate);
                  },
                  child: Center(
                    child: Text(
                      'Reset all',
                      style: theme.text14Regular.copyWith(
                        color: theme.lightGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (isShowDatePicker)
          Positioned(
            left: isStartPicker ? 20 : 80,
            bottom: 210,
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: theme.black.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SfDateRangePicker(
                headerHeight: 48,
                backgroundColor: theme.backgroundPrimary,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    if (args.value is PickerDateRange) {
                      filteredStartDate = args.value.startDate;
                      if (args.value.endDate != null)
                        filteredEndDate = args.value.endDate;
                    }
                  });
                },
                selectionMode: DateRangePickerSelectionMode.range,
                selectionTextStyle: const TextStyle(color: Colors.white),
                todayHighlightColor: theme.black,
                startRangeSelectionColor: theme.primaryColor,
                endRangeSelectionColor: theme.primaryColor,
                rangeSelectionColor: theme.orangeColor.withOpacity(0.3),
                rangeTextStyle: theme.text14Regular,
                monthCellStyle: DateRangePickerMonthCellStyle(
                  todayTextStyle: theme.text14Regular,
                ),
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: theme.primaryColor,
                  textStyle: theme.text14Regular.copyWith(color: theme.white),
                ),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  viewHeaderHeight: 32,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle:
                        theme.text14Regular.copyWith(color: theme.darkGrey),
                  ),
                ),
                initialSelectedRange:
                    PickerDateRange(filteredStartDate, filteredEndDate),
              ),
            ),
          )
      ],
    );
  }

  Widget _date(UIThemes theme, String date, String title, Function() onTab) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.text14Regular,
        ),
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {
            onTab.call();
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 82) / 2,
            height: 44,
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: theme.black.withOpacity(0.08),
                  spreadRadius: 1,
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    date,
                    style: theme.text14Regular,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filteredTypeParcel(UIThemes theme) {
    return Column(
      children: [
        _filteredTypeParcelCell(
          theme,
          'All',
          filteredTypeParcel == 'All',
          () {
            setState(() {
              filteredTypeParcel = 'All';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Cancelled',
          filteredTypeParcel == 'Cancelled',
          () {
            setState(() {
              filteredTypeParcel = 'Cancelled';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Ready',
          filteredTypeParcel == 'Ready',
          () {
            setState(() {
              filteredTypeParcel = 'Ready';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Pending',
          filteredTypeParcel == 'Pending',
          () {
            setState(() {
              filteredTypeParcel = 'Pending';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Accept',
          filteredTypeParcel == 'Accept',
          () {
            setState(() {
              filteredTypeParcel = 'Accept';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Collected',
          filteredTypeParcel == 'Collected',
          () {
            setState(() {
              filteredTypeParcel = 'Collected';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'HUB Sorting',
          filteredTypeParcel == 'HUB Sorting',
          () {
            setState(() {
              filteredTypeParcel = 'HUB Sorting';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'In transit EU',
          filteredTypeParcel == 'In transit EU',
          () {
            setState(() {
              filteredTypeParcel = 'In transit EU';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Exported',
          filteredTypeParcel == 'Exported',
          () {
            setState(() {
              filteredTypeParcel = 'Exported';
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeParcelCell(
          theme,
          'Delivered',
          filteredTypeParcel == 'Delivered',
          () {
            setState(() {
              filteredTypeParcel = 'Delivered';
            });
          },
        ),
      ],
    );
  }

  Widget _filteredTypeParcelCell(
      UIThemes theme, String title, bool isSelecte, Function onTap) {
    return InkWell(
      highlightColor: theme.white,
      focusColor: theme.white,
      splashColor: theme.white,
      overlayColor: MaterialStateProperty.all(theme.white),
      onTap: () {
        onTap.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.text14Regular,
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelecte ? theme.primaryColor : theme.lightGrey,
                width: 3,
              ),
            ),
            child: isSelecte
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
