import 'dart:async';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class UserBlocNetwork {
  final _userController = PublishSubject<UserModel?>();

  Stream<UserModel?> get userStateStream => _userController.stream;

  Future<UserModel?> _fetchDetails() async {
    print("getting profile details");
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.aws}/api/get-my-profile-details");
      print(
          "api response of profile details: " + apiResponse["user"].toString());
      return UserModel.fromJson(apiResponse["user"]);
    } catch (error) {
      throw error;
    }
  }

  void getMyProfileSnapshot() async {
    await _fetchDetails()
        .then((user) => _userController.sink.add(user))
        .onError((error, stackTrace) =>
            _userController.sink.addError(error.toString()));
  }

  Future<String?> CreateSessionCookie(String idToken) async {
    Map<String, dynamic> apiResponse = await Network.makeHttpPostRequest(
        url: "${APIConstants.aws}/create-session-cookie",
        body: {"idToken": idToken});
  }

  void dispose() {
    _userController.close();
  }
}

UserBlocNetwork userBlocNetwork = UserBlocNetwork();
