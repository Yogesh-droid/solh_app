import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/add_address_req_model.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/edit_address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/address_text_field.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../../../../../widgets_constants/constants/textstyles.dart';
import '../../../data/models/address_model.dart';

class AddAddressForm extends StatefulWidget {
  const AddAddressForm(
      {super.key, this.addressList, required this.isAddingBilling});
  final AddressList? addressList;
  final bool isAddingBilling;

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _roadNameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final FocusNode _houseNameNode = FocusNode();
  final FocusNode _roadNameNode = FocusNode();
  final FocusNode _pinNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _stateNode = FocusNode();
  final FocusNode _landMarkNode = FocusNode();
  final FocusNode _fullNameNode = FocusNode();
  final FocusNode _mobileNode = FocusNode();

  final EditAddressController editAddressController = Get.find();
  final AddAddressController addAddressController = Get.find();
  final AddressController addressController = Get.find();

  @override
  void initState() {
    if (widget.addressList != null) {
      _houseNameController.text = widget.addressList!.buildingName ?? '';
      _roadNameController.text = widget.addressList!.street ?? '';
      _pinController.text = widget.addressList!.postalCode ?? '';
      _cityController.text = widget.addressList!.city ?? '';
      _stateController.text = widget.addressList!.state ?? '';
      _fullNameController.text = widget.addressList!.fullName ?? '';
      _mobileController.text = widget.addressList!.phoneNumber ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Address',
                      style: SolhTextStyles.QS_body_semi_1.copyWith(
                          color: Colors.black))),
              AddressTextField(
                  textEditingController: _houseNameController,
                  label: "House no. / Building Name *",
                  focusNode: _houseNameNode,
                  onFieldSubmitted: (value) => _roadNameNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  initialValue: "State"),
              AddressTextField(
                  textEditingController: _roadNameController,
                  label: "Road Name / Area / Colony*",
                  onFieldSubmitted: (value) => _pinNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _roadNameNode),
              AddressTextField(
                  textEditingController: _pinController,
                  label: "Pincode *",
                  onFieldSubmitted: (value) => _cityNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _pinNode),
              AddressTextField(
                  textEditingController: _cityController,
                  label: "City *",
                  onFieldSubmitted: (value) => _stateNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _cityNode),
              AddressTextField(
                  textEditingController: _stateController,
                  label: "State *",
                  onFieldSubmitted: (value) => _landMarkNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _stateNode),
              AddressTextField(
                  textEditingController: _landMarkController,
                  label: "Landmark",
                  onFieldSubmitted: (value) => _fullNameNode.requestFocus(),
                  focusNode: _landMarkNode),
              const GetHelpDivider(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Contact Person',
                      style: SolhTextStyles.QS_body_semi_1.copyWith(
                          color: Colors.black))),
              AddressTextField(
                  textEditingController: _fullNameController,
                  label: "Full Name *",
                  onFieldSubmitted: (value) => _mobileNode.requestFocus(),
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _fullNameNode),
              AddressTextField(
                  textEditingController: _mobileController,
                  label: "Mobile  *",
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _mobileNode),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SolhGreenButton(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    onPressed: widget.isAddingBilling
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              addressController.selectedBillingAddress.value =
                                  AddressList(
                                      buildingName: _houseNameController.text,
                                      city: _cityController.text,
                                      fullName: _fullNameController.text,
                                      landmark: _landMarkController.text,
                                      phoneNumber: _mobileController.text,
                                      postalCode: _pinController.text,
                                      state: _stateController.text,
                                      street: _roadNameController.text);
                              Navigator.pop(context);
                            }
                          }
                        : widget.addressList != null
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  await editAddressController.editAddress(
                                      addAddressReqModel: AddAddressReqModel(
                                          buildingName:
                                              _houseNameController.text,
                                          city: _cityController.text,
                                          fullName: _fullNameController.text,
                                          isDefault: "true",
                                          landmark: _landMarkController.text,
                                          phoneNumber: _mobileController.text,
                                          postalCode: _pinController.text,
                                          state: _stateController.text,
                                          street: _roadNameController.text),
                                      id: widget.addressList!.id!);
                                  if (editAddressController
                                      .editAddressErr.value.isEmpty) {
                                    Utility.showToast(editAddressController
                                        .editAddressSuccessMessage.value);
                                  }
                                  addressController.getAddress();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              }
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await addAddressController.addAddress(
                                      AddAddressReqModel(
                                          buildingName:
                                              _houseNameController.text,
                                          city: _cityController.text,
                                          fullName: _fullNameController.text,
                                          isDefault: "true",
                                          landmark: _landMarkController.text,
                                          phoneNumber: _mobileController.text,
                                          postalCode: _pinController.text,
                                          state: _stateController.text,
                                          street: _roadNameController.text));
                                  if (addAddressController
                                      .addAddressErr.value.isEmpty) {
                                    Utility.showToast(addAddressController
                                        .successMessage.value);
                                  }
                                  addressController.getAddress();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              },
                    child: Obx(() =>
                        addAddressController.isAddingAddress.value ||
                                editAddressController.editAddressLoading.value
                            ? const SolhGradientLoader(
                                radius: 15,
                                strokeWidth: 3,
                              )
                            : Text(
                                "Save and Continue",
                                style: SolhTextStyles.CTA
                                    .copyWith(color: Colors.white),
                              )),
                  )),
              const SizedBox(height: 50)
            ],
          ),
        ));
  }
}
