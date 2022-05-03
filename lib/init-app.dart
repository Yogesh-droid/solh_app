import 'package:solh/bloc/user-bloc.dart';

Future<Map<String, dynamic>> initApp() async {
  Map<String, dynamic> initialAppData = {};
  print("cejckndad a");
  initialAppData["isProfileCreated"] = await userBlocNetwork.isProfileCreated();
  print("completed");
  return initialAppData;
}
