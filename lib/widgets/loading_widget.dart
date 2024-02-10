import 'package:flutter/material.dart';

import '../helpers/utils/ui_themes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.withBluredBackground = false,
    this.alignment = Alignment.center,
    this.text,
    this.color,
  });

  final String? text;
  final Alignment alignment;
  final Color? color;
  final bool withBluredBackground;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: alignment,
            child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: color ?? theme.orangeColor)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
