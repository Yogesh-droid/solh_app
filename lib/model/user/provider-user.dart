import 'package:flutter/material.dart';

class ProviderUser {
  String? _firstname;
  String? _lastname;
  String? _bio;
  String? _profilePictureUrl;
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
}
