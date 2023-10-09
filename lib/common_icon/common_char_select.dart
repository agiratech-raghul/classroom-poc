import 'package:classroom_poc/common_icon/common_model_viewer.dart';
import 'package:flutter/material.dart';

class CommonChar extends StatelessWidget {
  const CommonChar({super.key, required this.src, required this.onpress});
final String src;
final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onpress,
            child: Container(
              height: MediaQuery.of(context).size.height/9,
              width: MediaQuery.of(context).size.height/9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: IgnorePointer(
                child: CommonModelViewer(
                  src:src,
                  autoPlay: false,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
