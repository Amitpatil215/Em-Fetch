import 'package:emfetch/invite_friend/invite_via_email/invite_via_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../my_app_bar.dart';

// ignore: must_be_immutable
class ChooseEmailsPage extends StatefulWidget {
  @override
  _ChooseEmailsPageState createState() => _ChooseEmailsPageState();
}

class _ChooseEmailsPageState extends State<ChooseEmailsPage> {
  EmailInvitationController _controller = Get.put(EmailInvitationController());
  bool _isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: "invite_your_friend",
        actions: [
          Checkbox(
            onChanged: (val) {
              setState(() {
                _isAllSelected = val;
              });
              _controller.checkUncheckAll(val);
            },
            value: _isAllSelected,
          ),
          Container(
            margin: EdgeInsets.only(right: Get.width * 0.02),
            child: Center(
              child: Text('Select All'),
            ),
          ),
        ],
        onBack: () {
          _controller.resetUserContactEmail();
          Get.back();
        },
      ),
      body: GetBuilder<EmailInvitationController>(
        builder: (_controller) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.userContactEmailList.length,
            itemBuilder: (ct, index) {
              return CheckboxListTile(
                onChanged: (val) {
                  _controller.checkUncheck(val, index);
                },
                value: _controller.userContactEmailList[index].isSelected,
                key: ValueKey(index),
                title: Text(_controller.userContactEmailList[index].name),
                subtitle: Text(_controller.userContactEmailList[index].email),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            heroTag: ValueKey('load'),
            icon: Icon(Icons.refresh),
            backgroundColor: themeBlack,
            label: Text('Load More'),
            onPressed: () async {
              print('tapped');
              await _controller.loadMore();
            },
          ),
          FloatingActionButton.extended(
            heroTag: ValueKey('add'),
            icon: Icon(Icons.add),
            backgroundColor: themeBlack,
            label: Text('Add'),
            onPressed: () {
              _controller.addIntoImportlist();
              _controller.resetUserContactEmail();
              Get.back();
            },
          ),
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
