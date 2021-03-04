import 'dart:ui';

import 'package:emfetch/Constants/colors.dart';
import 'package:emfetch/Constants/my_app_bar.dart';
import 'package:emfetch/invite_friend/invite_via_email/choose_emails_page.dart';
import 'package:emfetch/invite_friend/invite_via_email/invite_via_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EmailInvitation extends StatelessWidget {
  EmailInvitationController _controller = Get.put(EmailInvitationController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailInvitationController>(
        init: EmailInvitationController(),
        builder: (controller) {
          return Scaffold(
              appBar: MyAppBar(
                  title: "Import Emails",
                  onBack: () {
                    Get.back();
                  }),
              body: Center(
                child: _button(1, () {
                  Get.to(ChooseEmailsPage());
                  controller.googleSignInAndFetchContacts();
                }),
              ));
        });
  }

  _justText() {
    return Container(
        padding: EdgeInsets.all(15),
        child: Text("lorem_ipsum",
            style: TextStyle(
              fontSize: Get.height * 0.018,
            )));
  }

  _button(int id, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .01),
        height: Get.height * 0.14,
        width: Get.width * .3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            border: Border.all(color: themeBlack)),
        child: Center(
          child: _text(
              id == 1
                  ? "Import from google contacts"
                  : id == 2
                      ? "invite_upload"
                      : "Manual",
              1),
        ),
      ),
    );
  }

  _text(String text, int id) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.012),
      child: Text(
        "$text",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.bold,
            color: id == 2 ? themeBlue : themeBlack),
      ),
    );
  }
}
