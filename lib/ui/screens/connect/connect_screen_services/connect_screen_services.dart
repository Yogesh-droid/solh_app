import 'package:flutter/cupertino.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/connect/connect_sceen_model/connect_screen_model.dart';

class ConnectScreenServices{
  
  Future<dynamic>getProfileDetails(String sId)async{
    try{
        var response=
   await Network.makeGetRequestWithToken('${APIConstants.api}/api/user/v1/user-profile/$sId');
   
   return ConnectScreenModel.fromJson(response);
    }
    catch(e){
      debugPrint(e.toString());
    }
 
  }



  checkIfAlreadyInConnection(){

  }

  checkIfAlreadyInSendConnection(){

  }  


}