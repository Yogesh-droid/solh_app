import 'dart:convert';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/blocked_user_model.dart';
import 'package:solh/model/blog/blog_details.dart';
import 'package:solh/model/blog/blog_list_model.dart';
import 'package:solh/model/get_all_connection_model.dart';
import 'package:solh/model/my_connection_model.dart';
import 'package:solh/model/people_you_may_know_model.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/model/user/user_analitics_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:http/http.dart' as http;

class ConnectionController extends GetxController {
  var myConnectionModel = MyConnectionModel().obs;
  var allConnectionModel = GetConnectionResponse().obs;
  var peopleYouMayKnow = PeopleYouMayKnowModel().obs;
  var peopleYouMayKnowHome = PeopleYouMayKnowModel().obs;
  var receivedConnections = <Connections>[].obs;
  var sentConnections = <Connections>[].obs;
  var userAnalyticsModel = UserAnalyticModel().obs;
  var groupInvites = <Group>[].obs;
  var isAddingConnection = false.obs;
  var isDecliningConnection = false.obs;
  var declinedConnectionId = ''.obs;
  var isCancelingConnection = false.obs;
  var isLoading = false.obs;
  var isRecommnedationLoading = false.obs;
  var isRecommnedationLoadingHome = false.obs;
  var isBlogLoading = false.obs;
  var bloglist = <BlogListModel>[].obs;
  var blogDetails = BlogDetails().obs;
  var isBlogDetailsLoading = false.obs;
  var isSendingConnectionRequest = false.obs;
  var isGettingBlockedUsers = false.obs;
  var currentSendingRequest = '';
  var blockedUsers = BlockedUserModel().obs;

  /// for canceling connection
  var canceledConnectionId = ''.obs;

  /// for canceling connection
  var addingConnectionId = "".obs;

  /// for adding connection
  var userModel = UserModel().obs;
  DiscoverGroupController discoverGroupController = Get.find();

