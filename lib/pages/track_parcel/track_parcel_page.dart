import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/global/cubits/track_parcel_cubit.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/track_parcel/track_parcel_details_page.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:topparcel/widgets/text_field/default_text_field.dart';

import '../../widgets/app_bar/main_app_bar.dart';

class TrackParcelPage extends StatefulWidget {
  const TrackParcelPage({super.key});

  @override
  State<TrackParcelPage> createState() => _TrackParcelPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: TrackParcelPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/track_parcel_page';
}

class _TrackParcelPageState extends State<TrackParcelPage> {
  TextEditingController _trackNumberController = TextEditingController();

  String errorMessageTrack = '';

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrackParcelCubit, TrackParcelState>(
      listener: (context, state) {
        if (state.status is OkTrackParcelStatus) {
          _trackNumberController.text = '';
          PageManager.read(context)
              .push(TrackParcelDetailsPage.page(), rootNavigator: true);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: MainAppBar(
              title: 'Track parcel',
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  DefaultTextField(
                    controller: _trackNumberController,
                    title: 'Tracking number',
                    onChanged: () {
                      setState(() {});
                    },
                    errorMessage: errorMessageTrack,
                    placeholder: 'Enter your tracking number',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    widht: MediaQuery.of(context).size.width - 40,
                    title: 'Next step',
                    onTap: () {
                      _validate();
                      if (!isError) {
                        TrackParcelCubit.read(context)
                            .trackingNumber(_trackNumberController.text);
                      }
                    },
                    status: _trackNumberController.text.isEmpty
                        ? ButtonStatus.disable
                        : ButtonStatus.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validate() {
    setState(() {
      errorMessageTrack = '';
      isError = false;

      if (_trackNumberController.text.length < 5) {
        errorMessageTrack =
            'Incorrect tracking number, it may contain letters and numbers and be 5-10 characters long';
        isError = true;
      }
    });
  }
}
