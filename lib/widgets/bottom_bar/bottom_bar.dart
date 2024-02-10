import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/utils/ui_themes.dart';
import '../../navigation/page_manager.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({
    Key? key,
    required this.activeTab,
  }) : super(key: key);

  final TabsList activeTab;

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  void initState() {
    _fetchCommonData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: theme.extraLightGrey,
          ),
        ),
        color: UIThemes.lightTheme().scaffoldBackgroundColor,
      ),
      child: SizedBox(
        height: bottomPadding + 56,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TabButton(
              label: 'Parcels',
              onTap: () {
                context.read<PageManager>().changeTab(TabsList.parcels);
              },
              active: widget.activeTab == TabsList.parcels,
              icon: SvgPicture.asset(
                'assets/icons/parcels.svg',
                width: 20,
                height: 20,
                color: widget.activeTab == TabsList.parcels
                    ? theme.primaryColor
                    : theme.lightGrey,
              ),
            ),
            _TabButton(
              label: 'Track parcel',
              onTap: () {
                context.read<PageManager>().changeTab(TabsList.trackParcel);
              },
              active: widget.activeTab == TabsList.trackParcel,
              icon: SvgPicture.asset(
                'assets/icons/track_parcel.svg',
                width: 20,
                height: 20,
                color: widget.activeTab == TabsList.trackParcel
                    ? theme.primaryColor
                    : theme.lightGrey,
              ),
            ),
            _TabButton(
              label: 'Cart',
              onTap: () {
                context.read<PageManager>().changeTab(TabsList.cart);
              },
              active: widget.activeTab == TabsList.cart,
              icon: SvgPicture.asset(
                'assets/icons/cart.svg',
                width: 20,
                height: 20,
                color: widget.activeTab == TabsList.cart
                    ? theme.primaryColor
                    : theme.lightGrey,
              ),
            ),
            _TabButton(
              label: 'Settings',
              onTap: () {
                context.read<PageManager>().changeTab(TabsList.settings);
              },
              active: widget.activeTab == TabsList.settings,
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: 20,
                height: 20,
                color: widget.activeTab == TabsList.settings
                    ? theme.primaryColor
                    : theme.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchCommonData(BuildContext context) {
    // Функция для подгрузки данных при первом создании Tab Bar
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton(
      {Key? key,
      required this.active,
      required this.icon,
      required this.onTap,
      required this.label})
      : super(key: key);

  final Widget icon;
  final VoidCallback onTap;
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 2,
            ),
            icon,
            const SizedBox(
              height: 4,
            ),
            Text(label,
                style: theme.text10Regular.copyWith(
                    color: active ? theme.primaryColor : theme.lightGrey)),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 2,
            ),
          ],
        ),
      ),
    );
  }
}
