import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';

enum EmptyStateType { parcels, cart, address, operations }

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.type, this.height});

  final EmptyStateType type;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height,
      child: _emptyState(context),
    );
  }

  Widget _emptyState(BuildContext context) {
    final isIphoneSe = MediaQuery.of(context).size.height == 667;
    final theme = UIThemes();
    switch (type) {
      case EmptyStateType.parcels:
        return Padding(
          padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 17),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text(
                    'All your parcels will appear here.\nLet’s create one!',
                    style: theme.text20Regular.copyWith(color: theme.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child:
                        Image.asset('assets/images/empty_state_parcels.png')),
              ],
            ),
          ),
        );
      case EmptyStateType.cart:
        return Padding(
          padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 200),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text(
                    'There\'s nothing here yet',
                    style: theme.text20Regular.copyWith(color: theme.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset('assets/images/empty_state_cart.png'),
              ],
            ),
          ),
        );
      // case EmptyStateType.cart:
      //   return Padding(
      //     padding:
      //         EdgeInsets.only(left: 20, right: 20, bottom: isIphoneSe ? 0 : 70),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Text(
      //                 'There\'s nothing here yet',
      //                 style: theme.text20Regular.copyWith(color: theme.grey),
      //                 textAlign: TextAlign.center,
      //               ),
      //               Image.asset('assets/images/empty_state_cart.png'),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      case EmptyStateType.address:
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'There\'s nothing here yet',
                        style: theme.text20Regular.copyWith(color: theme.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset('assets/images/empty_state_address.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case EmptyStateType.operations:
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'There\'s nothing here yet',
                        style: theme.text20Regular.copyWith(color: theme.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
