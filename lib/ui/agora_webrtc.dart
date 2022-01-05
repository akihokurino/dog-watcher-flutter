import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

const channelName = "alpha";

class AgoraWebRTCPage extends StatefulWidget {
  final String token;

  static Widget init(String token) {
    return AgoraWebRTCPage(
        key: GlobalObjectKey(const Uuid().v4()), token: token);
  }

  const AgoraWebRTCPage({Key? key, required this.token}) : super(key: key);

  @override
  _AgoraWebRTCPageState createState() => _AgoraWebRTCPageState();
}

class _AgoraWebRTCPageState extends State<AgoraWebRTCPage> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _isAudioMuted = true;
  bool _isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() async {
    super.dispose();
    await _engine.destroy();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = await RtcEngine.create(dotenv.env["AGORA_APP_ID"]!);
    await _engine.enableVideo();
    await _engine.muteLocalAudioStream(_isAudioMuted);

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(widget.token, channelName, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora WebRTC'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.zero,
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? RtcLocalView.SurfaceView()
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isVideoMuted = !_isVideoMuted;
                  });

                  if (_isVideoMuted) {
                    await _engine.disableVideo();
                  } else {
                    await _engine.enableVideo();
                  }
                },
                child: Icon(Icons.video_call_rounded,
                    size: 60,
                    color: _isVideoMuted ? Colors.grey : Colors.blueAccent),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isAudioMuted = !_isAudioMuted;
                  });
                  await _engine.muteLocalAudioStream(_isAudioMuted);
                },
                child: Icon(Icons.mic,
                    size: 60,
                    color: _isAudioMuted ? Colors.grey : Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid!);
    } else {
      return Container();
    }
  }
}
