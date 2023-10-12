import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/common_icon/common_chatbubble.dart';
import 'package:classroom_poc/common_icon/common_grid.dart';
import 'package:classroom_poc/common_icon/filter_icon.dart';
import 'package:classroom_poc/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor({super.key, this.image});
  final File? image;

  @override
  State<ImageEditor> createState() => _ImageEditerState();
}

class _ImageEditerState extends State<ImageEditor> {
  final HomeController _controller = HomeController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  File? image;
  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media, {bool addImage = false}) async {
    final XFile? img = await picker.pickImage(source: media);
    debugPrint("image checking $image");
    if (img != null) {
      image = File(img.path);
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Image Edit")),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        WidgetsToImage(
          controller: controller,
          child: Container(
decoration: BoxDecoration(
  color: Colors.white
),
            height: MediaQuery
                .of(context)
                .size
                .height / 1.8,
            child:image!=null?Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonGrid(firstImage:widget.image!,secondImage: image!,),
                ),
                // CommonChatBubble()
              ],
            ) : _controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _controller.removeBg?.data?.url != null
                ? CachedNetworkImage(
                imageUrl: _controller.removeBg!.data!.url!.toString())
                : Image.file(widget.image!),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonEditIcons(
              onPressed: () {
                _controller.bgRemove(widget.image!.path, true,'');
              },
              image: "assets/images/background_eraser.png",
              text: "Erasar",
            ),
            //  CommonEditIcons(
            //   onPressed: () {
            //     Utils.textureField(context).then((value) {
            //       _controller.bgRemove(widget.image!.path, false, value);
            //     });
            //   },
            //   image: "assets/images/texture_icon.png",
            //   text: "Texture",
            // ),
            CommonEditIcons(
              onPressed: () {
                Utils().myAlert(context, anotherImage: true, camera: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera, addImage: true);
                }, gallery: () {
                  Navigator.of(context).pop();

                  getImage(ImageSource.gallery, addImage: true);
                });
              },
              image: "assets/images/texture_icon.png",
              text: " Grid",
            ),

          ],
        ),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width / 1.1,
          height: 30,
          child: OutlinedButton(
            onPressed: () async {
              final bytes = await controller.capture();
              Directory? external=await getExternalStorageDirectory();
              File file=File(path.join('${external!.path}/image.png'));
              file.writeAsBytes(bytes!);
              // Utils.saveNetworkImage(context,_controller.removeBg?.data?.url?.toString());
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
