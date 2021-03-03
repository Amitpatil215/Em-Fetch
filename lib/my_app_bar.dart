import 'dart:ui';

import 'package:emfetch/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBack;
  final List<Widget> actions;

  const MyAppBar({
    Key key,
    @required this.title,
    @required this.onBack,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: themeBlack,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: onBack != null,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 30,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: Get.height * 0.023,
                ),
              ),
              onTap: () {
                if (onBack != null) {
                  onBack();
                }
              },
            ),
          ),
          Container(
            child: Text(
              title ?? "",
              style: TextStyle(
                  fontSize: Get.height * 0.023,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      actions: actions ?? [],
    );
  }
}
