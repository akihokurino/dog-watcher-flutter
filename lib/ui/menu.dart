import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:live/infra/graphql/api.graphql.dart';
import 'package:live/infra/graphql/client.dart';
import 'package:live/ui/agora_webrtc.dart';
import 'package:live/ui/transition.dart';
import 'package:uuid/uuid.dart';

class MenuPage extends StatefulWidget {
  static Widget init() {
    return MenuPage(key: GlobalObjectKey(const Uuid().v4()));
  }

  const MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 15, 00, 15),
        children: [
          MenuItem(
              text: "Agora WebRTC",
              onClick: () async {
                final payload = AgoraTokenQuery(
                    variables: AgoraTokenArguments(channelName: channelName));
                final resp = await GQClient().query(QueryOptions(
                    document: payload.document,
                    variables: payload.variables.toJson()));
                final decoded = AgoraToken$Query.fromJson(resp);
                final token = decoded.agoraToken.token;

                push(context, AgoraWebRTCPage(token: token));
              })
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  MenuItem({required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ThemeData.dark().dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: ThemeData.dark().backgroundColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(text,
                            style: ThemeData.dark().textTheme.bodyText1),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 15,
                    color: ThemeData.dark().textTheme.bodyText1!.color)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
