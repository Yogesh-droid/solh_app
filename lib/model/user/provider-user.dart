import 'package:flutter/material.dart';
import 'package:solh/services/network/network.dart';

class ProviderUser {
  String? _firstname;
  String? _lastname;
  String? _bio;
  String? _profilePictureUrl;
  String? _gender;
  String? _dob;
  set setFirstName(String firstname) {
    _firstname = firstname;

    print("firstname changed to: $_firstname");
  }

  set setLasttName(String lastanme) {
    _lastname = lastanme;
    print("lastname changed to: $_lastname");
  }

  set setBio(String bio) {
    _bio = bio;
    print("bio changed to: $_bio");
  }

  set setProfilePictureUrl(String profilePictureUrl) {
    _profilePictureUrl = profilePictureUrl;
    print("profilePictureUrl changed to: $_profilePictureUrl");
  }

  Future<bool> updateUserDetails() async {
    await Network.makeHttpPostRequestWithToken(
        url: "https://api.solhapp.com/api/edit-user-details",
        body: {
          "first_name": _firstname,
          "last_name": _lastname,
          "bio": _bio,
          "gender": _gender,
        });
    return false;
  }
}
