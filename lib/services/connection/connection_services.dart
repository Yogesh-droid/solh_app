import 'package:flutter/foundation.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

import '../../bloc/user-bloc.dart';

class ConnectionServices{
  Future<Map<String,dynamic>> addConnectionService(String SId) async {

    try{
      var response = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/connection',
     body: {"receiver_id":SId});
     return response;
    }catch(e){
      debugPrint(e.toString());
      return {};
    }
  }

  Future<Map<String,dynamic>> removeConnectionService(String sId)async {
   try{
      var response = await Network.makeHttpDeleteRequestWithToken(
        url: APIConstants.api + '/api/connection?userId=${sId}',
     body: {});
     return response;
    }catch(e){
      debugPrint(e.toString());
      return {};
    }
  }

  Future<Map<String,dynamic>> removeConnectionRequestService(String connectionId) async {
     try{
      var response = await Network.makePutRequestWithToken(
        url: APIConstants.api + '/api/sender-res-connection',

     body: {
          'connection_id': connectionId,
          'sender_id': userBlocNetwork.id,
        });
     return response;
    }catch(e){
      debugPrint(e.toString());
      return {};
    }
  }
}