import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:topparcel/pages/cart/cart_page.dart';
import 'package:topparcel/pages/parcels/parcels_page.dart';
import 'package:topparcel/pages/settings/settings_page.dart';
import 'package:topparcel/pages/splash/splash_page.dart';
import 'package:topparcel/pages/track_parcel/track_parcel_page.dart';

enum TabsList { parcels, trackParcel, cart, settings }

class PageManager extends Cubit<PageManagerState> {
  PageManager() : super(PageManagerState.initial());

  GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> parcelsNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> trackParcelNavigationKey =
      GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> cartNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> settingsNavigationKey = GlobalKey<NavigatorState>();

  static PageManager read(BuildContext context) => context.read<PageManager>();
  static PageManager watch(BuildContext context) =>
      context.watch<PageManager>();

  Page<dynamic> whatIsTheLastPage({bool? rootNavigator}) {
    List<Page<dynamic>> pages;
    if (rootNavigator == true) {
      pages = [...state.rootPages];
      return pages.last;
    }

    switch (state.activeTab) {
      case TabsList.parcels:
        pages = [...state.parcelsPages];
        return pages.last;
      case TabsList.trackParcel:
        pages = [...state.trackParcelPages];
        return pages.last;
      case TabsList.cart:
        pages = [...state.cartPages];
        return pages.last;
      case TabsList.settings:
        pages = [...state.settingsPages];
        return pages.last;
    }
  }

  bool canPop({bool? rootNavigator}) {
    List<Page<dynamic>> pages;
    if (rootNavigator == true) {
      pages = [...state.rootPages];
      return pages.length > 1;
    }

    switch (state.activeTab) {
      case TabsList.parcels:
        pages = [...state.parcelsPages];
        return pages.length > 1;
      case TabsList.trackParcel:
        pages = [...state.trackParcelPages];
        return pages.length > 1;
      case TabsList.cart:
        pages = [...state.cartPages];
        return pages.length > 1;
      case TabsList.settings:
        pages = [...state.settingsPages];
        return pages.length > 1;
    }
  }

  push(Page page, {bool? rootNavigator = true}) {
    List<Page<dynamic>> pages;
    if (rootNavigator == true) {
      pages = [...state.rootPages];
      if (pages.last != page) {
        pages.add(
          page,
        );
        emit(state.copyWith(rootPages: pages));
      }
    } else {
      switch (state.activeTab) {
        case TabsList.parcels:
          pages = [...state.parcelsPages];
          if (pages.last != page) {
            pages.add(
              page,
            );
            emit(state.copyWith(parcelsPages: pages));
          }

          break;
        case TabsList.trackParcel:
          pages = [...state.trackParcelPages];
          if (pages.last != page) {
            pages.add(
              page,
            );
            emit(state.copyWith(trackParcelPages: pages));
          }
          break;
        case TabsList.cart:
          pages = [...state.cartPages];
          if (pages.last != page) {
            pages.add(
              page,
            );
            emit(state.copyWith(cartPages: pages));
          }

          break;
        case TabsList.settings:
          pages = [...state.settingsPages];
          if (pages.last != page) {
            pages.add(
              page,
            );
            emit(state.copyWith(settingsPages: pages));
          }

          break;
      }
    }
  }

  popToFirstPage({bool? result, bool? rootNavigator}) {
    List<Page<dynamic>> pages;
    if (rootNavigator == true) {
      pages = [...state.rootPages];
      do {
        pages.removeLast();
      } while (pages.length > 1);
      emit(state.copyWith(rootPages: pages));
      return;
    }

    switch (state.activeTab) {
      case TabsList.parcels:
        pages = [...state.parcelsPages];

        do {
          pages.removeLast();
        } while (pages.length > 1);
        if (pages.isEmpty) return;
        emit(state.copyWith(parcelsPages: pages));
        return;
      case TabsList.trackParcel:
        pages = [...state.trackParcelPages];
        do {
          pages.removeLast();
        } while (pages.length > 1);
        if (pages.isEmpty) return;
        emit(state.copyWith(trackParcelPages: pages));
        return;
      case TabsList.cart:
        pages = [...state.cartPages];
        do {
          pages.removeLast();
        } while (pages.length > 1);
        if (pages.isEmpty) return;
        emit(state.copyWith(cartPages: pages));
        return;
      case TabsList.settings:
        pages = [...state.settingsPages];
        do {
          pages.removeLast();
        } while (pages.length > 1);
        if (pages.isEmpty) return;
        emit(state.copyWith(settingsPages: pages));
        return;
    }
  }

