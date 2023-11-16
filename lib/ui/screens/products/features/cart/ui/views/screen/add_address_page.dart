import 'package:flutter/material.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/address_model.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/add_address_form.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddAddressPage extends StatelessWidget {
  AddAddressPage({super.key, Map<dynamic, dynamic>? args})
      : _addressList = args!['addressList'];

  final AddressList? _addressList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Add Address',
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: AddAddressForm(addressList: _addressList),
    );
  }
}
