import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/country_list_controller.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

final GlobalKey<FormState> billingFormKey = GlobalKey();

class CourseBillingWidget extends StatelessWidget {
  const CourseBillingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CountryListController countryListController = Get.find();
    return Obx(() => countryListController.isLoading.value
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: billingFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Address",
                    style: SolhTextStyles.QS_body_1_med.copyWith(
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.grey.shade300,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Please select a country";
                        } else {
                          return null;
                        }
                      },
                      hint: const Text("Select Country"),
                      items: countryListController.countryList
                          .map((element) => DropdownMenuItem(
                                value: element.id,
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(element.name ?? '')),
                              ))
                          .toList(),
                      onChanged: (value) {
                        countryListController.selectedStateList.value =
                            countryListController.countryList
                                .firstWhere((element) => element.id == value)
                                .states!;
                        countryListController.selectedState.value = '';
                        countryListController.selectedCountry.value = value!;
                      }),
                  const SizedBox(height: 10),
                  if (countryListController.selectedCountry.value.isNotEmpty)
                    DropdownButtonFormField(
                        value: countryListController.selectedState.value.isEmpty
                            ? null
                            : countryListController.selectedState.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.grey.shade300,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Please select a State";
                          } else {
                            return null;
                          }
                        },
                        hint: const Text("Select State"),
                        items: countryListController.selectedStateList
                            .map((e) => DropdownMenuItem(
                                  value: e.name,
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(e.name ?? '')),
                                ))
                            .toList(),
                        onChanged: (value) {
                          countryListController.selectedState.value = value!;
                        })
                ],
              ),
            ),
          ));
  }
}
