import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:topparcel/data/enums/enums.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/global/cubits/auth_cubit.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/login/login_page.dart';
import 'package:topparcel/widgets/app_message_manager_widget/Info_toast.dart';
import 'package:topparcel/widgets/app_message_manager_widget/error_toast.dart';

class AppMessageManagerWidget extends StatefulWidget {
  const AppMessageManagerWidget({super.key, required this.child});

  final Widget child;

  @override
  State<AppMessageManagerWidget> createState() =>
      _AppMessageManagerWidgetState();
}

class _AppMessageManagerWidgetState extends State<AppMessageManagerWidget> {
  late FToast toast;

  @override
  void initState() {
    toast = FToast();
    toast.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMessageCubit, AppMessageState>(
      listener: (context, state) {
        log(state.message);
        toast.removeQueuedCustomToasts();
        if (state.message == 'Wrong password') {
          PageManager.read(context).changeTab(TabsList.parcels);
          AuthCubit.read(context).logout();
          PageManager.read(context)
              .clearStackAndPushPage(LoginPage.page(), rootNavigator: true);
        } else if (state.messageType != MessageType.networkException &&
            state.messageType != MessageType.popUp &&
            state.messageType != MessageType.none &&
            state.messageType != MessageType.deauthorise &&
            state.messageType != MessageType.system &&
            state.message != '') {
          toast.showToast(
            gravity: ToastGravity.BOTTOM,
            child: state.messageType == MessageType.error
                ? ErrorToast(
                    errorMessage: state.message,
                  )
                : InfoToast(
                    message: state.message,
                  ),
            toastDuration: Duration(seconds: state.durationInSeconds),
          );
        }
      },
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0, boldText: false),
          child: state.shouldUpdateApp ? const UpdateAppWidget() : widget.child,
        );
      },
    );
  }
}

class UpdateAppWidget extends StatelessWidget {
  const UpdateAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = UIThemes.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/logo/ic_logo.svg')),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Здравствуйте!\n\nОбновите, пожалуйста, приложение, чтобы продолжить пользоваться нашими услугами!',
              textAlign: TextAlign.center,
              // style: theme.text14Regular
              //     .copyWith(color: UIThemes.of(context).textPrimaryColor),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
