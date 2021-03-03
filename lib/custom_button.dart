import 'package:emfetch/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  String title;
  Color color;
  Function ontap;
  String titleImage;
  String leftImage;
  String rightImage;
  double borderRadius;
  double fontsize;
  double height;
  FontWeight fontweight;
  double width;
  double paddingVertical;
  double paddingHorizontal;

  CustomButton({
    this.title,
    this.fontsize,
    this.height,
    this.fontweight,
    @required this.borderRadius,
    this.leftImage,
    this.rightImage,
    this.titleImage,
    this.color,
    this.ontap,
    this.width,
    this.paddingVertical,
    this.paddingHorizontal,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical ?? 0,
            horizontal: widget.paddingHorizontal ?? 0),
        //margin: EdgeInsets.symmetric(vertical: Get.height * .01),
        // height: widget.height ?? Get.height * 0.06,
        //width:  widget.width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              widget.title == "OK" ? 1 : widget.borderRadius),
          color: widget.color ?? themeBlack,
        ),
        child: Stack(
          children: <Widget>[
            widget.titleImage != null
                ? Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Image(
                              color: Colors.white,
                              height: Get.height * 0.026,
                              // width: 20,
                              image: AssetImage(widget.titleImage)),
                        ),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: widget.fontsize ?? Get.height * 0.018,
                              fontWeight: widget.fontweight == null
                                  ? FontWeight.normal
                                  : widget.fontweight,
                              color: widget.color == themeBlack
                                  ? Colors.white
                                  : Colors.black54),
                        ),
                      ],
                    ))
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: widget.fontsize ?? Get.height * 0.02,
                          fontWeight: widget.fontweight == null
                              ? FontWeight.normal
                              : widget.fontweight,
                          color: Colors.white),
                    ),
                  ),
            widget.rightImage == null
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: Get.height * 0.022,
                          color: Color(0xff3B444B),
                        ),
                      ),
                    )),
            widget.leftImage == null
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image(image: AssetImage(widget.leftImage)),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
