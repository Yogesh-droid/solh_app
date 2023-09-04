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
  String _usertype = "";
  String id = '';
  String userMobileNo = '';
  String userEmail = '';
  List<String> hiddenPosts = [];
  String anonUserName = '';
  String anonUserPic = '';
  static bool isFetchingProfile = false;

  Stream<UserModel?> get userStateStream => _userController.stream;

  set updateSessionCookie(String sessionCookie) {
    _sessionCookie = sessionCookie;
  }

  set updateUserType(String userType) {
    _usertype = userType;
  }

  String get getSessionCookie {
    return _sessionCookie;
  }

  String get getUserType {
    return _usertype;
  }

  Future<UserModel?> _fetchUserDetails(String uid) async {
    try {
      isFetchingProfile = true;
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.api}/api/get-my-profile-details");
      isFetchingProfile = false;
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
      anonUserName =
          userModel.anonymous != null ? userModel.anonymous.userName ?? '' : '';
      anonUserPic = userModel.anonymous != null
          ? userModel.anonymous.profilePicture ?? ''
          : '';
      _userController.sink.add(userModel);
    } else {
      _userController.sink.addError('user details not fetched');
    }
    print('user details fetched');
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
      if (response['success'] != null) {
        return response['success'];
      }
      return response["isCreated"];
    } else {
      return false;
    }
  }

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
