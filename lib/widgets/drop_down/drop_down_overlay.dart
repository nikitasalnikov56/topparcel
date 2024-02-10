import 'package:flutter/material.dart';
import '../../helpers/utils/ui_themes.dart';
import 'animation_section.dart';

class DropdownOverlay extends StatefulWidget {
  const DropdownOverlay({
    Key? key,
    required this.items,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.placeholder,
    required this.selecteElement,
    required this.onChange,
    required this.height,
    this.isFixSizeDropDown = true,
    this.radius = 24,
    this.leftPadding = 20,
    this.textStyleLastElement,
  }) : super(key: key);

  final List<String> items;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String placeholder;
  final String selecteElement;
  final Function(String, int) onChange;
  final double height;
  final bool isFixSizeDropDown;
  final double radius;
  final double leftPadding;
  final TextStyle? textStyleLastElement;

  @override
  State<DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<DropdownOverlay> {
  bool displayOverly = true;
  bool displayOverlayBottom = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final child = GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              color: theme.extraLightGrey.withOpacity(0.0),
            ),
            Positioned(
              width: widget.size.width + 24,
              child: CompositedTransformFollower(
                link: widget.layerLink,
                followerAnchor: displayOverlayBottom
                    ? Alignment.topLeft
                    : Alignment.bottomLeft,
                showWhenUnlinked: false,
                offset: Offset(-12, displayOverlayBottom ? 0 : 60),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 12, left: 12, right: 12),
                      child: Material(
                        color: Colors.transparent,
                        child: AnimatedSection(
                          animationDismissed: widget.hideOverlay,
                          expand: displayOverly,
                          axisAlignment: displayOverlayBottom ? 0.0 : -1.0,
                          child: SizedBox(
                            height: _heightDropDown() + 3,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 46,
                                ),
                                Container(
                                  height: _heightDropDown() - 43,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(widget.radius),
                                    border: Border.all(
                                      color: theme.lightGrey,
                                      width: 1,
                                    ),
                                    color: theme.backgroundPrimary,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      controller: scrollController,
                                      child: ListView.builder(
                                        controller: scrollController,
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.items.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              widget.onChange(
                                                  widget.items[index], index);
                                              setState(() {
                                                displayOverly = false;
                                              });
                                            },
                                            child: Container(
                                                height: widget.height,
                                                decoration:
                                                    widget.items[index] ==
                                                            widget
                                                                .selecteElement
                                                        ? BoxDecoration(
                                                            borderRadius: index ==
                                                                    (widget.items
                                                                            .length -
                                                                        1)
                                                                ? const BorderRadius
                                                                        .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            24),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            24))
                                                                : BorderRadius
                                                                    .circular(
                                                                        0),
                                                            color: theme
                                                                .extraLightGrey,
                                                          )
                                                        : null,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Text(
                                                        widget.items[index],
                                                        style: index ==
                                                                    (widget
                                                                            .items
                                                                            .length -
                                                                        1) &&
                                                                widget.textStyleLastElement !=
                                                                    null
                                                            ? widget
                                                                .textStyleLastElement
                                                            : theme
                                                                .text14Regular,
                                                      ),
                                                    ))),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: child,
      ),
    );
  }

  double _heightDropDown() {
    if (widget.isFixSizeDropDown) {
      return (widget.items.length + 1) > 7
          ? 7 * widget.height
          : (widget.items.length + 1) * widget.height;
    }
    return (widget.items.length + 1) * widget.height;
  }
}
