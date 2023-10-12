
import 'dart:io';

import 'package:flutter/material.dart';

class CommonGrid extends StatelessWidget {
  const CommonGrid({super.key, required this.firstImage, required this.secondImage});
 final File firstImage;
  final File secondImage;

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.file(firstImage),
          Image.file(secondImage),
        ],

    );
  }
}
