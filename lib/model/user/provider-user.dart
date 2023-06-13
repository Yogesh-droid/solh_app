import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:http/http.dart' as http;

class ProviderUser {
  String? _firstname;
  String? _lastname;
  String? _bio;
  String? _profilePictureUrl;
  String? _gender;
  String? _userName;
  String? _userType;
  String? _dob = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String? _email = '';

  set setFirstName(String firstname) {
    _firstname = firstname;

    print("firstname changed to: $_firstname");
  }

  set setUserName(String userName) {
    _userName = userName;

    print("userName changed to: $_userName");
  }

  set setEmail(String email) {
    _email = email;

    print("email changed to: $_email");
  }

  set setLasttName(String lastanme) {
    _lastname = lastanme;
    print("lastname changed to: $_lastname");
  }

  set setBio(String bio) {
    _bio = bio;
    print("bio changed to: $_bio");
  }

  set setUserType(String userType) {
    _userType = userType;
    print("userType changed to: $_userType");
  }

  set setProfilePictureUrl(String profilePictureUrl) {
    _profilePictureUrl = profilePictureUrl;
    print("profilePictureUrl changed to: $_profilePictureUrl");
  }

  set setGender(String gender) {
    _gender = gender;
    print("gender changed to: $_gender");
  }

  set setDob(String dob) {
    _dob = dob;
    print("dob changed to: $_dob");
  }

  Future<bool> updateUserDetails() async {
    try {
      debugPrint({
        "first_name": _firstname,
        "last_name": _lastname,
        "bio": _bio,
        "gender": _gender,
        "userName": _userName,
        "dob": _dob,
        "userType": _userType,
        "email": _email
      }.toString());
      Uri _uri = Uri.parse("${APIConstants.api}/api/edit-user-details");

      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.put(_uri, headers: {
        "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
      }, body: {
        "first_name": _firstname ?? '',
        "last_name": _lastname ?? '',
        "bio": _bio ?? '',
        "gender": _gender ?? '',
        "userName": _userName ?? '',
        "dob": _dob ?? '',
        "userType": _userType == 'Undefined' ? 'Seeker' : _userType ?? '',
        "email": _email ?? ''
      });

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        print(jsonDecode(apiResponse.body));
        return jsonDecode(apiResponse.body)["body"];
      } else {
        print("Status Code: " + apiResponse.statusCode.toString());
        throw "server-error";
      }
    } on SocketException {
      // internetConnectivityBloc.noInternet();
      throw "no-internet";
    } catch (e) {
      print(e);
      throw e;
    }
    // print("$_userName");
    // print(_firstname);
    // print(_bio);
    // print(_lastname);

    // var resposne = await Network.makeHttpPutRequestWithToken(
    //     url: "${APIConstants.api}/api/edit-user-details",
    //     body: {
    //       "first_name": _firstname,
    //       "last_name": _lastname,
    //       "bio": _bio,
    //       "gender": _gender,
    //       "userName": _userName,
    //       "dob": _dob,
    //       "userType": _userType,
    //       "email": _email
    //     }).onError((error, stackTrace) {
    //   print(error);
    //   return {};
    // });
    // print(resposne.toString());
    // return false;
  }
}
