import 'package:flutter/material.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: TermsOfUseView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/terms_of_use_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Terms of Use',
        ),
      ),
    );
  }
}
