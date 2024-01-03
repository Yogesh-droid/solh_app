import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/country_list_entity.dart';
import 'package:solh/features/lms/display/course_cart/domain/repo/country_list_repo.dart';

class CountryListUsecase extends Usecase {
  final CountryListRepo countryListRepo;

  CountryListUsecase({required this.countryListRepo});
  @override
  Future<DataState<CountryListEntity>> call(params) async {
    return await countryListRepo.getCountryList(params);
  }
}
