import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/cart/components/checkout_cart_page.dart';
import 'package:topparcel/widgets/app_bar/cart_app_bar.dart';
import 'package:topparcel/widgets/buttons/default_button.dart';
import 'package:topparcel/widgets/empty_state/empty_state_widget.dart';
import 'package:topparcel/widgets/parcels_widget/cart_details_widget.dart';

import '../create_parcel/create_parcel_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: CartPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/cart_page';
}

class _CartPageState extends State<CartPage> {
  ScrollController _scrollController = ScrollController();

  bool isEmpty = true;
  bool isSelecte = false;

  int countCart = 4;

  List<int> selecteCart = [];

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CartAppBar(
          title: 'Cart',
          isEmpty: isEmpty,
          isSelecte: isSelecte,
          cancalCallback: () {
            setState(() {
              selecteCart.clear();
              isSelecte = false;
            });
          },
          selecteCallback: () {
            setState(() {
              isSelecte = true;
            });
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: isEmpty
                            ? null
                            : Text(
                                'Your order',
                                style: theme.header14Bold,
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          PageManager.read(context).push(
                              CreateParcelPage.page(),
                              rootNavigator: true);
                        },
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(39),
                              border: Border.all(color: theme.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 7),
                            child: Text(
                              '+ New parcel',
                              style: theme.text14Regular
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEmpty)
                  EmptyState(
                    type: EmptyStateType.cart,
                    height: MediaQuery.of(context).size.height,
                  )
                else ...[
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: countCart * 280,
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: countCart,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CartDetailsWidget(
                            dateCollection: '',
                            cost: '\€50,97',
                            detailsFromAndTo:
                                'FROM: United Kingdom, LW123GX | TO: Italy, 80100',
                            insuarance: '\€3',
                            fullNameFrom: 'Zhukovich Daria',
                            way: 'United Kingdom-Italy',
                            isActivateSelecteCart: isSelecte,
                            isSelecte: selecteCart
                                .where((element) => element == index)
                                .toList()
                                .isNotEmpty,
                            seletceCallback: () {
                              setState(() {
                                if (selecteCart
                                    .where((element) => element == index)
                                    .toList()
                                    .isNotEmpty) {
                                  selecteCart.remove(index);
                                } else {
                                  selecteCart.add(index);
                                }
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ]
              ],
            ),
          ),
          if (isSelecte)
            Positioned(
              bottom: 8,
              left: 20,
              child: DefaultButton(
                widht: MediaQuery.of(context).size.width - 40,
                title: 'Checkout',
                onTap: () {
                  if (selecteCart.isNotEmpty)
                    PageManager.read(context).push(
                        CheckoutCartPage.page(
                          selecteCart,
                          () {
                            setState(() {
                              isSelecte = false;
                              selecteCart.clear();
                            });
                          },
                        ),
                        rootNavigator: true);
                },
                status: ButtonStatus.primary,
              ),
            ),
        ],
      ),
    );
  }
}
