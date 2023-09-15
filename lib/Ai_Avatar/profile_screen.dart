import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/Ai_utils.dart';
import '../Utils/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.data});

  final ProfileData data;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late WebViewController _controller;
  final api = 'https://api.readyplayer.me/v1/avatars/';
  bool isThreeD = false;
  late String twoDUrl;
  int idx = 0;

  @override
  void initState() {
    super.initState();
    twoDUrl = '$api${widget.data.avatarId}.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 20,
              child: ToggleSwitch(
                initialLabelIndex: idx,
                labels: const ['2D', '3D'],
                cornerRadius: 20.0,
                totalSwitches: 2,
                customWidths: const [40, 40],
                onToggle: (index) => {
                  setState(() {
                    idx = index ?? 0;
                    isThreeD = index == 1;
                  })
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (isThreeD)
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                _controller = controller;
                await loadHtmlFromAssets(_controller, 'assets/viewer.html');
              },
              onPageFinished: (page) {
                debugPrint(widget.data.avatarUrl);
                _controller.runJavascript(
                    'window.loadViewer("${widget.data.avatarUrl}");');
              },
            )
          else
            Image.network(twoDUrl, fit: BoxFit.cover),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )),
        height: 200,
        child: Column(
          children: [
            if (!isThreeD) SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.1,
              height: 30,
              child: OutlinedButton(
                onPressed: () async {
                  Utils.saveNetworkImage(context,twoDUrl);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text("Save",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      // fontFamily: Fonts.regular
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
