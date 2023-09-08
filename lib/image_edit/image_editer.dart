import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:classroom_poc/common_icon/filter_icon.dart';
import 'package:classroom_poc/controller/home_controller.dart';
import 'package:flutter/material.dart';

class ImageEditer extends StatefulWidget {
  const ImageEditer({super.key, this.image});
  final File? image;

  @override
  State<ImageEditer> createState() => _ImageEditerState();
}

class _ImageEditerState extends State<ImageEditer> {
  final HomeController _controller = HomeController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Image Edit")),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _controller.removeBg?.data?.url != null
                  ? CachedNetworkImage(
                      imageUrl: _controller.removeBg!.data!.url!.toString())
                  : Image.file(widget.image!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonEditIcons(
              onPressed: () {
                _controller.bgRemove(widget.image!.path, null);
              },
              image: "assets/images/background_eraser.png",
              text: "Erasar",
            ),
            const CommonEditIcons(
              image: "assets/images/texture_icon.png",
              text: "Texture",
            ),
            const CommonEditIcons(
              image: "assets/images/merge_image.png",
              text: "Merge",
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          height: 30,
          child: OutlinedButton(
            onPressed: () async {
              // if (_controller.removeBg?.data?.url != null) {
              //   await GallerySaver.saveImage(
              //       _controller.removeBg!.data!.url.toString());
              // }
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
      ]),
    );
  }
}
