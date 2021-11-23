import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class LivePage extends StatefulWidget {
  static Widget init() {
    return LivePage(key: GlobalObjectKey(const Uuid().v4()));
  }

  const LivePage({Key? key}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = await RtcEngine.create(dotenv.env["AGORA_APP_ID"]!);
    await _engine.enableVideo();
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

    await _engine.joinChannel("", "channel-alpha", null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
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
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid!);
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
