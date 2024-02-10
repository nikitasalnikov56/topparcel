import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/navigation/page_manager.dart';

class NavigatorDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  NavigatorDelegate({required this.navigatorCubit, this.navigationTab});

  final PageManager navigatorCubit;
  final TabsList? navigationTab;
  bool _preventPop = false;

  void allowPop() {
    _preventPop = false;
  }

  void preventPop() {
    _preventPop = true;
  }

  @override
  Future<bool> popRoute() async {
    switch (navigationTab) {
      case null:
        if (navigatorCubit.state.rootPages.length > 1) {
          if (!_preventPop) {
            navigatorCubit.pop(rootNavigator: true);
          } else {
            notifyListeners();
          }
          return SynchronousFuture<bool>(true);
        }
        return SynchronousFuture<bool>(false);
      case TabsList.parcels:
        if (navigatorCubit.state.parcelsPages.length > 1) {
          navigatorCubit.pop();
          return SynchronousFuture<bool>(true);
        }
        return SynchronousFuture<bool>(false);
      case TabsList.trackParcel:
        if (navigatorCubit.state.trackParcelPages.length > 1) {
          navigatorCubit.pop();
          return SynchronousFuture<bool>(true);
        }
        return SynchronousFuture<bool>(false);
      case TabsList.cart:
        if (navigatorCubit.state.cartPages.length > 1) {
          navigatorCubit.pop();
          return SynchronousFuture<bool>(true);
        }
        return SynchronousFuture<bool>(false);
      case TabsList.settings:
        if (navigatorCubit.state.settingsPages.length > 1) {
          navigatorCubit.pop();
          return SynchronousFuture<bool>(true);
        }
        return SynchronousFuture<bool>(false);
    }
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return SynchronousFuture<void>(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey {
    switch (navigationTab) {
      case null:
        return navigatorCubit.rootNavigatorKey;
      case TabsList.parcels:
        return navigatorCubit.parcelsNavigationKey;
      case TabsList.trackParcel:
        return navigatorCubit.trackParcelNavigationKey;
      case TabsList.cart:
        return navigatorCubit.cartNavigationKey;
      case TabsList.settings:
        return navigatorCubit.settingsNavigationKey;
    }
  }

  List<Page<dynamic>> definePages(BuildContext context) {
    switch (navigationTab) {
      case null:
        return context.watch<PageManager>().state.rootPages;
      case TabsList.parcels:
        return context.watch<PageManager>().state.parcelsPages;
      case TabsList.trackParcel:
        return context.watch<PageManager>().state.trackParcelPages;
      case TabsList.cart:
        return context.watch<PageManager>().state.cartPages;
      case TabsList.settings:
        return context.watch<PageManager>().state.settingsPages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: definePages(context),
      onPopPage: (Route<dynamic> route, dynamic result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        PageManager.read(context).pop(rootNavigator: true);
        return true;
      },
    );
  }
}
