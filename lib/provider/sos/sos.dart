import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:solh/services/hive-storage/sos.dart';

class SOSProvider with ChangeNotifier {
  SOSHiveModel _sosHiveModel = SOSHiveModel();

  var sosBox;

  Future initSOSHive() async {
    sosBox = await Hive.openBox('testBox');
  }

  void fetchSOSPeople() {}
}
