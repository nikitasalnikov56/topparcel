import 'package:flutter/material.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/dialogs/information_company_dialog.dart';

class ProhibitedGoodsPage extends StatefulWidget {
  const ProhibitedGoodsPage({super.key});

  @override
  State<ProhibitedGoodsPage> createState() => _ProhibitedGoodsPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: ProhibitedGoodsPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/prohibited_goods_page';
}

class _ProhibitedGoodsPageState extends State<ProhibitedGoodsPage> {
  final theme = UIThemes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'UK and International Prohibited items',
          backCallback: () {
            PageManager.read(context).pop(rootNavigator: true);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: theme.orangeColor,
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                    color: theme.orangeColor.withOpacity(0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prohibited Items',
                          style: theme.header14Bold,
                        ),
                        SizedBox(height: 11),
                        Text(
                            'All items listed below (or any item similar in description or content) cannot be carried under any circumstances by our service.',
                            style: theme.text14Regular),
                        SizedBox(height: 5),
                        Text(
                            'A person sending such items may have their order cancelled without notice or refund.',
                            style: theme.text14Regular),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '• Weapons, explosives, munitions(any replicas, limitations and blank firing pistols)'),
                      Text(
                          '• Human or Animals remains, animal parts, livestock, and insects'),
                      Text(
                          '• Car body panels, bumpers, car seats, airbags, batteries (for delivery by air), windows, windscreens, Engines'),
                      Text('• Biological Samples'),
                      Text('• Any Dangerous Goods'),
                      Text(
                          '• Any Item Containing Petrol, Oil (Liquid, Gas Or Fumes)'),
                      Text('• Firearms including replicas and imitations'),
                      Text('• Fire Extinguishers'),
                      Text('• Goods over our maximum dimensions'),
                      Text('• Hazardous Goods'),
                      Text('• Human Remains'),
                      Text('• Infectious substances'),
                      Text('• Lighter fluid and Matches'),
                      Text(
                          '• White Goods (Fridges/freezers, washing machines etc. )'),
                      Text(
                          '• Tobacco or tobacco products, Alcoholic Beverages'),
                      Text('• Cash, Credit Cards, Debit Cards, Cheques'),
                      Text('• Any Drugs (Including Prescription)'),
                      Text('• Liquids, Perishable Goods'),
                      Text('• Plant and seeds'),
                      Text('• Knives'),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: theme.orangeColor,
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                    color: theme.orangeColor.withOpacity(0.05),
                  ),
                  //color: theme.orangeColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No compensation Items',
                          style: theme.header14Bold,
                        ),
                        SizedBox(height: 11),
                        Text(
                          'The below-listed items or any similar are unsuitable for carriage in our network and as such can only be carried on a no-compensation basis.If such items are dispatched with topparcel.com the goods will travel at the risk of the sender and compensation will not be made should lose or damage be incurred.',
                          style: theme.text14Regular,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '• Televisions or other electronic graphical display equipment with screen size exceeding 37 inches'),
                      Text('• Antiques'),
                      Text('• Artwork & Works of Art'),
                      Text(
                          '• Credit or Debit cards Currency,gift vouchers, Travel Traveler\'s es, Money Orders'),
                      Text(
                          '• Ceramics and Porcelain (including Pottery, China, Stoneware, Marble etc. )'),
                      Text('• Military Goods'),
                      Text(
                          '• Medicines (including over the counter medicines and prescription drugs)'),
                      Text('• Foodstuffs'),
                      Text('• Fossils'),
                      Text(
                          '• Furniture (assembled i.e. Sofas/Wardrobes/Tables)'),
                      Text(
                          '• Any glass and glassware (including mirrors, light bulbs etc.)'),
                      Text('• Inks and Toners'),
                      Text(
                          '• Important Documents (i.e. Passports/tenders/share option certificates etc.)'),
                      Text('• Liquids'),
                      Text('• Paint'),
                      Text('• Microscopes'),
                      Text(
                          '• Precious Metals and stones (gold, silver, diamonds etc.)'),
                      Text('• Stamps'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
