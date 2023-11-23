import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/chat-list/appointment_video_call_icon_controller.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../bloc/user-bloc.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

import '../video-call/video-call-user.dart';

class ChatProviderScreen extends StatefulWidget {
  const ChatProviderScreen(
      {super.key,
      required String imageUrl,
      required String name,
      required String sId})
      : _imageUrl = imageUrl,
        _name = name,
        _sId = sId;

  final String _imageUrl;
  final String _name;
  final String _sId;

  @override
  State<ChatProviderScreen> createState() => _ChatProviderScreenState();
}

class _ChatProviderScreenState extends State<ChatProviderScreen> {
  final SocketService _service = SocketService();
  final _controller = Get.put(ChatController());

  @override
  void initState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SocketService.currentSId = widget._sId;
        _controller.currentSid = widget._sId;
        debugPrint('SID ${widget._sId}');
        userBlocNetwork.getMyProfileSnapshot();
        _service.connectAndListen();
        _controller.getChatController(widget._sId);

        SocketService.setUserName(userBlocNetwork.myData.name!);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    SocketService.dispose();
    _controller.scrollOffset.value = 0.0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: Stack(
            children: [
              Column(
                children: [
                  ChatAppbar(
                      imageUrl: widget._imageUrl,
                      name: widget._name,
                      sId: widget._sId),
                  Expanded(
                    child: MessageListProvider(
                      sId: widget._sId,
                    ),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _controller.istyping == true
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  'Typing....',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : Container()
                      ],
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MessageBoxProvider(
                      sId: widget._sId,
                    ),
                  ),
                ],
              ),

              // Obx(() {
              //   return _controller.scrollOffset > 0
              //       ? Future.delayed(Duration())
              //       : Container();
              // })
              // Obx(() {
              //   return _controller.scrollController   != 0
              //       ? Icon(Icons.keyboard_arrow_down)
              //       : Container();
              // })
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatAppbar extends StatelessWidget {
  ChatAppbar({Key? key, required String imageUrl, required name, required sId})
      : _imageUrl = imageUrl,
        _name = name,
        _sId = sId,
        super(key: key);

  final String _imageUrl;
  final String _name;
  final String _sId;

  ChatController _controller = Get.put(ChatController());
  AppointmentVideoCallIconController appointmentIconController =
      Get.put(AppointmentVideoCallIconController());
  @override
  Widget build(BuildContext context) {
    appointmentIconController.getVideoCallIcon(_sId);
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.black12)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (() {
                    Navigator.of(context).pop();
                  }),
                  child: Container(
                    width: 50,
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: CachedNetworkImageProvider(_imageUrl == ''
                      ? 'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'
                      : _imageUrl),
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  children: [
                    Text(
                      _name == '' ? '' : _name,
                      style: GoogleFonts.signika(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Obx(() {
                      return Text(
                        _controller.seenStatus.value,
                        style: GoogleFonts.signika(
                            color: SolhColors.primary_green),
                      );
                    })
                  ],
                ),
              ],
            ),
            Obx(() {
              return appointmentIconController
                          .appointmentVideoCallIconModel.value.data !=
                      null
                  ? InkWell(
                      onTap: () async {
                        {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            //return LiveStreamWaiting();

                            return VideoCallUser(
                              // channel: value['data']['channelName'],
                              // token: value['data']['rtcToken'],
                              channel: appointmentIconController
                                  .appointmentVideoCallIconModel
                                  .value
                                  .data!
                                  .channelName,
                              token: appointmentIconController
                                  .appointmentVideoCallIconModel
                                  .value
                                  .data!
                                  .token,
                              sId: appointmentIconController
                                  .appointmentVideoCallIconModel
                                  .value
                                  .data!
                                  .sId,
                              type: 'sc',
                            );
                          })));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Icon(
                          Icons.video_call_outlined,
                          size: 34,
                          color: SolhColors.primary_green,
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MessageBoxProvider extends StatelessWidget {
  MessageBoxProvider({Key? key, required String sId})
      : _sId = sId,
        super(key: key);

  final String _sId;
  String mediaUrl = '';
  String? fileExtension = '';

  ChatController _controller = Get.put(ChatController());
  SocketService service = SocketService();
  ChatListController chatListController = Get.find();
  AppointmentController appointmentController = Get.find();
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: SolhColors.primary_green,
          ),
          borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                // onChanged: ((value) {
                //   SocketService.typing(_sId, 'sc', 'users');

                //   Future.delayed(Duration(seconds: 1), (() {
                //     SocketService.notTyping(_sId, 'sc', 'users');
                //   }));
                // }),
                controller: _controller.messageEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write message'.tr,
                ),
              ),
            ),
            Row(
              children: [
                Obx(() {
                  return _controller.isFileUploading.value
                      ? Container(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                      : InkWell(
                          onTap: () async {
                            print('pressed');
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'pdf',
                                'doc',
                                'jpge',
                                'png'
                              ],
                            );

                            if (result != null) {
                              fileExtension = result.files.first.extension;
                              print('fileExtension $fileExtension');
                              print(result.paths.first);
                              mediaUrl = await _controller
                                  .uploadChatFile(File(result.paths.first!));
                              debugPrint('mediaUrl $mediaUrl');
                              if (mediaUrl != 'File upload failed') {
                                _controller.sendMessageController(
                                    message: _controller
                                        .messageEditingController.text,
                                    sId: _sId,
                                    autherType: 'users',
                                    ct: 'sc',
                                    mediaType: fileExtension,
                                    fileName: result.files.first.name,
                                    mediaUrl: mediaUrl,
                                    appointmentId: '',
                                    authorId: profileController
                                        .myProfileModel.value.body!.user!.sId,
                                    conversationType: 'media');
                              }
                            }
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                  'assets/images/add_file.svg')));
                }),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_controller.messageEditingController.text.trim() ==
                        '') {
                      return;
                    } else {
                      _controller.sendMessageController(
                          message: _controller.messageEditingController.text,
                          sId: _sId,
                          autherType: 'users',
                          ct: 'sc',
                          mediaType: fileExtension,
                          mediaUrl: mediaUrl,
                          appointmentId: '',
                          fileName: '',
                          authorId: profileController
                              .myProfileModel.value.body!.user!.sId,
                          conversationType: 'text');
                    }
                    chatListController.chatListController(1);
                  },
                  child: Icon(
                    Icons.send,
                    color: SolhColors.primary_green,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MessageListProvider extends StatefulWidget {
  MessageListProvider({
    Key? key,
    required String sId,
  })  : _sId = sId,
        super(key: key);

  final String _sId;

  @override
  State<MessageListProvider> createState() => _MessageListProviderState();
}

class _MessageListProviderState extends State<MessageListProvider> {
  ChatController _controller = Get.put(ChatController());
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isLoading == true
          ? Column(
              children: [
                MyLoader(),
              ],
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: _controller.convo.length,
                    itemBuilder: (context, index) {
                      final reversedIndex =
                          _controller.convo.length - 1 - index;

                      if (_controller.convo[reversedIndex].conversationType ==
                          'media') {
                        print(
                            'mediaUrl ${_controller.convo[reversedIndex].media!.mediaUrl}');
                      }
                      _controller.scrollOffset.value = scrollController.offset;
                      print('scrollController ${_controller.scrollOffset}');
                      return _controller
                                  .convo[reversedIndex].conversationType ==
                              'media'
                          ? Filetile(
                              message: _controller.convo[reversedIndex].body,
                              authorId:
                                  _controller.convo[reversedIndex].authorId,
                              sId: widget._sId,
                              fileName:
                                  _controller.convo[reversedIndex].fileName,
                              mediaUrl: _controller
                                  .convo[reversedIndex].media!.mediaUrl,
                              fileType: _controller
                                  .convo[reversedIndex].media!.mediaType,
                              dateTime:
                                  _controller.convo[reversedIndex].dateTime,
                            )
                          : MessageTile(
                              message: _controller.convo[reversedIndex].body,
                              dateTime:
                                  _controller.convo[reversedIndex].dateTime,
                              authorId:
                                  _controller.convo[reversedIndex].authorId,
                              sId: widget._sId,
                            );
                    }),
              ),
            );
    });
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key,
      required message,
      required authorId,
      required sId,
      String? dateTime})
      : _message = message,
        _authorId = authorId,
        _sId = sId,
        _dateTime = dateTime ?? '',
        super(key: key);

  final String _message;
  final String _authorId;
  final String _sId;
  final String _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          mainAxisAlignment: _authorId == _sId
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _authorId == _sId
                    ? Colors.grey.shade200
                    : Color(0xffCCE9E2),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   _authorId,
                    //   style: GoogleFonts.signika(color: Colors.lightGreen),
                    // ),
                    ReadMoreText(
                      _message,
                      style: GoogleFonts.signika(color: Color(0xff666666)),
                      trimLines: 8,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: 'Show more'.tr,
                      trimExpandedText: 'Show less'.tr,
                      trimMode: TrimMode.Line,
                      lessStyle: SolhTextStyles.QS_caption.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: SolhColors.primary_green),
                      moreStyle: SolhTextStyles.QS_caption.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: SolhColors.primary_green),
                    ),
                    Text(
                      DateTime.tryParse(_dateTime) != null
                          ? DateFormat('dd MMM kk:mm')
                              .format(DateTime.parse(_dateTime).toLocal())
                          : '',
                      style: GoogleFonts.signika(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: SolhColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Filetile extends StatelessWidget {
  Filetile({
    Key? key,
    required message,
    required authorId,
    required sId,
    required fileName,
    required mediaUrl,
    required fileType,
    String? dateTime,
  })  : _message = message,
        _authorId = authorId,
        _sId = sId,
        _mediaUrl = mediaUrl,
        _fileName = fileName,
        _fileType = fileType,
        _dateTime = dateTime ?? '',
        super(key: key);

  // ignore: unused_field
  final String _message;
  final String _mediaUrl;
  final String _authorId;
  final String _sId;
  final String _dateTime;
  final String _fileName;
  final String _fileType;

  ChatController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    print('FileTile $_authorId $_mediaUrl');
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          if (_controller.downloadedAndLocalfile.containsKey(_mediaUrl)) {
            print(_controller.downloadedAndLocalfile[_mediaUrl]);
            OpenFilex.open(
              _controller.downloadedAndLocalfile[_mediaUrl],
            ).then((value) {
              print(value.message);
            });
          } else {
            print('pressed this');
            _controller.getLocalPathFromDownloadedFile(
              extension: _fileType,
              fileName: _fileName,
              url: _mediaUrl,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              mainAxisAlignment: _authorId == _sId
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _authorId == _sId
                        ? Colors.grey.shade200
                        : Color(0xffCCE9E2),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   _authorId,
                        //   style: GoogleFonts.signika(color: Colors.lightGreen),
                        // ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color.fromARGB(128, 196, 250, 209)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() {
                                return _controller.isFileDownloading.value &&
                                        _controller.currentLoadingurl ==
                                            _mediaUrl
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        ),
                                      )
                                    : (_controller.downloadedAndLocalfile
                                            .containsKey(_mediaUrl)
                                        ? Icon(
                                            Icons.done,
                                            color: SolhColors.primary_green,
                                          )
                                        : Icon(
                                            Icons.download_sharp,
                                            color: SolhColors.primary_green,
                                          ));
                              }),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  getFileName(_fileName),
                                  style: GoogleFonts.signika(
                                      color: Color(0xff666666)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          DateTime.tryParse(_dateTime) != null
                              ? DateFormat('dd MMM kk:mm')
                                  .format(DateTime.parse(_dateTime).toLocal())
                              : '',
                          style: GoogleFonts.signika(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: SolhColors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

String getFileName(String url) {
  List urlString = url.split('/');
  return urlString.last;
}
