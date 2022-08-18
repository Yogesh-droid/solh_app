import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class UserBlocNetwork {
  final _userController = PublishSubject<UserModel?>();
  UserModel myData = UserModel();
  String _sessionCookie = "";
  String id = '';
  String userMobileNo = '';
  String userEmail = '';
  List<String> hiddenPosts = [];
  String anonUserName = '';
  String anonUserPic = '';

  Stream<UserModel?> get userStateStream => _userController.stream;

  set updateSessionCookie(String sessionCookie) {
    _sessionCookie = sessionCookie;
  }

  String get getSessionCookie {
    return _sessionCookie;
  }

  Future<UserModel?> _fetchUserDetails(String uid) async {
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

  getMyProfileSnapshot() async {
    print('getting user details');
    UserModel? userModel =
        await _fetchUserDetails(FirebaseAuth.instance.currentUser!.uid)
            .onError((error, stackTrace) {
      _userController.sink.addError(error.toString());
      return null;
    });
    print('user details fetched ${userModel.toString()}');
    if (userModel != null) {
      id = userModel.sId ?? '';
      userMobileNo = userModel.mobile ?? '';
      userEmail = userModel.email ?? '';
      myData = userModel;
      anonUserName = userModel.anonymous.userName ?? '';
      anonUserPic = userModel.anonymous.profilePicture ?? '';
      _userController.sink.add(userModel);
    } else {
      _userController.sink.addError('user details not fetched');
    }
    print('user details fetched');
  }

  void getUserProfileSnapshot(String uid) async {
    await _fetchUserDetails(uid)
        .then((user) => _userController.sink.add(user))
        .onError((error, stackTrace) =>
            _userController.sink.addError(error.toString()));
  }

  Future<bool> isProfileCreated() async {
    var response = await Network.makeHttpGetRequestWithToken(
            "${APIConstants.api}/api/is-profile-created")
        .onError((error, stackTrace) {
      print("error: " + error.toString());
      return {"isProfileCreated": false};
    });
    print("is user profile created: " + response.toString());
    if (response.isNotEmpty) {
      return response["isCreated"];
    } else {
      return false;
    }
  }

  // Future<String?> CreateSessionCookie(String idToken) async {
  //   Map<String, dynamic> apiResponse = await Network.makeHttpPostRequest(
  //       url: "${APIConstants.api}/create-session-cookie",
  //       body: {"idToken": idToken});
  //   print(apiResponse);
  // }

  Future<String> deleteAccount() async {
    String msg = '';
    var map;
    try {
      map = await Network.makeHttpDeleteRequestWithToken(
          url: "${APIConstants.api}/api/delete-user?user=$id", body: {});

      if (map["accountDeleted"]) {
        msg = "Account deleted successfully";
      }
    } on Exception catch (e) {
      msg = e.toString();
    }
    return msg;
  }

  void dispose() {
    _userController.close();
  }
}

UserBlocNetwork userBlocNetwork = UserBlocNetwork();
