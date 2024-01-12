import 'package:solh/core/data_state/data_state.dart';

import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/services/network/network.dart';

import '../../domain/repo/udpate_lecture_track_repo.dart';

class UpdateLectureTrackRepoImpl implements UpdateLectureTrackRepo {
  @override
  Future<DataState<Map<String, dynamic>>> updateLecture(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);
      if (map['success']) {
        return DataSuccess(data: map);
      } else {
        return DataError(exception: map['message'] ?? "Something went wrong");
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
