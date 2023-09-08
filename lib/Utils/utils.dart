import 'package:flutter/material.dart';

class Uitls {
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
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
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
