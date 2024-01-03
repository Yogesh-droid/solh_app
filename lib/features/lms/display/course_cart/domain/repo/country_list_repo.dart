import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/country_list_entity.dart';

abstract class CountryListRepo {
  Future<DataState<CountryListEntity>> getCountryList(RequestParams params);
}
