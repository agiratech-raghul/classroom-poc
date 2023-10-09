import 'dart:io';

import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/common_icon/common_char_select.dart';
import 'package:classroom_poc/common_icon/common_model_viewer.dart';
import 'package:classroom_poc/controller/videoedit_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
class VideoEdit extends StatefulWidget {
  const VideoEdit({super.key});

  @override
  State<VideoEdit> createState() => _VideoEditState();
}

class _VideoEditState extends State<VideoEdit> {
  VideoEditController? _controller=VideoEditController();
  bool? action;
  String visible="dance";
  bool? stopAction=false;
  String? value;
  File? image;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  Future _showMyDialog(int local) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Choose Character'),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Created Character'),
                  ),
                 Row(
                   children: [
                     for(int i=0;i<local;i++)
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: (){
                           Navigator.of(context).pop("https://models.readyplayer.me/651d52eabf0d4d591516fdf1.glb");                         },
                         child: Container(
                           height: MediaQuery.of(context).size.height/9,
                           width: MediaQuery.of(context).size.height/9,
                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.black),
                           ),
                           child: IgnorePointer(
                             child: CommonModelViewer(
                               src:"https://models.readyplayer.me/651d52eabf0d4d591516fdf1.glb" ,
                               autoPlay: false,
                             ),
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Default Character'),
                  ),
                  CommonChar(
                      onpress: (){
                        Navigator.of(context).pop("assets/sample5.glb");
                      }
                      ,src: "assets/sample5.glb"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Monster Character'),
                  ),
                  CommonChar(
                      onpress: (){
                        Navigator.of(context).pop("assets/zombi.glb");
                      }
                      ,src: "assets/zombi.glb"),
                ],
              )
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    print(value.toString());
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if(value != null)
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 300,
                  width: 410,
                  // width: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if(image !=null)
                      FittedBox(child: Image.file(image!)),
                      action == null
                          ? Visibility(
                           visible: visible=="dance",
                            child: CommonModelViewer(
                                src: value!,
                                autoPlay:true,
                              ),
                          )
                          : action!
                              ? CommonModelViewer(
                                  src: "assets/run.glb",
                                  autoPlay: true,
                                )
                              : CommonModelViewer(
                                  src:  "assets/argument.glb",
                                  autoPlay: true,
                                ),
                    ],
                  )),
      // Container(
      //   width: 310.0,
      //   height: 300,
      //   decoration: BoxDecoration(
      //     color: Colors.white
      //   ),
      //   child: Center(
      //     child: DefaultTextStyle(
      //       style: const TextStyle(
      //         fontSize: 20.0,
      //         color: Colors.black,
      //         fontFamily: 'Bobbers',
      //       ),
      //       child: AnimatedTextKit(
      //         animatedTexts: [
      //           TyperAnimatedText('Once upon a time, there was a young boy living in a small city. He always used to complain about his current circumstances and wished for a different life. One day he met an old man who said,” Instead of complaining about what you dont have, be grateful for what your currently have',
      //           speed: Duration(milliseconds: 60)
      //           ),
      //
      //         ],
      //         onTap: () {
      //           print("Tap Event");
      //         },
      //       ),
      //     ),
      //   ),
      // )
            ],
          ),
      if(value != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
              setState(() {
                visible ='dance';
                action=null;
              });
              }, child: Text("Dance")),
              ElevatedButton(onPressed: (){
                setState(() {
                  visible= "run";
                  action=true;
                  print("run");
                });
              }, child: Text("Run")),
              ElevatedButton(onPressed: (){
                setState(() {
                  visible= 'arg';
                  action=false;
                  print("argument");
                });
              }, child: Text("Argument")),
            ],
          ),

          ElevatedButton.icon(
            onPressed: (){
            _showMyDialog(_controller!.localAnimation.length).then((val) {
              value=val;
              setState(() {});
            });
          }, label: Text("Add Chareter"),icon: Icon(Icons.add),),
        if(value != null)
          ElevatedButton.icon(onPressed: (){
            Utils().myAlert(context, anotherImage: false, camera: () {
              Navigator.of(context).pop();
              getImage(ImageSource.camera, addImage: true);
            }, gallery: () {
              Navigator.of(context).pop();

              getImage(ImageSource.gallery, addImage: true);
            });

          }, label: Text("Add Background"),icon: Icon(Icons.add),)
        ],
      ),
    );

  }
  Future getImage(ImageSource media, {bool addImage = false}) async {
    final XFile? img = await picker.pickImage(source: media);
    debugPrint("image checking $image");
    if (img != null) {
      image = File(img.path);
      setState(() {

      });
    }
    if (image != null) {

    }
  }


}
