import 'package:get/get.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity-log-model/activity_log_model.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity-log-service/activity_log_service.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class ActivityLogContoller extends GetxController {
  // var filterItems = [
  //   "journal",
  //   "like",
  //   "comment",
  //   "bestComment",
  //   "connection",
  //   "group",
  //   "appointment",
  // ].obs;
  var isActivityLogLoading = false.obs;
  var firstLoadDone = false.obs;
  var isFeatchingMoreLog = false.obs;
  int pageNumber = 1;

  var activityLogModel = ActivityLogModel().obs;
  ActivityLogService activityLogService = ActivityLogService();

  Future<void> getActivityLogController() async {
    try {
      if (pageNumber == 1) {
        isActivityLogLoading(true);
      }
      ActivityLogModel response =
          await activityLogService.getActivityLog(pageNumber);
      if (response.success == true) {
        isActivityLogLoading(false);
        if (pageNumber == 1) {
          activityLogModel.value = response;
        } else {
          activityLogModel.value.result!.next = response.result!.next;
          // activityLogModel.value.result!.activityLog!
          //     .addAll(response.result!.activityLog!.toList());
          isActivityLogLoading(false);
          isFeatchingMoreLog(false);
          activityLogModel.update((val) {
            val!.result!.activityLog!
                .addAll(response.result!.activityLog!.toList());
          });
        }
      } else {
        SolhSnackbar.error('Opps!!', "SomeThing went wrong");
      }
    } catch (e) {
      SolhSnackbar.error('Opps!!', "SomeThing went wrong");
      throw e;
    }
  }
}
