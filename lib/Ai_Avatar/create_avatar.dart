

import 'package:classroom_poc/Ai_Avatar/profile_screen.dart';
import 'package:classroom_poc/Utils/Ai_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateAvatar extends StatefulWidget {
  CreateAvatar({super.key, required this.prefs});

  late SharedPreferences prefs;

  @override
  State<CreateAvatar> createState() => _CreateAvatarState();
}

class _CreateAvatarState extends State<CreateAvatar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) async {
              await loadHtmlFromAssets(controller,'assets/iframe.html');
            },
            javascriptChannels: {
              JavascriptChannel(
                name: 'AvatarCreated',
                onMessageReceived: (JavascriptMessage message) async {
                  await widget.prefs.setString('avatar', message.message);
                  final user = userFromPrefs(widget.prefs);
                  if (!mounted) return;
                  if (user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(data: user)));
                  }
                },
              ),
            },
          )),
    );
  }
}
