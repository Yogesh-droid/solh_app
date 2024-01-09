import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/doctors_appointment_model.dart';
import 'package:solh/model/profile/allied_appoinment_list.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/my-profile/appointments/model/profile_transfer_detail_model.dart';
import 'package:solh/ui/screens/my-profile/appointments/model/profile_transfer_model.dart';
import 'package:solh/ui/screens/my-profile/appointments/service/appointment_services.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import '../../../../../model/user/user_appointments_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

enum ProfileTransferStatus {
  Undefined,
  Accepted,
  Pending,
  Declined,
}

class AppointmentController extends GetxController {
  var userAppointmentModel = UserAppointmentModel().obs;
  var doctorAppointmentModel = DoctorsAppointmentModel().obs;
  var alliedAppoinmentModel = AlliedAppoinmentModel().obs;
  var profileTransferModel = ProfileTransferModel().obs;
  var profileTransferDetailModel = ProfileTransferDetailModel().obs;
  var isAlliedLoading = false.obs;
  var isAppointmentLoading = false.obs;
  var profileTransferStatus = ProfileTransferStatus.Undefined.obs;
  var isRoutingFromBookAppointment = false;
  var isLoading = false.obs;
  var isUpdatingTransferStatus = false.obs;
  String transferId = '';
  var isFileDownloading = false.obs;
  var currentLoadingurl = '';
  String? filePath;
  Map downloadedAndLocalfile = {}.obs;

  Future<void> getUserAppointments() async {
    isAppointmentLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/app-user-appointents');

    if (map['success']) {
      userAppointmentModel.value = UserAppointmentModel.fromJson(map);
    }
    isAppointmentLoading.value = false;
  }

  Future<void> transferProfileController() async {
    isLoading(true);
    try {
      var response = await AppointmentServices.getTransferProfileList();

      if (response["success"]) {
        profileTransferModel.value = ProfileTransferModel.fromJson(response);
      } else {
        SolhSnackbar.error("Opps!", "Unable to load data");
      }
    } catch (e) {
      SolhSnackbar.error("Opps!", "Unable to load data");
      throw (e);
    }
    isLoading(false);
  }

  Future<void> transferProfileDetailController(transferId) async {
    isLoading(true);
    var response =
        await AppointmentServices.getTransferProfileDetail(transferId);

    if (response["success"]) {
      log('it ran $transferId');
      profileTransferDetailModel.value =
          ProfileTransferDetailModel.fromJson(response);
    } else {
      SolhSnackbar.error("Opps!", "Unable to load data");
    }
    try {} catch (e) {
      SolhSnackbar.error("Opps!", "Unable to load data");
      throw (e);
    }
    isLoading(false);
  }

  Future<void> getDoctorAppointments() async {
    isAppointmentLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/app-provider-appointents');
      log(map.toString(), name: 'map');
      if (map['success']) {
        doctorAppointmentModel.value = DoctorsAppointmentModel.fromJson(map);
      }
    } catch (e) {
      log(e.toString(), name: "error");
      throw (e);
    }
    isAppointmentLoading.value = false;
  }

  Future<void> updateTransferStatusController(String status) async {
    try {
      isUpdatingTransferStatus(true);
      var response = await AppointmentServices.updateTransferStatus(
          status: status, transferId: transferId);

      if (response["success"]) {
        if (response["result"]) {
          profileTransferStatus.value = ProfileTransferStatus.Accepted;
        } else {
          profileTransferStatus.value = ProfileTransferStatus.Declined;
        }
      } else {
        SolhSnackbar.error("Opps!", "Unable to load data");
      }
    } catch (e) {
      SolhSnackbar.error("Opps!", "Unable to load data");
      throw (e);
    }
    isUpdatingTransferStatus(false);
  }

  Future<Map<String, dynamic>> getAlliedBooking() async {
    isAlliedLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/package/getOrderList");
      print("alliedBooking $map");
      if (map['success']) {
        alliedAppoinmentModel.value = AlliedAppoinmentModel.fromJson(map);
        isAlliedLoading.value = false;
        return map;
      }
    } catch (e) {
      print(e.toString());
      isAlliedLoading.value = false;
      return {"success": false};
    }
    isAlliedLoading.value = false;
    return {"success": false};
  }

  Future getLocalPathFromDownloadedFile(
      {required String url,
      required String fileName,
      required String extension}) async {
    try {
      isFileDownloading(true);
      Uri uri = Uri.parse(url);
      log(extension);
      currentLoadingurl = url;

      var response = await http.get(uri);
      isFileDownloading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = response.bodyBytes;

        File file = File('$filePath/$fileName');
        await file.writeAsBytes(decodedResponse);
        downloadedAndLocalfile[url] = '$filePath/$fileName';
        log("${downloadedAndLocalfile[url]}");
        File(file.path).exists().then((value) {
          debugPrint(file.path);
          if (value) {
            debugPrint('it exists');
          } else {
            debugPrint('not exits');
          }
        });
      } else {
        throw "server-error";
      }
    } on SocketException {
      throw "no-internet";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint('directory $directory');
    filePath = directory.path;
  }

  @override
  void onInit() {
    super.onInit();
    getUserAppointments();
  }
}
