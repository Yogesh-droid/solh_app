class DoctorModel {
  String organisation;
  String name;
  String mobile;
  String email;
  String clinic;
  String locality;
  String pincode;
  String city;
  String bio;
  String abbrevations;
  String profilePicture;
  String specialization;
  String id;

  DoctorModel(
      {required this.organisation,
      required this.name,
      required this.mobile,
      required this.email,
      required this.clinic,
      required this.locality,
      required this.pincode,
      required this.city,
      required this.bio,
      required this.abbrevations,
      required this.profilePicture,
      required this.specialization,
      required this.id});

  factory DoctorModel.fromJson(Map<String, dynamic> doctorJson) {
    return DoctorModel(
        organisation: doctorJson["organisation"],
        name: doctorJson["name"],
        mobile: doctorJson["mobile"],
        email: doctorJson["email"],
        clinic: doctorJson["clinic"],
        locality: doctorJson["locality"],
        pincode: doctorJson["pincode"],
        city: doctorJson["city"],
        bio: doctorJson["bio"],
        abbrevations: doctorJson["Abbrevations"],
        profilePicture: doctorJson["profilePicture"],
        id: doctorJson["_id"],
        specialization: doctorJson['specialization']);
  }
}
