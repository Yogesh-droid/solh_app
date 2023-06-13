import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../../constants/api.dart';
import '../../../services/network/network.dart';

class TrimmerView extends StatefulWidget {
  final File file;

  TrimmerView(this.file);

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  JournalPageController journalPageController = Get.find();
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer.saveTrimmedVideo(
        startValue: _startValue,
        endValue: _endValue,
        onSave: (String? outputPath) async {
          print('output path: ' + outputPath!);
          journalPageController.outputPath.value = outputPath;

          Map<String, dynamic> map = await _uploadImage();
          setState(() {
            _progressVisibility = false;
            _value = outputPath;
          });
          Navigator.pop(context, map);
        });

    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Trimmer"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _progressVisibility ? null : Navigator.pop(context);
          },
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
        actions: [
          _progressVisibility
              ? Container()
              : IconButton(
                  icon: Icon(Icons.check, color: Colors.black),
                  onPressed: () async {
                    String? _value = await _saveVideo();
                    if (_value != null) {
                      Navigator.pop(context, _value);
                    }
                  },
                ),
        ],
      ),
      body: Builder(
        builder: (context) => Center(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Visibility(
                    //   visible: _progressVisibility,
                    //   child: LinearProgressIndicator(
                    //     backgroundColor: Colors.red,
                    //   ),
                    // ),
                    Expanded(
                      child: VideoViewer(trimmer: _trimmer),
                    ),
                    Center(
                      child: TrimViewer(
                        trimmer: _trimmer,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery.of(context).size.width,
                        //maxVideoLength: Duration(seconds: 30),
                        onChangeStart: (value) {
                          _startValue = value;
                        },
                        onChangeEnd: (value) {
                          _endValue = value;
                        },
                        onChangePlaybackState: (value) {
                          setState(() {
                            _isPlaying = value;
                          });
                        },
                      ),
                    ),
                    MaterialButton(
                      child: _isPlaying
                          ? Icon(
                              Icons.pause,
                              size: 80.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow,
                              size: 80.0,
                              color: Colors.white,
                            ),
                      onPressed: () async {
                        var playbackState;
                        await _trimmer.saveTrimmedVideo(
                          startValue: _startValue,
                          endValue: _endValue,
                          onSave: (outputPath) {
                            playbackState = false;
                          },
                        );
                        setState(() {
                          _isPlaying = playbackState;
                        });
                      },
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: _progressVisibility,
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _uploadImage() async {
    journalPageController.isImageUploading.value = true;
    Map<String, dynamic> map = {};

    try {
      map = await Network.uploadFileToServer(
          "${APIConstants.api}/api/fileupload/journal-image",
          "file",
          File(journalPageController.outputPath.value),
          isVideo: true);
      journalPageController.isImageUploading.value = false;
    } on Exception catch (e) {
      print(e.toString());
      Utility.showToast('Something went wrong');
      Navigator.pop(context);
    }
    return map;
  }
}
