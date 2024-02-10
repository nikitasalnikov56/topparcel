import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../helpers/utils/ui_themes.dart';
import 'drop_down_overlay.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({
    super.key,
    required this.placeholder,
    required this.items,
    required this.selecteElement,
    required this.onChange,
    required this.isError,
    this.height = 44,
    this.isFixSizeDropDown = true,
    this.wight,
    this.radius = 24,
    this.leftPadding = 12,
    this.textStyleLastElement,
    this.errorMessage = '',
    this.backgroundColor,
  });

  final String placeholder;
  final List<String> items;
  final String selecteElement;
  final Function(String, int) onChange;
  final double height;
  final bool isError;
  final bool isFixSizeDropDown;
  final double? wight;
  final double radius;
  final double leftPadding;
  final TextStyle? textStyleLastElement;
  final String errorMessage;
  final Color? backgroundColor;

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  OverlayEntry? entry;
  late LayerLink layerLink;

  @override
  void initState() {
    super.initState();
    layerLink = LayerLink();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
      builder: (_) {
        if (mounted) {
          return DropdownOverlay(
            items: widget.items,
            size: size,
            layerLink: layerLink,
            hideOverlay: hideOverlay,
            placeholder: widget.placeholder,
            selecteElement: widget.selecteElement,
            height: widget.height,
            onChange: (value, index) {
              widget.onChange.call(value, index);
            },
            isFixSizeDropDown: widget.isFixSizeDropDown,
            textStyleLastElement: widget.textStyleLastElement,
            radius: widget.radius,
          );
        }
        return const SizedBox();
      },
    );
    Overlay.of(context).insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return CompositedTransformTarget(
      link: layerLink,
      child: InkWell(
        highlightColor: theme.white,
        focusColor: theme.white,
        splashColor: theme.white,
        overlayColor: MaterialStateProperty.all(theme.white),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showOverlay();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? theme.backgroundPrimary,
                borderRadius: BorderRadius.circular(widget.radius),
                border: Border.all(
                    color: widget.isError ? theme.errorColor : theme.lightGrey,
                    width: 1),
              ),
              height: 44,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: widget.leftPadding, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.selecteElement.isEmpty
                                ? widget.placeholder
                                : widget.selecteElement,
                            style: theme.text14Regular.copyWith(
                                color: widget.selecteElement ==
                                            widget.placeholder ||
                                        widget.selecteElement.isEmpty
                                    ? theme.lightGrey
                                    : theme.black),
                            softWrap: false,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 12,
                          child: SvgPicture.asset(
                            'assets/icons/arrow_down.svg',
                            color: theme.lightGrey,
                            height: 12,
                            width: 12,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            if (widget.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                widget.errorMessage,
                style: theme.text14Regular.copyWith(color: theme.errorColor),
                textAlign: TextAlign.left,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
