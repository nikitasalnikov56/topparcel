import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/global/cubits/bottom_sheet_cubit.dart';
import 'package:topparcel/global/cubits/hscode_cubit.dart';
import 'package:topparcel/global/cubits/parcels_cubit.dart';
import 'package:topparcel/global/cubits/stripe_cubit.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';
import 'package:topparcel/helpers/constans.dart';
import 'package:topparcel/services/service_locator.dart';
import 'package:topparcel/widgets/app_message_manager_widget/app_message_manager_widget.dart';

import 'helpers/utils/ui_themes.dart';
import 'navigation/navigation_delegate.dart';
import 'navigation/page_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishKey;
  initServiceLocator();
  await sl.allReady();
  // GetIt.I.isReady<SharedPreferences>().then((_) {
  //   runApp(const AppSetup());
  // });
  GetIt.I.isReady<FlutterSecureStorage>().then((_) {
    runApp(const AppSetup());
  });
}

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => PageManager(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => BottomSheetCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AppMessageCubit(
            errorHandler: sl(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AuthCubit(
            authRepository: sl(),
            appMessageCubit: AppMessageCubit.read(_),
          )..checkAuthorisation(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => TrackParcelCubit(
            trackParcelRepository: sl(),
            emailStorage: sl(),
            appMessageCubit: AppMessageCubit.read(_),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => ParcelsCubit(
            emailStorage: sl(),
            userRepository: sl(),
            appMessageCubit: AppMessageCubit.read(_),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => UserCubit(
            userRepository: sl(),
            appMessageCubit: AppMessageCubit.read(_),
            errorHandler: sl(),
            emailStorage: sl(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => StripeCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => HscodeCubit(
            emailStorage: sl(),
            tokenStorage: sl(),
          ),
        ),
      ],
      child: const TopParcel(),
    );
  }
}

class TopParcel extends StatefulWidget {
  const TopParcel({super.key});

  @override
  State<TopParcel> createState() => _TopParcelState();
}

class _TopParcelState extends State<TopParcel> {
  late RouterDelegate rootNavigatorDelegate;

  @override
  void initState() {
    rootNavigatorDelegate = NavigatorDelegate(
      navigatorCubit: PageManager.read(context),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigatorDelegate>(
            create: (_) => rootNavigatorDelegate as NavigatorDelegate),
      ],
      builder: (context, child) {
        return MaterialApp(
          home: AppMessageManagerWidget(
            child: Router(
              routerDelegate: rootNavigatorDelegate,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          ),
          supportedLocales: const [
            Locale('en', 'EN'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          title: 'MRoad',
          theme: UIThemes.lightTheme(),
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}