  pop({dynamic result, bool? rootNavigator}) {
    List<Page<dynamic>> pages;
    if (rootNavigator == true) {
      pages = [...state.rootPages];
      pages.removeLast();
      emit(state.copyWith(rootPages: pages));

      return result;
    }

    switch (state.activeTab) {
      case TabsList.parcels:
        pages = [...state.parcelsPages];
        pages.removeLast();
        if (pages.isEmpty) return;
        emit(state.copyWith(parcelsPages: pages));
        return;
      case TabsList.trackParcel:
        pages = [...state.trackParcelPages];
        pages.removeLast();
        if (pages.isEmpty) return;
        emit(state.copyWith(trackParcelPages: pages));
        return;
      case TabsList.cart:
        pages = [...state.cartPages];
        pages.removeLast();
        if (pages.isEmpty) return;
        emit(state.copyWith(cartPages: pages));
        return;
      case TabsList.settings:
        pages = [...state.settingsPages];
        pages.removeLast();
        if (pages.isEmpty) return;
        emit(state.copyWith(settingsPages: pages));
        return;
    }
  }

  clearStackAndPushPage(Page page, {bool? rootNavigator}) {
    if (rootNavigator == true) {
      emit(state.copyWith(rootPages: [page]));
      return;
    }

    switch (state.activeTab) {
      case TabsList.parcels:
        emit(state.copyWith(parcelsPages: [page]));
        return;
      case TabsList.trackParcel:
        emit(state.copyWith(trackParcelPages: [page]));
        return;
      case TabsList.cart:
        emit(state.copyWith(cartPages: [page]));
        return;
      case TabsList.settings:
        emit(state.copyWith(settingsPages: [page]));
        return;
    }
  }

  changeTab(TabsList tab) {
    if (tab == state.activeTab) {
      popToFirstPage();
      return;
    }
    emit(state.copyWith(activeTab: tab));
  }
}

class PageManagerState {
  final List<Page<dynamic>> _rootPages;
  final List<Page<dynamic>> _parcelsPages;
  final List<Page<dynamic>> _trackParcelPages;
  final List<Page<dynamic>> _cartPages;
  final List<Page<dynamic>> _settingsPages;

  final TabsList activeTab;
  bool get canPopRoot => _rootPages.length > 1;
  List<Page<dynamic>> get rootPages => List.unmodifiable(_rootPages);
  List<Page<dynamic>> get parcelsPages => List.unmodifiable(_parcelsPages);
  List<Page<dynamic>> get trackParcelPages =>
      List.unmodifiable(_trackParcelPages);
  List<Page<dynamic>> get cartPages => List.unmodifiable(_cartPages);
  List<Page<dynamic>> get settingsPages => List.unmodifiable(_settingsPages);

  PageManagerState({
    required List<Page<dynamic>> rootPages,
    required List<Page<dynamic>> parcelsPages,
    required List<Page<dynamic>> trackParcelPages,
    required List<Page<dynamic>> cartPages,
    required List<Page<dynamic>> settingsPages,
    this.activeTab = TabsList.parcels,
  })  : _rootPages = rootPages,
        _parcelsPages = parcelsPages,
        _trackParcelPages = trackParcelPages,
        _cartPages = cartPages,
        _settingsPages = settingsPages;

  factory PageManagerState.initial() {
    return PageManagerState(
        rootPages: [SplashPage.page()],
        parcelsPages: [ParcelsPage.page()],
        trackParcelPages: [TrackParcelPage.page()],
        cartPages: [CartPage.page()],
        settingsPages: [SettingsPage.page()]);
  }

  PageManagerState copyWith({
    List<Page<dynamic>>? rootPages,
    List<Page<dynamic>>? parcelsPages,
    List<Page<dynamic>>? trackParcelPages,
    List<Page<dynamic>>? cartPages,
    List<Page<dynamic>>? settingsPages,
    TabsList? activeTab,
  }) {
    return PageManagerState(
      rootPages: rootPages ?? _rootPages,
      parcelsPages: parcelsPages ?? _parcelsPages,
      trackParcelPages: trackParcelPages ?? _trackParcelPages,
      cartPages: cartPages ?? _cartPages,
      settingsPages: settingsPages ?? _settingsPages,
      activeTab: activeTab ?? this.activeTab,
    );
  }
}
