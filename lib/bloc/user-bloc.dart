import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class UserBlocNetwork {
  final _userController = PublishSubject<UserModel?>();
  String _sessionCookie = "";

  Stream<UserModel?> get userStateStream => _userController.stream;

  set updateSessionCookie(String sessionCookie) {
    _sessionCookie = sessionCookie;
  }

  String get getSessionCookie {
    return _sessionCookie;
  }

  Future<UserModel?> _fetchUserDetails(String uid) async {
    print("getting profile details");
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.api}/api/get-my-profile-details");
      print(
          "api response of profile details: " + apiResponse["user"].toString());
      return UserModel.fromJson(apiResponse["user"]);
    } catch (error) {
      throw error;
    }
  }

  void getMyProfileSnapshot() async {
    await _fetchUserDetails(FirebaseAuth.instance.currentUser!.uid)
        .then((user) => _userController.sink.add(user))
        .onError((error, stackTrace) =>
            _userController.sink.addError(error.toString()));
  }

  void getUserProfileSnapshot(String uid) async {
    await _fetchUserDetails(uid)
        .then((user) => _userController.sink.add(user))
        .onError((error, stackTrace) =>
            _userController.sink.addError(error.toString()));
  }

  Future<bool> isProfileCreated() async {
    var response = await Network.makeHttpGetRequestWithToken(
        "${APIConstants.api}/api/is-profile-created");
    print("is user profile created: " + response.toString());
    return response["isCreated"];
  }

  Future<String?> CreateSessionCookie(String idToken) async {
    Map<String, dynamic> apiResponse = await Network.makeHttpPostRequest(
        url: "${APIConstants.api}/create-session-cookie",
        body: {"idToken": idToken});
    print(apiResponse);
  }

  void dispose() {
    _userController.close();
  }
}

UserBlocNetwork userBlocNetwork = UserBlocNetwork();