  getBlogDetails(int id) {
    isBlogDetailsLoading.value = true;
    http
        .get(Uri.parse('https://solhapp.com/blog/api/post/${id}'))
        .then((response) {
      isBlogDetailsLoading.value = false;
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        blogDetails.value = BlogDetails.fromJson(data);
      }
    });
  }

  /////  For recommended posts
  Future<void> getRecommendedBlogs() async {
    isBlogLoading.value = true;

    var response = await http.get(
      Uri.parse("https://solhapp.com/blog/api/posts"),
    );
    print(response.body);

    bloglist.value = (json.decode(response.body) as List)
        .map((i) => BlogListModel.fromJson(i))
        .toList();

    print('Blog list.length = ' + bloglist.value.length.toString());

    isBlogLoading.value = false;
  }

  Future<void> getMyConnection() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/my-connection')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      myConnectionModel.value = MyConnectionModel.fromJson(map);
    }
  }

  Future<void> getAllConnection() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/connection')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      sentConnections.clear();
      receivedConnections.clear();
      allConnectionModel.value = GetConnectionResponse.fromJson(map);
      allConnectionModel.value.connections!.forEach((element) {
        if (element.flag == 'sent') {
          sentConnections.value.add(element);
        } else {
          receivedConnections.value.add(element);
        }
      });
      groupInvites.value.clear();
      allConnectionModel.value.group!.forEach((element) {
        groupInvites.value.add(element);
      });
    }
    getPeopleYouMayKnow('all');
    getPeopleYouMayKnowHome('');
  }

  Future<void> acceptConnection(String connection_id, String response) async {
    await Network.makePutRequestWithToken(
            url: APIConstants.api + '/api/connection',
            body: {'connection_id': connection_id, 'response': response})
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getMyConnection();
    await getAllConnection();
    discoverGroupController.getJoinedGroups();
  }

  Future<void> acceptConnectionFromGroup(String connection_id) async {
    await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/accept?id=${connection_id}',
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getMyConnection();
    await getAllConnection();
  }

  Future<void> deleteConnectionRequest(String connectionId) async {
    await Network.makePutRequestWithToken(
        url: APIConstants.api + '/api/sender-res-connection',
        body: {
          'connection_id': connectionId,
          'sender_id': userBlocNetwork.id,
        }).onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getAllConnection();
  }

  Future<void> addConnection(String uid) async {
    isSendingConnectionRequest(true);
    currentSendingRequest = uid;
    await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/connection',
        body: {'receiver_id': uid}).onError((error, stackTrace) {
      print(error);

      return {};
    }).then((value) => Utility.showToast(value['message']));
    isSendingConnectionRequest(false);
    getMyConnection();
    getAllConnection();
  }

  Future<void> deleteConnection(String uid) async {
    Map response = await Network.makeHttpDeleteRequestWithToken(
        url: APIConstants.api + '/api/connection?userId=${uid}',
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (response['message'] == 'Successfully removed from connections.') {
      Utility.showToast('Successfully removed from connections.');
    }
    getMyConnection();
    getAllConnection();
  }

  Future<void> getUserAnalytics(String uid) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/analytics/$uid')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      userAnalyticsModel.value = UserAnalyticModel.fromJson(map);
    }
  }

  Future<Map<String, dynamic>> blockUser({required String sId}) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/block/v1/user',
        body: {"blockedUser": sId}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    getPeopleBlocked();
    return map;
  }

  Future<Map<String, dynamic>> unBlockUser({required String sId}) async {
    Map<String, dynamic> map = await Network.makeDeleteRequestWithToken(
        url: APIConstants.api + '/api/block/v1/user',
        body: {"blockedUser": sId}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    getPeopleBlocked();
    return map;
  }

  Future getUserprofileData(String user) async {
    isLoading(true);
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/user-profile' + '?user=' + user)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    isLoading(false);

    if (map.containsKey('connections')) {
      if (map['connections'] == null) {
        print("map1" + map.toString());
        print("null type");

        userModel.value.lastName = null;
        update();
        return;
      }
    }

    if (map.isNotEmpty) {
      print("map" + map.toString());

      userModel.value = UserModel.fromJson(map['connections']);
      update();
    }
  }

  Future<void> getPeopleYouMayKnow(String limit) async {
    isRecommnedationLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/connection-recommendation?limit=$limit')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (map.isNotEmpty) {
      peopleYouMayKnow.value = PeopleYouMayKnowModel.fromJson(map);
      print("peopleYouMayKnow" +
          peopleYouMayKnow.value.reccomendation!.length.toString());
    }
    isRecommnedationLoading.value = false;
  }

  Future<void> getPeopleBlocked() async {
    isGettingBlockedUsers.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/block/v1/user')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (map.isNotEmpty) {
      blockedUsers.value = BlockedUserModel.fromJson(map);
    }
    isGettingBlockedUsers.value = false;
    JournalPageController _journalPageController = Get.find();
    _journalPageController.journalsList.clear();
    _journalPageController.pageNo = 1;
    _journalPageController.nextPage = 2;
    _journalPageController.selectedGroupId.value.length > 0
        ? await _journalPageController.getAllJournals(1,
            groupId: _journalPageController.selectedGroupId.value)
        : await _journalPageController.getAllJournals(
            1,
          );
    _journalPageController.journalsList.refresh();
  }

  Future<void> getPeopleYouMayKnowHome(String limit) async {
    isRecommnedationLoadingHome.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/connection-recommendation?limit=$limit')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (map.isNotEmpty) {
      peopleYouMayKnowHome.value = PeopleYouMayKnowModel.fromJson(map);
      print("peopleYouMayKnow" +
          peopleYouMayKnowHome.value.reccomendation!.length.toString());
    }
    isRecommnedationLoadingHome.value = false;
  }

  @override
  void onInit() {
    getMyConnection();
    getAllConnection();
    getRecommendedBlogs();
    super.onInit();
  }
}
