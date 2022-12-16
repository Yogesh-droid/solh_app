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
  String? fee;
  String? feeCurrency;
  int? fee_amount;
  String? prefix;

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
      this.fee,
      this.feeCurrency,
      this.fee_amount,
      required this.abbrevations,
      required this.profilePicture,
      required this.specialization,
      required this.prefix,
      required this.id});

  factory DoctorModel.fromJson(Map<String, dynamic> doctorJson) {
    return DoctorModel(
        organisation: doctorJson["organisation"],
        name: doctorJson["name"],
        mobile: doctorJson["mobile"],
        email: doctorJson["email"],
        fee: doctorJson["fee"],
        feeCurrency: doctorJson["feeCurrency"],
        fee_amount: doctorJson["fee_amount"],
        clinic: doctorJson["clinic"],
        locality: doctorJson["locality"],
        pincode: doctorJson["pincode"],
        city: doctorJson["city"],
        bio: doctorJson["bio"],
        abbrevations: doctorJson["Abbrevations"],
        profilePicture: doctorJson["profilePicture"],
        id: doctorJson["_id"],
        prefix: doctorJson["prefix"],
        specialization: doctorJson['specialization']);
  }
}
