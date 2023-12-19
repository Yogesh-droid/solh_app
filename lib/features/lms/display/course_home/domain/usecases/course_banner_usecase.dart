import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_banner_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/course_banner_repo.dart';

class CourseBannerUsecase extends Usecase {
  final CourseBannerRepo courseBannerRepo;

  CourseBannerUsecase({required this.courseBannerRepo});
  @override
  Future<DataState<CourseBannerEntity>> call(params) async {
    return await courseBannerRepo.getCourseHomeBanner(params);
  }
}
