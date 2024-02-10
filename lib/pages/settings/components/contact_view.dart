import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/pages/app/app_page.dart';
import 'package:topparcel/pages/parcels/components/drop_down_parcel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global/cubits/parcels_cubit.dart';
import '../../../helpers/constans.dart';
import '../../../helpers/utils/ui_themes.dart';
import '../../../navigation/page_manager.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/buttons/default_button.dart';
import '../../../widgets/text_field/default_text_field.dart';
import '../../success/success_page.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();

  static MaterialPage<dynamic> page() {
    return const MaterialPage(
      child: ContactView(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  static const routeName = '/contact_view';
}

class _ContactViewState extends State<ContactView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _orderNumberController = TextEditingController();
  bool isError = false;
  bool isVisible = false;
  Country selectElement = Country.emptyModel();
  String errorMessageEmail = '';
  String errorMessageName = '';
  String errorMessageSurname = '';
  String errorMessageOrderNumber = '';
  String errorMessageSelectElement = '';

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes();
    final parcelsState = ParcelsCubit.watchState(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Contact',
        ),
      ),
      body: Column(children: [
        Container(
          color: theme.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DefaultTextField(
                    controller: _nameController,
                    title: 'Name',
                    onChanged: () {},
                    errorMessage: errorMessageName,
                    placeholder: 'Daria',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: theme.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DefaultTextField(
                    controller: _surnameController,
                    title: 'Surname',
                    onChanged: () {},
                    errorMessage: errorMessageSurname,
                    placeholder: 'Zhukovich',
                    preffixIcon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: theme.grey,
                    ),
                  ),
                ),
                DefaultTextField(
                  controller: _emailController,
                  title: 'Email',
                  onChanged: () {},
                  errorMessage: errorMessageEmail,
                  placeholder: 'name@email.com',
                  preffixIcon: SvgPicture.asset(
                    'assets/icons/email.svg',
                    color: theme.grey,
                  ),
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: theme.extraLightGrey))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: DropDownCreateParcel(
                    widht: MediaQuery.of(context).size.width,
                    placeholder: '-Select',
                    seleteElement: selectElement.name,
                    items: parcelsState.countriesList
                        .where((element) => element.deliverable)
                        .toList()
                        .map((e) => e.name)
                        .toList(),
                    onSelected: (element, index) {
                      setState(() {
                        selectElement = parcelsState.countriesList
                            .where((element) => element.deliverable)
                            .toList()[index];
                      });
                    },
                    error: errorMessageSelectElement,
                    title: 'Select a warehouse',
                    backgroundColor: theme.white,
                  ),
                ),
                DefaultTextField(
                  controller: _orderNumberController,
                  title: 'Order or package number',
                  onChanged: () {},
                  errorMessage: errorMessageOrderNumber,
                  placeholder: 'UB715855155LV',
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: DefaultButton(
            widht: MediaQuery.of(context).size.width,
            title: 'Send',
            onTap: () async {
              _validation();
              if (!isError) {
                try {
                  final Email email = Email(
                    body:
                        'Name: ${_nameController.text}\nSurname: ${_surnameController.text}\nWarehouse: ${selectElement.name}\nOrder or package number: ${_orderNumberController.text}',
                    subject: 'Contact ${_emailController.text}',
                    recipients: ['support@topparcel.com'],
                    isHTML: false,
                  );

                  await FlutterEmailSender.send(email);

                  PageManager.read(context).push(
                    SuccessPage.page(
                      'Message was sent!',
                      'We will contact you soon',
                      'Back',
                      () {
                        PageManager.read(context).clearStackAndPushPage(
                            AppPage.page(),
                            rootNavigator: true);
                      },
                    ),
                    rootNavigator: true,
                  );
                } catch (e) {
                  print('');
                }
              }
            },
            status: ButtonStatus.primary,
          ),
        ),
      ]),
    );
  }

  void _validation() {
    setState(() {
      errorMessageEmail = '';
      errorMessageName = '';
      errorMessageSurname = '';
      errorMessageOrderNumber = '';
      errorMessageSelectElement = '';

      isError = false;

      if (_emailController.text.isEmpty) {
        errorMessageEmail = 'Enter email';
        isError = true;
      } else if (!EmailValidator.validate(_emailController.text)) {
        errorMessageEmail = 'Invalid email format';
        isError = true;
      }
      if (_nameController.text.isEmpty) {
        errorMessageName = 'Enter Name';
        isError = true;
      }
      if (_surnameController.text.isEmpty) {
        errorMessageSurname = 'Enter Surname';
        isError = true;
      }
      if (selectElement.name.isEmpty) {
        errorMessageSelectElement = 'Select a warehouse';
        isError = true;
      }
      if (_orderNumberController.text.isEmpty) {
        errorMessageOrderNumber = 'Enter Order or package number';
        isError = true;
      }
    });
  }
}
