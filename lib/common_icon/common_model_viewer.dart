import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CommonModelViewer extends StatelessWidget {
  const CommonModelViewer({super.key, this.src,this.autoPlay=false,this.color=Colors.transparent});

  final String? src;
  final bool? autoPlay;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      backgroundColor:
      color,
      alt: "Wait...",
      src: src!,
      ar: false,
      autoPlay: autoPlay,
      autoRotate: false,
      disableZoom: true,
      disablePan: true,
      disableTap: true,
      cameraControls: false,
    );
  }
}
