import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:topparcel/data/models/app_model/parcel_content_model.dart';
import 'package:topparcel/data/models/response/create_hscode_response.dart';
import 'package:topparcel/global/cubits/hscode_cubit.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/pages/create_parcel/ordering_step_three_page.dart';
import 'package:topparcel/pages/prohibited_goods/prohibited_goods_page.dart';
import 'package:topparcel/widgets/drop_down/drop_down_field.dart';
import 'package:topparcel/widgets/text_field/default_text_field.dart';

import '../../global/cubits/parcels_cubit.dart';
import '../../helpers/constans.dart';
import '../../navigation/page_manager.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/buttons/default_button.dart';

class OrderingStepTwoPage extends StatefulWidget {
  const OrderingStepTwoPage({
    super.key,
  });

  @override
  State<OrderingStepTwoPage> createState() => _OrderingStepTwoPageState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: OrderingStepTwoPage(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/ordering_step_two_page';
}

class _OrderingStepTwoPageState extends State<OrderingStepTwoPage> {
  List<ParcelContentModel> itemsList = [];

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelState = ParcelsCubit.watchState(context);
    return BlocListener<ParcelsCubit, ParcelsState>(
      listener: (context, state) {
        if (state.status is OrderingStepThreeStatus) {
          PageManager.read(context)
              .push(OrderingStepThreePage.page(), rootNavigator: true);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(title: 'Ordering'),
        ),
        body: BlocBuilder<HscodeCubit, HscodeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Step 2',
                        style: theme.text14Regular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: theme.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Parcel content',
                              style: theme.text16Medium
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    'The information must be completed in English. Please see the ',
                                style: theme.text14Regular,
                                children: [
                                  TextSpan(
                                    text: 'list of prohibited items.',
                                    style: theme.text14Regular
                                        .copyWith(color: theme.primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        PageManager.read(context).push(
                                            ProhibitedGoodsPage.page(),
                                            rootNavigator: true);
                                      },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: itemsList.length * 420,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: itemsList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      _ItemInformation(
                                        type: itemsList[index].type,
                                        quantity: itemsList[index].quantity,
                                        description:
                                            itemsList[index].description,
                                        value: itemsList[index].value,
                                        updateItemCallback: (type, quantity,
                                            description, value) {
                                          setState(() {
                                            itemsList[index] =
                                                ParcelContentModel(
                                                    type: type,
                                                    description: description,
                                                    quantity: quantity,
                                                    value: value);
                                          });
                                        },
                                      ),
                                      if (itemsList.length > 1 &&
                                          index != (itemsList.length - 1))
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            color: theme.grey,
                                          ),
                                        )
                                    ],
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<HscodeCubit>()
                                      .getHSCodes(hashCode);
                                  itemsList
                                      .add(ParcelContentModel.emptyModel());
                                });
                              },
                              child: Text(
                                'Add items +',
                                style: theme.text16Medium
                                    .copyWith(color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width - 40,
                              color: theme.extraLightGrey,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Parcel Value:',
                                  style: theme.text16Regular,
                                ),
                                Text(
                                  _countValueParcel(),
                                  style: theme.header16Bold,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Value:',
                                  style: theme.text16Regular,
                                ),
                                Text(
                                  '${parcelState.selecteCourier.cost.replaceAll('.', ',')}',
                                  style: theme.header16Bold,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DefaultButton(
                        widht: MediaQuery.of(context).size.width - 40,
                        title: 'Next step',
                        onTap: () {
                          ParcelsCubit.read(context)
                              .doneStepTwoOrdering(itemsList);
                        },
                        status: ButtonStatus.primary),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _countValueParcel() {
    int result = 0;

    for (var item in itemsList) {
      result += item.value != -1 ? item.quantity * item.value : 0;
    }

    return '${result.toString()},00 \€';
  }
}

class _ItemInformation extends StatefulWidget {
  const _ItemInformation(
      {super.key,
      required this.type,
      required this.quantity,
      required this.description,
      required this.value,
      required this.updateItemCallback});

  final String type;
  final int quantity;
  final String description;
  final int value;
  final Function(String, int, String, int) updateItemCallback;

  @override
  State<_ItemInformation> createState() => __ItemInformationState();
}

class __ItemInformationState extends State<_ItemInformation> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _valueController = TextEditingController();

  String selecteType = '';
  int quantity = 0;

  void _updateField() {
    TextSelection selection = _descriptionController.selection;
    _descriptionController.text = widget.description;
    _descriptionController.selection = selection;

    selection = _valueController.selection;
    _valueController.text = widget.value == -1 ? '' : widget.value.toString();
    _valueController.selection = selection;

    selecteType = widget.type;
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    _updateField();

    return BlocBuilder<HscodeCubit, HscodeState>(
      builder: (context, state) {
        if (state is HscodeLoadedState) {
          List<String> convertHscodesToStringList(List<Hscodes>? hscodes) {
            return hscodes?.map((h) => h.name ?? '').toList() ?? [];
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Type',
                style: theme.header14Semibold,
              ),
              SizedBox(
                height: 8,
              ),
              DropDownField(
                height: 45,
                backgroundColor: theme.white,
                placeholder: 'Select type parcel',
                items: convertHscodesToStringList(state.hscodeResponse.hscodes),
                selecteElement: selecteType,
                onChange: (element, indexDropDown) {
                  widget.updateItemCallback.call(
                      element,
                      quantity,
                      _descriptionController.text,
                      int.parse(_valueController.text));
                },
                isError: false,
                radius: 8,
              ),
              SizedBox(
                height: 12,
              ),
              _quantityWidget(
                0,
                theme,
              ),
              SizedBox(
                height: 12,
              ),
              DefaultTextField(
                height: 120,
                maxLines: 20,
                controller: _descriptionController,
                title: 'Description',
                onChanged: () {
                  widget.updateItemCallback.call(
                      selecteType,
                      quantity,
                      _descriptionController.text,
                      int.parse(_valueController.text));
                },
                errorMessage: '',
                placeholder: '',
              ),
              SizedBox(
                height: 12,
              ),
              DefaultTextField(
                maxLines: 1,
                controller: _valueController,
                title: 'Value',
                onChanged: () {
                  widget.updateItemCallback.call(
                      selecteType,
                      quantity,
                      _descriptionController.text,
                      int.parse(_valueController.text.isEmpty
                          ? '-1'
                          : _valueController.text));
                },
                errorMessage: '',
                placeholder: '',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12,
              ),
            ],
          );
        }
        if (state is HscodeErrorState) {
          final error = state.error;
          print(error);
          return Text('$error');
        }
        return const SizedBox();
      },
    );
  }

  Widget _quantityWidget(int indexParcel, UIThemes theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: theme.header14Semibold,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.grey, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  quantity.toString(),
                  style: theme.text14Regular,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: quantity > 1
                          ? () {
                              widget.updateItemCallback.call(
                                  selecteType,
                                  quantity - 1,
                                  _descriptionController.text,
                                  int.parse(_valueController.text));
                              setState(() {});
                            }
                          : null,
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: quantity > 1 ? theme.black : theme.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/minus.svg',
                            color: theme.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        widget.updateItemCallback.call(
                            selecteType,
                            quantity + 1,
                            _descriptionController.text,
                            int.parse(_valueController.text));
                        setState(() {});
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: theme.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/plus.svg',
                            color: theme.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
