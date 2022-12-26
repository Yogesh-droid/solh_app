// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:solh/controllers/connections/connection_controller.dart';
// import 'package:solh/controllers/journals/journal_comment_controller.dart';
// import 'package:solh/routes/routes.dart';
// import 'package:solh/ui/screens/journaling/side_drawer.dart';
// import 'package:solh/widgets_constants/appbars/app-bar.dart';
// import 'package:solh/widgets_constants/constants/colors.dart';
// import 'package:solh/widgets_constants/constants/textstyles.dart';
// import '../../../model/user/user.dart';
// import '../../../services/user/user-profile.dart';
// import '../../../widgets_constants/buttons/custom_buttons.dart';
// import '../../../widgets_constants/zoom_image.dart';
// import '../my-profile/profile/edit-profile.dart';
// import 'connect_screen_services/connect_screen_services.dart';

// class ConnectProfileScreen extends StatefulWidget {
//   ConnectProfileScreen({Key? key, Map<dynamic, dynamic>? args})
//       : _username = args != null ? args['username'] : null,
//         _uid = args != null ? args['uid'] : null,
//         _sId = args != null ? args['sId'] : null,
//         super(key: key);

//   final String? _username;
//   final String _uid;
//   final String _sId;
//   bool isMyConnection = false;

//   @override
//   State<ConnectProfileScreen> createState() => _ConnectProfileScreenState();
// }

// class _ConnectProfileScreenState extends State<ConnectProfileScreen> {
//   final ConnectionController connectionController = Get.find();
//   JournalCommentController journalCommentController = Get.find();
//   final TextEditingController reasonController = TextEditingController();
//   List recivedConnectionRequest = [];
//   OverlayEntry? overlayEntry;
//   late OverlayState _overlayState;
//   ConnectScreenServices connectScreenServices = ConnectScreenServices();
//   @override
//   void initState() {
//     print('UID: ${widget._uid}');
//     print('SID: ${widget._sId}');
//     getUserAnalyticsFromApi(sid: widget._sId);
//     getUser();
//     if (widget._sId.isNotEmpty) {
//       checkIfUserIsMyConnection(widget._sId);
//     }
//     getRecivedConnections();
//     _overlayState = Overlay.of(context)!;
//     overlayEntry = OverlayEntry(builder: (context) {
//       final size = MediaQuery.of(context).size;
//       print(size.width);
//       return Positioned(
//         width: 56,
//         height: 56,
//         top: size.height - 72,
//         left: size.width - 72,
//         child: Material(
//           color: Colors.transparent,
//           child: GestureDetector(
//             onTap: () {
//               Overlay.of(context)!.deactivate();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: SolhColors.primary_green,
//               ),
//               child: Icon(Icons.video_camera_front_rounded),
//             ),
//           ),
//         ),
//       );
//     });
//     Future.delayed(Duration(milliseconds: 300), () {
//       if (overlayEntry == null || overlayEntry?.mounted == false) {
//         print('Overlay is null');
//         return;
//       } else {
//         overlayEntry?.remove();
//       }
//     });
//     super.initState();
//   }

//   getUser() async {
//     if (widget._username != null) {
//       await connectionController.getUserprofileData(widget._username ?? '');
//       checkIfUserIsMyConnection(connectionController.userModel.value.sId!);
//     } else {
//       print('username is null and anlytics is not');
//     }
//   }

