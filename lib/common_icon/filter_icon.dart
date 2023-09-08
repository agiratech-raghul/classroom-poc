import 'package:flutter/material.dart';

class CommonEditIcons extends StatelessWidget {
  const CommonEditIcons({super.key, this.onPressed, this.image, this.text});
  final VoidCallback? onPressed;
  final String? image;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 80,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(image!),
              ),
            ),
            Text(
              text!,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  // fontFamily: Fonts.bold,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
