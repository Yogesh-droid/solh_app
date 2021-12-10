class ProviderUser {
  String? _firstname;
  String? _lastname;

  set setFirstName(String firstname) {
    _firstname = firstname;

    print("firstname changed to: $_firstname");
  }

  set setLasttName(String lastanme) {
    _lastname = lastanme;
    print("lastname changed to: $_lastname");
  }
}