//   getRecivedConnections() {
//     connectionController.receivedConnections.forEach((element) {
//       recivedConnectionRequest.add(element.sId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: SolhAppBar(
//           isLandingScreen: false,
//           title: Text(
//             "Connect",
//             style: SolhTextStyles.AppBarText,
//           ),
//           menuButton: getpopUpMenu(),
//         ),
//         body: widget._username != null
//             ? Obx(() {
//                 return connectionController.isLoading.value
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : connectionController.userModel.value.lastName == null
//                         ? Center(
//                             child: Container(
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.2,
//                                   ),
//                                   Icon(
//                                     Icons.error,
//                                     color: Colors.grey,
//                                     size: 100,
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     "User not found",
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 20),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         : NestedScrollView(
//                             headerSliverBuilder:
//                                 (context, innerBoxIsScrolled) => [
//                               SliverList(
//                                 delegate: SliverChildListDelegate([
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       SizedBox(height: 2.5.h),
//                                       CircleAvatar(
//                                         radius: 6.5.h,
//                                         backgroundColor: Color(0xFFD9D9D9),
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           radius: 6.h,
//                                           backgroundImage:
//                                               CachedNetworkImageProvider(
//                                                   connectionController
//                                                           .userModel
//                                                           .value
//                                                           .profilePicture ??
//                                                       ""),
//                                         ),
//                                       ),
//                                       SizedBox(height: 2.h),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                               connectionController.userModel
//                                                       .value.firstName ??
//                                                   "",
//                                               style: TextStyle(fontSize: 21)),
//                                           //Icon(Icons.people, color: SolhColors.grey)
//                                         ],
//                                       ),

//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           GetBadge(
//                                               userType: connectionController
//                                                   .userModel.value.userType),
//                                         ],
//                                       ),
//                                       // Text(
//                                       //   userProfileSnapshot.requireData.userType ?? "",
//                                       //   style: SolhTextStyles.GreenBorderButtonText,
//                                       // ),
//                                       SizedBox(height: 1.5.h),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 18),
//                                         child: Text(
//                                             connectionController
//                                                     .userModel.value.bio ??
//                                                 "",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 16)),
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.thumb_up,
//                                                     size: 18,
//                                                     color: SolhColors
//                                                         .primary_green,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 2.w,
//                                                   ),
//                                                   Obx(() => Text(
//                                                         (connectionController
//                                                                     .userModel
//                                                                     .value
//                                                                     .journalLikeCount ??
//                                                                 0)
//                                                             .toString(),
//                                                         style: SolhTextStyles
//                                                                 .GreenBorderButtonText
//                                                             .copyWith(
//                                                                 fontSize: 18),
//                                                       )),
//                                                 ],
//                                               ),
//                                               Text("Likes"),
//                                             ],
//                                           ),
//                                           // Divider(),
//                                           Column(
//                                             children: [
//                                               Obx(() => Text(
//                                                     (connectionController
//                                                                 .userModel
//                                                                 .value
//                                                                 .connectionCount ??
//                                                             0)
//                                                         .toString(),
//                                                     style: SolhTextStyles
//                                                             .GreenBorderButtonText
//                                                         .copyWith(fontSize: 18),
//                                                   )),
//                                               Text("Connections"),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       recivedConnectionRequest
//                                               .contains(widget._sId)
//                                           ? SolhGreenButton(
//                                               onPressed: () async {
//                                                 await connectionController
//                                                     .addConnection(
//                                                         connectionController
//                                                             .userModel
//                                                             .value
//                                                             .sId!);
//                                               },
//                                               width: 90.w,
//                                               height: 6.3.h,
//                                               child: Text("Accept"))
//                                           : SolhGreenButton(
//                                               onPressed: () async {
//                                                 await connectionController
//                                                     .addConnection(
//                                                         connectionController
//                                                             .userModel
//                                                             .value
//                                                             .sId!);
//                                               },
//                                               width: 90.w,
//                                               height: 6.3.h,
//                                               child: Text("Connect/Join")),

//                                       SizedBox(height: 3.h),
//                                     ],
//                                   ),
//                                 ]),
//                               )
//                             ],
//                             body: TabView(sId: widget._sId),
//                           );
//               })
//             : getUserAnalytics());
//   }

//   Widget getUserAnalytics() {
//     return FutureBuilder<UserModel>(
//         future: UserProfile.fetchUserProfile(widget._uid),
//         builder: (context, userProfileSnapshot) {
//           print('the data is ' + userProfileSnapshot.data.toString());
//           if (userProfileSnapshot.hasData) {
//             print("getUserAnalytics dfijvomdcl;;sdcp[dkasaskapskalsmclm] ");
//             return NestedScrollView(
//               headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                 SliverList(
//                   delegate: SliverChildListDelegate([
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 2.5.h),
//                         CircleAvatar(
//                           radius: 6.5.h,
//                           backgroundColor: Color(0xFFD9D9D9),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return ZoomImage(
//                                     image: userProfileSnapshot
//                                             .requireData.profilePicture ??
//                                         "");
//                               }));
//                             },
//                             child: Hero(
//                               tag: 'profile',
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 6.h,
//                                 backgroundImage: CachedNetworkImageProvider(
//                                     userProfileSnapshot
//                                             .requireData.profilePicture ??
//                                         ""),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 2.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                                 userProfileSnapshot.requireData.firstName ?? "",
//                                 style: TextStyle(fontSize: 21)),
//                             //Icon(Icons.people, color: SolhColors.grey)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             GetBadge(
//                                 userType:
//                                     userProfileSnapshot.requireData.userType),
//                           ],
//                         ),
//                         // Text(
//                         //   userProfileSnapshot.requireData.userType ?? "",
//                         //   style: SolhTextStyles.GreenBorderButtonText,
//                         // ),
//                         SizedBox(height: 1.5.h),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 18),
//                           child: Text(userProfileSnapshot.requireData.bio ?? "",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontSize: 16)),
//                         ),
//                         SizedBox(height: 3.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.thumb_up,
//                                       size: 18,
//                                       color: SolhColors.primary_green,
//                                     ),
//                                     SizedBox(
//                                       width: 2.w,
//                                     ),
//                                     Obx(() => Text(
//                                           connectionController
//                                               .userAnalyticsModel
//                                               .value
//                                               .journalLikeCount
//                                               .toString(),
//                                           style: SolhTextStyles
//                                                   .GreenBorderButtonText
//                                               .copyWith(fontSize: 18),
//                                         )),
//                                   ],
//                                 ),
//                                 Text("Likes"),
//                               ],
//                             ),
//                             // Divider(),
//                             Column(
//                               children: [
//                                 Obx(() => Text(
//                                       connectionController.userAnalyticsModel
//                                           .value.connectionCount
//                                           .toString(),
//                                       style:
//                                           SolhTextStyles.GreenBorderButtonText
//                                               .copyWith(fontSize: 18),
//                                     )),
//                                 Text("Connections"),
//                               ],
//                             ),
//                             // Divider(),
//                             // Column(
//                             //   children: [
//                             //     Text(
//                             //       '17',
//                             //       style:
//                             //           SolhTextStyles.GreenBorderButtonText
//                             //               .copyWith(fontSize: 18),
//                             //     ),
//                             //     Text("Reviews"),
//                             //   ],
//                             // )
//                           ],
//                         ),
//                         SizedBox(height: 3.h),
//                         (getConnectionIdBySId(widget._sId) != ''
//                             ? Container(
//                                 width: 90.w,
//                                 height: 6.3.h,
//                                 child: SolhGreenBorderButton(
//                                   onPressed: () async {
//                                     await connectionController
//                                         .deleteConnectionRequest(
//                                             getConnectionIdBySId(widget._sId));
//                                     setState(() {});
//                                   },
//                                   child: Text('Cancel',
//                                       style: GoogleFonts.signika(
//                                         color: SolhColors.primary_green,
//                                       )),
//                                 ),
//                               )
//                             : SolhGreenButton(
//                                 onPressed: () async {
//                                   setState(() {});

