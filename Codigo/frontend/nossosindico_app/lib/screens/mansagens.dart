import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class mensageria {
  void tela() {
    Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('users')
            .limit(_limit)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(context, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
    if (currentId.hashCode <= peerId.hashCode) {
      groupChatId = '$currentId-$peerId';
    } else {
    groupChatId = '$peerId-$currentId';
    }
  }
void mandar (){
  StreamBuilder(
    stream: Firestore.instance
        .collection('messages')
        .document(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(_limit)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
      } else {
        listMessage = snapshot.data.documents;
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
          reverse: true,
          controller: listScrollController,
        );
      }
    },
  ),
}

}
