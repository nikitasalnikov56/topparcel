import 'package:flutter/material.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: PrivacyPolicyView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/privacy_policy_view';
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Privacy Policy',
        ),
      ),
    );
  }
}
