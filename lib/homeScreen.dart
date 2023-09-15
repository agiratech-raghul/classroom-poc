import 'dart:io';

import 'package:classroom_poc/Ai_Avatar/create_avatar.dart';
import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/image_edit/image_editer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final prefs;
  @override
  void initState() {
    storeImage();
    // TODO: implement initState
    super.initState();
  }
  Future<void> storeImage()async{
     prefs = await SharedPreferences.getInstance();
  }
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
                Utils().myAlert(context, anotherImage: true, camera: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera, addImage: true);
                }, gallery: () {
                  Navigator.of(context).pop();

                  getImage(ImageSource.gallery, addImage: true);
                });
              },
              child: const Text("Edit Image")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAvatar(prefs: prefs),));
              }, child: const Text("Custom Animation"))
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
