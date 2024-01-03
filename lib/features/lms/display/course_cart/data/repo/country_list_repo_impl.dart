import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/data/models/country_model.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/country_list_entity.dart';
import 'package:solh/features/lms/display/course_cart/domain/repo/country_list_repo.dart';
import 'package:solh/services/network/network.dart';

class CountryListRepoImpl implements CountryListRepo {
  @override
  Future<DataState<CountryListEntity>> getCountryList(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = CountryModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
