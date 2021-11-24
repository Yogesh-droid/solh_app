// import 'dart:async';
// import 'package:rxdart/rxdart.dart';
// import 'package:solh/constants/api.dart';
// import 'package:solh/ui/screens/network/network.dart';

// class UserBlocNetwork {
//   final _userController = PublishSubject<bool>();

//   Stream<bool> get userStateStream => _userController.stream;

//   Future fetchDetails() async {
//     Network.makeHttpGetRequest("localhost:3000/api/get-my-profile-details");
//   }

//   // Future createUser(
//   //   String name,
//   //   String description,
//   //   String
//   // ) async {
//   //   Network.makeHttpPostRequestWithToken(
//   //       url: "http://localhost:3000/api/user/create", body: {});
//   // }

//   Future<String?> CreateSessionCookie(String idToken) async {
//     Map<String, dynamic> apiResponse = await Network.makeHttpPostRequest(
//         url: "${APIConstants.localhost}/create-session-cookie",
//         body: {"idToken": idToken});

//   }

//   Future<>

//   void dispose() {
//     _userController.close();
//   }
// }

// UserBlocNetwork authBlocNetwork = UserBlocNetwork();
