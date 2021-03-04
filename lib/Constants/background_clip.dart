
import 'package:emfetch/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BackgroundClip extends StatelessWidget {
  final double height;

  BackgroundClip({this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Background(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [themeBlack,
                Color(0xff16343d),
                Color(0xff75c1b9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        height: height == null ? Get.height * .6 : height,
        // color: themeBlack,
      ),
    );
  }
}

class BackgroundClip4 extends StatelessWidget {
  final double height;

  BackgroundClip4({this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Background(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [themeBlack, Colors.black, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        height: height == null ? Get.height * .6 : height,
        // color: themeBlack,
      ),
    );
  }
}

class BackgroundClip2 extends StatelessWidget {
  final double height;

  BackgroundClip2({this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Background(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [themeBlack, Color(0xff16343d), Color(0xff75c1b9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        height: height == null ? Get.height * .6 : height,
        // color: themeBlack,
      ),
    );
  }
}

class BackgroundClip3 extends StatelessWidget {
  final double height;

  BackgroundClip3({this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Background(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          themeBlack,
          themeBlack,
          themeBlack,
          Color(0xff75c1b9),
          Color(0xff16343d),
          Color(0xff16343d)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        height: height == null ? Get.height * .6 : height,
        // color: themeBlack,
      ),
    );
  }
}

class Background extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 85);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 85);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
