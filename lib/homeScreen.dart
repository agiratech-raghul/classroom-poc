import 'dart:io';

import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/image_edit/image_editer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("ClassRoom")),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Uitls().myAlert(context, anotherImage: true, camera: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera, addImage: true);
                }, gallery: () {
                  Navigator.of(context).pop();

                  getImage(ImageSource.gallery, addImage: true);
                });
              },
              child: const Text("Edit Image")),
          ElevatedButton(
              onPressed: () {}, child: const Text("custom animation"))
        ]),
      ),
    );
  }

  Future getImage(ImageSource media, {bool addImage = false}) async {
    final XFile? img = await picker.pickImage(source: media);
    debugPrint("image checking $image");
    if (img != null) {
      image = File(img.path);
    }
    if (image != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (_) => ImageEditer(image: image),
      ))
          .then((value) {
        image = null;
      });
    }
  }
}
