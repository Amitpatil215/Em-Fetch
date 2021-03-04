import 'dart:ui';

import 'package:emfetch/Constants/background_clip.dart';
import 'package:emfetch/Constants/colors.dart';
import 'package:emfetch/Constants/custom_button.dart';
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
                title: "invite_mail",
                onBack: () {
                  Get.back();
                }),
            body: Stack(
              children: [
                BackgroundClip(
                  height: Get.height * .4,
                ),
                Container(
                  margin: EdgeInsets.only(top: Get.height * .005),
                  padding: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                _button(1, () {
                                  Get.to(ChooseEmailsPage());
                                  controller.googleSignInAndFetchContacts();
                                }),
                                _button(2, () {
                                  controller.isUploading();
                                }),
                                // _button(3, () {
                                //   controller.isManual = true;
                                //   controller.importing = false;controller.generated = false;
                                //   controller.update();
                                // })
                              ]),
                          Container(
                            margin: EdgeInsets.all(8),
                            //height: Get.height * .5,
                            padding: EdgeInsets.only(
                                bottom: Get.height * 0.04,
                                left: Get.width * 0.01,
                                right: Get.width * 0.01),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 2)
                              ],
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                _justText(),
                                _manual(),
                                controller.generated ? _import() : SizedBox(),
                                SizedBox(height: Get.height * 0.03),
                                controller.uploading &&
                                        controller.fileName != null
                                    ? _uploadCSV()
                                    : SizedBox(),
                                controller.importing ? _import() : SizedBox(),
                              ],
                            ),
                          ),
                          _sendButton()
                        ]),
                  ),
                ),
              ],
            ),
          );
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

  importedList() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: List.generate(
                  _controller.importListCount > 5
                      ? 5
                      : _controller.importListCount,
                  (i) => importedListTile(i)),
            ),
            SizedBox(height: 10),
            _controller.importListCount > 5
                ? Text("${_controller.importListCount} has been imported",
                    style: TextStyle(
                        fontSize: Get.height * 0.018, color: themeBlue))
                : SizedBox(),
          ],
        ),
      ],
    );
  }

  importedListTile(int index) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
      ),
      padding:
          EdgeInsets.symmetric(vertical: 0, horizontal: Get.height * 0.009),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     blurRadius: 5,
        //   )
        // ],
      ),
      child: Text("${_controller.importList[index]}",
          style: TextStyle(
            fontSize: Get.height * 0.018,
          )),
    );
  }

  _manualEmailListTile(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5, right: 5),
          width: Get.width * .65,
          padding:
              EdgeInsets.symmetric(vertical: 0, horizontal: Get.height * 0.009),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.2),
            //     blurRadius: 5,
            //   )
            // ],
          ),
          child: Text("${_controller.emailList[index]}",
              maxLines: 10,
              softWrap: true,
              style: TextStyle(
                fontSize: Get.height * 0.018,
              )),
        ),
        GestureDetector(
            onTap: () {
              _controller.removeEmail(index);
            },
            child: Icon(
              Icons.cancel,
              size: 20,
              color: themeBlack,
            ))
      ],
    );
  }

  _manual() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * .07),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: Get.height * 0.03),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _emailTextField(),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState.validate()) {
                      _controller.addEmail();
                    }
                  },
                  child: Container(
                    //margin: EdgeInsets.only(right:Get.width * .07),
                    width: 24,
                    height: 24,
                    color: themeBlack,
                    child: Center(
                        child:
                            Text("+", style: TextStyle(color: Colors.white))),
                  ),
                )
              ],
            ),

            Column(
              children: List.generate(
                  _controller.emailList.length, (i) => _manualEmailListTile(i)),
            ),

            _controller.uploading && _controller.fileName != null
                ? importedList()
                : SizedBox(),
          ]),
    );
  }

  _emailTextField() {
    return Container(
      width: Get.width * .6,
      // height: Get.height * .065,
      child: Form(
        key: formKey,
        // autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          // validator: FieldValidator.validateEmail,
          controller: _controller.emailController,
          style: TextStyle(color: themeBlack, fontSize: Get.height * 0.018),
          decoration: InputDecoration(
            isDense: true,
            hintText: "invite_email_address",
            hintStyle:
                TextStyle(color: themeBlack, fontSize: Get.height * 0.018),
            contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
            errorStyle:
                TextStyle(color: Colors.red, fontSize: Get.height * 0.018),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: themeBlack),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  _uploadCSV() {
    return Row(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
        child: Text("${_controller.fileName}",
            style: TextStyle(
              color: themeBlack,
              fontSize: Get.height * 0.018,
            )),
      ),
      GestureDetector(
          onTap: () {
            _controller.fileName = null;
            _controller.importList.clear();
            _controller.update();
          },
          child: Icon(Icons.cancel, size: 20, color: themeBlack))
    ]);
  }

  _import() {
    return Column(
      children: <Widget>[
        //SizedBox(height: Get.height * 0.02),
        _controller.importing
            ? Column(
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(themeBlack),
                  ),
                  SizedBox(height: Get.height * 0.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "invite_generating",
                        style: TextStyle(
                          fontSize: Get.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: Get.width * .008),
                      //         _blinkingWidget(),
                      SizedBox(width: Get.width * .008),
                      //        _blinkingWidget(),
                      SizedBox(width: Get.width * .008),
                      //       _blinkingWidget(),
                    ],
                  ),
                ],
              )
            : Container(),
        //SizedBox(height: Get.height * 0.01),
        _controller.generated ? _summaryWidget() : Container(),
        // SizedBox(height: Get.height * 0.07),
        // _controller.send ? _sendButton() : Container()
      ],
    );
  }

  // _blinkingWidget() {
  //   return MyBlinkingWidget(
  //     duration: 1,
  //     child: Text(".",
  //         style: fontQuicksand.copyWith(
  //           fontSize: Get.height * 0.03,
  //           fontWeight: FontWeight.bold,
  //         )),
  //   );
  // }

  _summaryWidget() {
    return Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            "invite_generate_successful",
            style: TextStyle(
                fontSize: Get.height * 0.022,
                fontWeight: FontWeight.bold,
                color: themeBlack),
          ),
        ));
  }

  _sendButton() {
    return Center(
        child: Container(
      // width:Get.width * 0.3,
      //   height:Get.height * 0.05,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: CustomButton(
          title: "send",
          ontap: () {
            Get.back();
            print(_controller.emailList);
            print(_controller.importList);
            if (_controller.emailList.isNotEmpty ||
                _controller.importList.isNotEmpty) {
              _controller.onSend();
            }
          },
          paddingVertical: 10,
          //paddingHorizontal: 10,
          borderRadius: 7,
          color: themeBlack),
    ));
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
                  ? "invite_from_google_contacts"
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
