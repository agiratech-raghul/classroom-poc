import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Utils {
  void myAlert(BuildContext context,
      {bool anotherImage = false,
      VoidCallback? gallery,
      VoidCallback? camera}) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                      child: Text(
                    anotherImage
                        ? "Select Another Image to see the results"
                        : "Please choose media to select",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
                ListTile(
                  onTap: gallery,
                  leading: const Icon(
                    Icons.image,
                  ),
                  title: const Text("Form Gallery"),
                ),
                ListTile(
                  onTap: camera,
                  leading: const Icon(
                    Icons.camera,
                  ),
                  title: const Text("Form Camera"),
                ),
              ],
            ),
          );
        });
  }

  static String getImageExtension(String path) {
    List<String> splitDetails = path.split(".");
    if (splitDetails.isNotEmpty) {
      return splitDetails.last;
    }
    return "jpg";
  }

  static void saveNetworkImage(BuildContext context,String? path) async {
    if(path != null) {
      GallerySaver.saveImage(path).then((bool? success) {
        print('Image is saved');
        dialogBuilder(context,Icons.task_alt_rounded,"Image Saved Successfully",Colors.lightGreenAccent).then((value) {
          Navigator.pop(context);
        });
      }
      );
    }else{
      dialogBuilder(context,Icons.error_outline_rounded,"Changes can't Found",Colors.red);
    }
  }
  static Future<String?> textureField(BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          scrollable: true,
          title: Column(
            children: [
              ElevatedButton(
              onPressed: (){
                Navigator.pop(context, "hex");
                }
              ,child: Text("hex")),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, "mirror");
                  }
                  ,child: Text("mirror")),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, "diamond");
                  }
                  ,child: Text("diamond")),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, "hex2");
                  }
                  ,child: Text("hex2")),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, "tile");
                  }
                  ,child: Text("tile")),

            ],
          ),
        );
      },
    );
  }
  static Future<void> dialogBuilder(BuildContext context,IconData? icon,String? title,Color? color) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title:  Center(child: Icon(icon,size: 40,color:color)),
            actions:[ Center(child: Text(title!,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),))],
        );
      },
    );
  }
  static const String picsArtUrl = 'https://api.picsart.io/tools/1.0';

  static String picsArt(PicsArtEndpoint endpoint) {
    switch (endpoint) {
      case PicsArtEndpoint.BG_REMOVE:
        return '$picsArtUrl/removebg';
      case PicsArtEndpoint.TEXTURE:
        return '$picsArtUrl/background/texture';
      case PicsArtEndpoint.STYLE_TRANSFER:
        return '$picsArtUrl/styletransfer';
    }
  }
}

enum PicsArtEndpoint { BG_REMOVE, TEXTURE, STYLE_TRANSFER }
