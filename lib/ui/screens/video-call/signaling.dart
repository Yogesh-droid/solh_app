import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef void StreamStateCallback(MediaStream stream);

class Signaling {
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': "stun:openrelay.metered.ca:80",
      },
      {
        'urls': "turn:openrelay.metered.ca:80",
        'username': "openrelayproject",
        'credential': "openrelayproject",
      },
      {
        'urls': "turn:openrelay.metered.ca:443",
        'username': "openrelayproject",
        'credential': "openrelayproject",
      },
      {
        'urls': "turn:openrelay.metered.ca:443?transport=tcp",
        'username': "openrelayproject",
        'credential': "openrelayproject",
      },
    ],
  };

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;

  Future openUserMedia(RTCVideoRenderer localVideo,
      RTCVideoRenderer remoteVideo, String type) async {
    var stream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});

    localVideo.srcObject = stream;

    localStream = stream;

    remoteVideo.srcObject = await createLocalMediaStream('key');
    print('localStream ${localStream!.id}');

    if (localStream != null) {
      if (type == 'create') {
        createRoom();
      } else {
        joinRoom();
      }
    }

    return localStream;
  }

  Future<void> createRoom() async {
    print('room created');
    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();

    print('localStream ${localStream!.id}');

    localStream?.getTracks().forEach((track) {
      print('track id');
      print('track id $track.id');

      peerConnection?.addTrack(track, localStream!);
    });
  }

  Future<void> joinRoom() async {
    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });
  }

  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection!.onIceConnectionState = ((state) {
      print('onIceConnectionState $state');
    });

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
      if (state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
        // SocketService.socket
        //     .emit('calleeCandidateCompleted', 'calleeCandidateCompleted');
      }
    };

    // peerConnection!.onAddTrack = (MediaStream stream, track) {
    //   if (count == 0) {
    //     print('onAddTrack ${stream.getTracks().toString()}');
    //     if (stream.getTracks().isNotEmpty) {
    //       remoteStream = stream;

    //       if (remoteStream != null) {
    //         onAddRemoteStream!.call(stream);
    //       }
    //     }
    //     count++;
    //   }
    // };

    // peerConnection?.onAddStream = (MediaStream stream) {
    //   print("Add remote stream ${stream.id}");

    //   onAddRemoteStream?.call(stream);

    //   remoteStream = stream;

    //   print('remoteStream ${remoteStream!.active.toString()}');
    // };
  }
}