//                                   widget.isMyConnection
//                                       // ? Navigator.push(
//                                       //     context,
//                                       //     MaterialPageRoute(
//                                       //         builder: (context) => ChatScreen(
//                                       //               name: userProfileSnapshot
//                                       //                       .requireData
//                                       //                       .firstName ??
//                                       //                   '',
//                                       //               imageUrl: userProfileSnapshot
//                                       //                       .requireData
//                                       //                       .profilePicture ??
//                                       //                   '',
//                                       //               sId: userProfileSnapshot
//                                       //                       .requireData.sId ??
//                                       //                   '',
//                                       //             )))
//                                       ? Navigator.pushNamed(
//                                           context, AppRoutes.chatUser,
//                                           arguments: {
//                                               "name": userProfileSnapshot
//                                                       .requireData.firstName ??
//                                                   '',
//                                               "imageUrl": userProfileSnapshot
//                                                       .requireData
//                                                       .profilePicture ??
//                                                   '',
//                                               "sId": userProfileSnapshot
//                                                       .requireData.sId ??
//                                                   '',
//                                             })
//                                       : (checkIfAlreadyInSendConnection(
//                                               widget._sId)
//                                           ? await connectionController
//                                               .deleteConnectionRequest(
//                                                   getConnectionIdBySId(
//                                                       widget._sId))
//                                           : await connectionController
//                                               .addConnection(widget._sId));
//                                   setState(() {});
//                                 },
//                                 width: 90.w,
//                                 height: 6.3.h,
//                                 child: Builder(builder: (context) {
//                                   return widget.isMyConnection
//                                       ? Text('Message')
//                                       : Text("Connect/Join");
//                                 }),
//                               )),
//                         SizedBox(height: 3.h),
//                         widget.isMyConnection &&
//                                 widget._sId != '62e125176a858283a925d15c'
//                             ? SolhGreenButton(
//                                 onPressed: () async {
//                                   await connectionController
//                                       .deleteConnection(widget._sId);
//                                   setState(() {});
//                                 },
//                                 width: 90.w,
//                                 height: 6.3.h,
//                                 child: widget.isMyConnection &&
//                                         checkIfUserIsMyConnection(widget._sId)
//                                     ? Text('Unfriend')
//                                     : Text("Connect/Join"))
//                             : Container(),
//                         SizedBox(height: 3.h),
//                       ],
//                     ),
//                   ]),
//                 )
//               ],
//               body: TabView(
//                 sId: widget._sId,
//               ),
//             );
//           } else {
//             print(' No data is available');
//             return Center(child: CircularProgressIndicator());
//           }
//         });
//   }

