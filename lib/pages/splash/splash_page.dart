import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/global/cubits/user_cubit.dart';

import '../../global/cubits/auth_cubit.dart';
import '../../global/cubits/parcels_cubit.dart';
import '../../navigation/page_manager.dart';
import '../app/app_page.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: SplashPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/splash_page';
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: AuthCubit.read(context)..checkAuthorisation(),
      listener: (context, state) {
        if (state.status is UnauthorisedStatus) {
          PageManager.read(context)
              .clearStackAndPushPage(LoginPage.page(), rootNavigator: true);
        }

        if (state.status is AuthorisedStatus) {
          ParcelsCubit.read(context).init();
          TrackParcelCubit.read(context).init();

          UserCubit.read(context).init();
          PageManager.read(context)
              .clearStackAndPushPage(AppPage.page(), rootNavigator: true);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFEA560D),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
