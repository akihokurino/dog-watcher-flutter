import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webrtc/infra/graphql/client.dart';
import 'package:webrtc/ui/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();

  final gqClient = GQClient();
  gqClient.setup("https://webrtc-agora.an.r.appspot.com//query");

  final app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: MenuPage.init(),
    builder: (context, child) {
      // 端末の文字サイズ設定を無効にする
      return MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );
    },
  );

  runApp(app);
}
