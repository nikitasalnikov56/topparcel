import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/enums/enums.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/global/cubits/bottom_sheet_cubit.dart';

import '../../navigation/navigation_delegate.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/bottom_bar/bottom_bar.dart';
import '../login/login_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: AppPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/root_app_page';
}

class _AppPageState extends State<AppPage> {
  late RouterDelegate parcelsNavigationDelegate;
  late RouterDelegate trackParcelNavigationDelegate;
  late RouterDelegate cartNavigationDelegate;
  late RouterDelegate settingsNavigationDelegate;

  @override
  initState() {
    parcelsNavigationDelegate = NavigatorDelegate(
      navigatorCubit: PageManager.read(context),
      navigationTab: TabsList.parcels,
    );

    trackParcelNavigationDelegate = NavigatorDelegate(
      navigatorCubit: PageManager.read(context),
      navigationTab: TabsList.trackParcel,
    );

    cartNavigationDelegate = NavigatorDelegate(
      navigatorCubit: PageManager.read(context),
      navigationTab: TabsList.cart,
    );

    settingsNavigationDelegate = NavigatorDelegate(
      navigatorCubit: PageManager.read(context),
      navigationTab: TabsList.settings,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = context
        .select((PageManager pageManager) => pageManager.state.activeTab);
    context.select((PageManager pageManager) {
      switch (activeTab) {
        case TabsList.parcels:
          return pageManager.state.parcelsPages.last;
        case TabsList.trackParcel:
          return pageManager.state.trackParcelPages.last;
        case TabsList.cart:
          return pageManager.state.cartPages.last;
        case TabsList.settings:
          return pageManager.state.settingsPages.last;
      }
    });
    return BlocListener<AppMessageCubit, AppMessageState>(
      listener: (context, state) {
        if (state.messageType == MessageType.system) {
          for (var message in state.systemMessages) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                builder: (cntxt) {
                  return const Wrap(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                      //   child: HtmlWidget(
                      //     message.detailHtml,
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            );
          }
        }
      },
      child: BlocListener<BottomSheetCubit, BottomSheetState>(
        listener: (context, state) {
          if (state.status is ModalBottomSheetStatus) {
            showModalBottomSheet(
              context: context,
              builder: (context) => Wrap(
                children: [
                  (state.status as ModalBottomSheetStatus).bottomSheetWidget
                ],
              ),
            );
          }
        },
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status is UnauthorisedStatus) {
              PageManager.read(context).changeTab(TabsList.parcels);
              PageManager.read(context)
                  .clearStackAndPushPage(LoginPage.page(), rootNavigator: true);
              PageManager.read(context)
                  .clearStackAndPushPage(LoginPage.page(), rootNavigator: true);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      TabView(
                        active: activeTab == TabsList.parcels,
                        navigatorDelegate: parcelsNavigationDelegate,
                      ),
                      TabView(
                        active: activeTab == TabsList.trackParcel,
                        navigatorDelegate: trackParcelNavigationDelegate,
                      ),
                      TabView(
                        active: activeTab == TabsList.cart,
                        navigatorDelegate: cartNavigationDelegate,
                      ),
                      TabView(
                        active: activeTab == TabsList.settings,
                        navigatorDelegate: settingsNavigationDelegate,
                      ),
                    ],
                  ),
                ),
                BottomTabBar(
                  activeTab: activeTab,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabView extends StatelessWidget {
  const TabView({
    Key? key,
    required this.active,
    required this.navigatorDelegate,
  }) : super(key: key);
  final bool active;
  final RouterDelegate navigatorDelegate;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !active,
      child: TickerMode(
        enabled: active,
        child: Router(
          routerDelegate: navigatorDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
