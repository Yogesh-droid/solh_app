import 'package:solh/constants/api.dart';
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

  set setGender(String gender) {
    _gender = gender;
    print("gender changed to: $_gender");
  }

  set setDob(String dob) {
    _dob = dob;
    print("dob changed to: $_dob");
  }

  Future<bool> updateUserDetails() async {
    var resposne = await Network.makeHttpPutRequestWithToken(
        url: "${APIConstants.api}/api/edit-user-details",
        body: {
          "first_name": _firstname,
          "last_name": _lastname,
          "bio": _bio,
          "gender": _gender,
          "dob": _dob
        });
    print(resposne.toString());
    return false;
  }
}
