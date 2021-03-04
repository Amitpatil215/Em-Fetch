import 'dart:convert';
import 'dart:io';

import 'package:emfetch/Model/UserContactEmail.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class EmailInvitationController extends GetxController {
  int importListCount;
  bool importing = false;
  bool generated = false;
  bool send = false;
  bool isManual = false;
  bool loadingPath = false;
  bool uploading = false;
  var importList = [];
  var emailList = [];
  TextEditingController emailController = TextEditingController();

  String path;
  String fileName;

  /// ----------- Sign in to google and Fetch Contacts---------

  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;
  String pageToken;
  List<UserContactEmail> userContactEmailList = [];

  void googleSignInAndFetchContacts() async {
    // Initialize google sign in

    _googleSignIn = GoogleSignIn(
      scopes: [
        //'https://www.googleapis.com/auth/contacts',
        'https://www.googleapis.com/auth/contacts.readonly',
        //'https://www.googleapis.com/auth/contacts.other.readonly',
      ],
    );

    await _handleSignIn().then((_) async {
      try {
        print(_googleSignIn.currentUser.displayName);
        await getUserContacts();
      } catch (er) {
        print('try catch block for controller and getting user contacts');
        print(er);
      }
    });
  }

  Future<void> getUserContacts() async {
    try {
      final host = 'https://people.googleapis.com';
      var endPoint =
          '/v1/people/me/connections?personFields=names,emailAddresses&&pageSize=300';
      //'/v1/otherContacts?readMask=emailAddresses,names&&pageSize=20';

      final header = await _currentUser.authHeaders;

      print('loading contact emails');

      if (pageToken != null) {
        endPoint = endPoint + '&&pageToken=$pageToken';
      }

      await http.get('$host$endPoint', headers: header).then((val) {
        var extractedData = jsonDecode(val.body) as Map<String, dynamic>;
        print(extractedData);
        pageToken = jsonDecode(val.body)['nextPageToken'];
        //print(pageToken);
        (extractedData['connections'] as List<dynamic>).forEach((val) {
          if (val['emailAddresses'] != null) {
            print('');
            userContactEmailList.add(
              UserContactEmail(
                name: val['names'][0]['displayName'],
                email: val['emailAddresses'][0]['value'],
              ),
            );
          }
        });

        update();

        userContactEmailList.forEach((user) {
          print(user.name);
          print(user.email);
          print('');
        });
      });

      print('Loading completed');
    } catch (err) {
      print('error while fetching contacts');
      print(err);
    }
  }

  Future<void> loadMore() async {
    await getUserContacts();
  }

  Future<void> _handleSignIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
    } catch (error) {
      print('google sgin in err');
      print(error);
    }
  }

  /// Select/Unselect All Checkboxes
  void checkUncheckAll(bool val) {
    for (int i = 0; i < userContactEmailList.length; i++) {
      userContactEmailList[i].isSelected = val;
    }
    update();
  }

  /// Select/Unselect Single Checkboxes
  void checkUncheck(bool val, int index) {
    userContactEmailList[index].isSelected = val;
    update();
  }

  /// On navigating back clear all the data
  void resetUserContactEmail() {
    pageToken = null;
    userContactEmailList = [];
    update();
  }

  /// Add selected email list to imported list
  void addIntoImportlist() {
    for (int i = 0; i < userContactEmailList.length; i++) {
      if (userContactEmailList[i].isSelected == true) {
        importList.add(userContactEmailList[i].email);
      }
    }
    if (importList.isNotEmpty) {
      fileName = '';
      uploading = true;
      importListCount = importList.length;
      update();
    }
  }

  /// ----------------

  void isImporting() {
    uploading = false;

    importing = true;
    generated = false;
    send = false;

    update();
    Future.delayed(Duration(seconds: 5), () {
      importing = false;
      generated = true;
      send = true;
      update();
    });
  }

  void addEmail() {
    emailList.add(emailController.text);
    emailController.clear();
    update();
  }

  void addUploads() {
    emailList.add(importList);
  }

  void onSend() {
    importing = false;
    generated = false;
    send = true;
    isManual = false;
    uploading = false;
    emailList.clear();
    importList.clear();
    update();
  }

  void isUploading() {
    importing = false;
    generated = false;
    send = false;

    uploading = true;
    openFileExplorer();
  }

  void openFileExplorer() async {
    loadingPath = true;
    try {
      // path = await FilePicker.getFilePath(
      //   type: FileType.any,
      //   //allowedExtensions: ['csv']
      // );
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    if (path.endsWith(".csv")) {
      loadingPath = false;
      fileName = path != null ? path.split('/').last : '...';
      readCSV();
    } else
      update();
  }

  void readCSV() async {
    // var csv = await File(path).readAsString();
    // List<List<dynamic>> rowsAsListOfValues =
    //     const CsvToListConverter().convert(csv);
    // importListCount = rowsAsListOfValues.length;
    // print("list count: $importListCount");
    // if (importListCount > 5) {
    //   for (int i = 0; i < 5; i++) {
    //     print(rowsAsListOfValues[i].elementAt(0));
    //     importList.add(rowsAsListOfValues[i].elementAt(0));
    //   }
    // } else {
    //   for (int i = 0; i < importListCount; i++) {
    //     print(rowsAsListOfValues[i].elementAt(0));
    //     importList.add(rowsAsListOfValues[i].elementAt(0));
    //   }
    // }

    // update();
  }

  void reset() {
    emailList = [];
    importList = [];
    fileName = null;
  }

  void removeEmail(int index) {
    emailList.removeAt(index);
    update();
  }
}
