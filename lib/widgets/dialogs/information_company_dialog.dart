import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/helpers/utils/ui_themes.dart';
import 'package:topparcel/navigation/page_manager.dart';
import 'package:topparcel/pages/prohibited_goods/prohibited_goods_page.dart';

class InformationCompanyDialog extends StatelessWidget {
  const InformationCompanyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    return Wrap(
      children: [
        AlertDialog(
          title: Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                border:
                    Border(bottom: BorderSide(color: theme.extraLightGrey))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'GlobalPost GB Standart',
                    style: theme.text14Regular,
                  ),
                  InkWell(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: theme.lightGrey,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          'assets/icons/close.svg',
                          color: theme.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          content: Column(
            children: [
              Text(
                'Авиа доставка из Лондона в любую точку мира.',
                textAlign: TextAlign.center,
                style: theme.text12Regular,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Global Post - можно использовать для доставки одежды, небольшой электроники без батарей.',
                textAlign: TextAlign.center,
                style: theme.text12Regular,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Этот вид доставки идеально подходит для личных вещей и небольших коммерческих посылок.',
                textAlign: TextAlign.center,
                style: theme.text12Regular,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Заберем посылку от ваших дверей курьерами для доставки на наш склад.',
                textAlign: TextAlign.center,
                style: theme.text12Regular,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Наш сортировочный склад получит посылку и обработает ее в течение нескольких дней.',
                textAlign: TextAlign.center,
                style: theme.text12Regular,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Ознакомьтесь со списком ',
                    style: theme.text12Regular,
                    children: [
                      TextSpan(
                        text: 'Запрещенные предметы и товары.',
                        style: theme.text12Regular.copyWith(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            PageManager.read(context).push(
                                ProhibitedGoodsPage.page(),
                                rootNavigator: true);
                          },
                      )
                    ],
                  ),
                ),
              ),
              Text(
                'Посылки могут быть доставлены на любые частные или бизнес адреса.',
                textAlign: TextAlign.center,
                style: theme.header12Bold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Посылки принимаются только в картонной коробке, полностью запечатанной и упакованной.',
                textAlign: TextAlign.center,
                style: theme.header12Bold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Необходим принтер для печати документов.',
                textAlign: TextAlign.center,
                style: theme.header12Bold,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      child: Column(
                        children: [
                          Text(
                            'Полное отслеживание',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '£50 страховка на потери',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Доставка на любой адрес',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Доставка до дверей',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      child: Column(
                        children: [
                          Text(
                            'Необходим принтер',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Максимальный вес 25 кг',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Длина + Высота + Ширина 150см',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Максимальная длина 120 см',
                            style: theme.text12Regular,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
