import 'package:flutter/material.dart';

import '../../../helpers/utils/ui_themes.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/buttons/default_button.dart';

enum StatusParcel { EN, RU, IT, FR, DAN, EST, POL }

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: LanguageView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/language_view';
}

class _LanguageViewState extends State<LanguageView> {
  final theme = UIThemes();
  bool isSelecte = false;

  StatusParcel filteredTypeParcel = StatusParcel.EN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'Language',
          ),
        ),
        body: Column(
          children: [
            Container(
              color: theme.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: _listTypesLanguage(theme),
              ),
            ),
            // Expanded(child: Container()),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: DefaultButton(
                widht: MediaQuery.of(context).size.width,
                title: 'Save',
                onTap: () {
                  // validation
                  // request
                },
                status: ButtonStatus.primary,
              ),
            ),
          ],
        ));
  }

  Widget _listTypesLanguage(UIThemes theme) {
    return Column(
      children: [
        _filteredTypeLanguageCell(
          theme,
          'English',
          filteredTypeParcel == StatusParcel.EN,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.EN;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'Русский',
          filteredTypeParcel == StatusParcel.RU,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.RU;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'Italian',
          filteredTypeParcel == StatusParcel.IT,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.IT;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'French',
          filteredTypeParcel == StatusParcel.FR,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.FR;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'Danish',
          filteredTypeParcel == StatusParcel.DAN,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.DAN;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'Estonian',
          filteredTypeParcel == StatusParcel.EST,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.EST;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        _filteredTypeLanguageCell(
          theme,
          'Polish',
          filteredTypeParcel == StatusParcel.POL,
          () {
            setState(() {
              filteredTypeParcel = StatusParcel.POL;
            });
          },
        ),
      ],
    );
  }

  Widget _filteredTypeLanguageCell(
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