//   String getConnectionIdBySId(String sId) {
//     String connectionId = '';
//     connectionController.allConnectionModel.value.connections!
//         .forEach((element) {
//       if (element.sId == sId && element.flag == 'sent') {
//         connectionId = element.connectionId!;
//       }
//     });
//     return connectionId;
//   }

//   bool checkIfUserIsMyConnection(String sId) {
//     bool isInMyConnection = false;
//     connectionController.myConnectionModel.value.myConnections != null
//         ? connectionController.myConnectionModel.value.myConnections!
//             .forEach((element) {
//             if (element.sId == sId) {
//               widget.isMyConnection = true;
//               isInMyConnection = true;
//             }
//           })
//         : null;

//     return isInMyConnection;
//   }

//   bool checkIfAlreadyInSendConnection(String sId) {
//     bool alReadySentRequest = false;
//     connectionController.sentConnections.value.forEach((element) {
//       if (sId == element.sId) {
//         alReadySentRequest = true;
//       }
//     });
//     return alReadySentRequest;
//   }

//   Future<void> getUserAnalyticsFromApi({required String sid}) async {
//     await connectionController.getUserAnalytics(sid);
//   }

//   getpopUpMenu() {
//     return PopupMenuButton(
//       icon: Icon(
//         Icons.more_vert,
//         color: SolhColors.black,
//       ),
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//             child: Text('Report this person'),
//             value: 1,
//           ),
//           // PopupMenuItem(
//           //   child: Text('Block'),
//           //   value: 2,
//           // ),
//         ];
//       },
//       onSelected: (value) {
//         if (value == 1) {
//           showDialog(
//             context: context,
//             builder: (context) => ReportUserDialog(
//               context,
//               userId: widget._sId,
//             ),
//           );
//         } else {
//           print('Block');
//         }
//       },
//     );
//   }

