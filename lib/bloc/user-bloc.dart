import 'dart:async';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user.dart';
import 'package:solh/ui/screens/network/network.dart';
import 'package:rxdart/rxdart.dart';

class UserBlocNetwork {
  final _userController = PublishSubject<UserModel?>();

  Stream<UserModel?> get userStateStream => _userController.stream;

  Future<UserModel?> _fetchDetails() async {
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "http://localhost:3000/api/get-my-profile-details");
      print("api response: " + apiResponse["user"].toString());
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
        url: "${APIConstants.localhost}/create-session-cookie",
        body: {"idToken": idToken});
  }

  void dispose() {
    _userController.close();
  }
}

UserBlocNetwork userBlocNetwork = UserBlocNetwork();
