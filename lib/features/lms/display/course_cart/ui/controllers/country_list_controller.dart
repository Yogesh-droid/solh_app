import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/data/models/country_model.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/country_list_entity.dart';
import 'package:solh/features/lms/display/course_cart/domain/usecases/country_list_usecase.dart';

class CountryListController extends GetxController {
  final CountryListUsecase countryListUsecase;
  var countryList = <CountryList>[].obs;
  var err = ''.obs;
  var isLoading = false.obs;

  var selectedCountry = ''.obs;
  var selectedStateList = <States>[].obs;
  var selectedState = ''.obs;
  CountryListController({required this.countryListUsecase});

  Future<void> getCountryList() async {
    isLoading.value = true;
    try {
      final DataState<CountryListEntity> dataState =
          await countryListUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/custom/get-country-list-with-state"));
      if (dataState.data != null) {
        countryList.value = dataState.data!.countryList!;
        isLoading.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