//   ReportUserDialog(BuildContext context, {required String userId}) {
//     return Dialog(
//       insetPadding: EdgeInsets.zero,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width / 20,
//           vertical: MediaQuery.of(context).size.height / 80,
//         ),
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height / 2,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: SolhColors.white,
//         ),
//         child: Column(children: [
//           Align(
//               alignment: Alignment.topRight,
//               child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(
//                     Icons.close,
//                     color: SolhColors.black,
//                   ))),
//           SizedBox(height: 10),
//           Text(
//             "We are sorry for your inconvenience due to this post/person. Please let us know what is the problem with this post/person.",
//             style: SolhTextStyles.JournalingPostMenuText,
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 40,
//           ),
//           TextFieldB(
//             label: 'Reason',
//             maxLine: 4,
//             textEditingController: reasonController,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 40,
//           ),
//           SolhGreenButton(
//             child: Obx(() {
//               return !journalCommentController.isReportingPost.value
//                   ? Text(
//                       'Report',
//                       style: SolhTextStyles.GreenButtonText,
//                     )
//                   : Container(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         color: SolhColors.white,
//                         strokeWidth: 1,
//                       ));
//             }),
//             onPressed: journalCommentController.isReportingPost.value
//                 ? null
//                 : () async {
//                     await journalCommentController.reportPost(
//                         journalId: userId,
//                         reason: reasonController.text,
//                         type: 'user');
//                     Navigator.pop(context);
//                   },
//           ),
//         ]),
//       ),
//     );
//   }

//   // void createOverlay() {
//   //   //Overlay.of(globalNavigatorKey.currentState!.context)!.insert(overlayEntry!);
//   //   _overlayState.insert(overlayEntry!);
//   // }
// }

// // class AllPosts extends StatelessWidget {
// //   const AllPosts({Key? key, required sId})
// //       : _sId = sId,
// //         super(key: key);
// //   final String _sId;
// //   @override
// //   Widget build(BuildContext context) {
// //     return PostScreen(
// //       sId: _sId,
// //     );
// //   }
// // }

// class MessageButton extends StatelessWidget {
//   const MessageButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class ConnectCancelUnfriendButton extends StatelessWidget {
//   const ConnectCancelUnfriendButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class TabView extends StatefulWidget {
//   const TabView({
//     Key? key,
//     this.sId,
//   }) : super(key: key);
//   final String? sId;

//   @override
//   _TabViewState createState() => _TabViewState();
// }

// class _TabViewState extends State<TabView> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 6.h,
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//             GestureDetector(
//               onTap: () {
//                 print("Tab 1");
//                 print(widget.sId);
//                 Navigator.pushNamed(context, AppRoutes.userProfile, arguments: {
//                   'sId': widget.sId,
//                 });
//               },
//               child: Text(
//                 "Posts",
//                 style: TextStyle(
//                     color: _currentPage == 0
//                         ? SolhColors.primary_green
//                         : SolhColors.grey,
//                     fontSize: 20),
//               ),
//             ),
//             // GestureDetector(
//             //   onTap: () {
//             //     _pageController.jumpToPage(1);
//             //   },
//             //   child: Text(
//             //     "Reviews",
//             //     style: TextStyle(
//             //         color:
//             //             _currentPage == 1 ? SolhColors.green : SolhColors.grey,
//             //         fontSize: 20),
//             //   ),
//             // ),
//           ]),
//         ),
//         Expanded(
//           child: PageView(
//             physics: NeverScrollableScrollPhysics(),
//             controller: _pageController,
//             children: [
//               // StreamBuilder<Object>(
//               //   stream: null,
//               //   builder: (context, snapshot) {
//               //     return ListView.builder(
//               //         itemCount: 8,
//               //         itemBuilder: (_, index) => Column(
//               //               children: [
//               //                 JournalTile(journalModel: , deletePost: () {  },),
//               //                 Container(
//               //                   margin: EdgeInsets.symmetric(vertical: 1.h),
//               //                   height: 0.8.h,
//               //                   color: Colors.green.shade400
//               //                       .withOpacity(0.25)
//               //                       .withAlpha(80)
//               //                       .withGreen(160),
//               //                 ),
//               //               ],
//               //             ));
//               //   }
//               // ),
//               Container()
//             ],
//             onPageChanged: (value) {
//               setState(() {
//                 _currentPage = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
