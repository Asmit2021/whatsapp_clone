import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/call/screens/call_screen.dart';
import 'package:whatsapp_clone/models/call.dart';
import 'package:whatsapp_clone/models/group.dart' as model;

final callRepositoryProvider = Provider(
  (ref) => CallRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class CallRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  CallRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<DocumentSnapshot> get callStream =>
      firestore.collection('call').doc(auth.currentUser!.uid).snapshots();

  void makeCall(
    Call senderCallData,
    BuildContext context,
    Call receiverCallData,
  ) async {
    try {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CallScreen(
                    channelId: senderCallData.callId,
                    call: senderCallData,
                    isGroupChat: false,
                  )));
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await firestore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void makeGroupCall(
    Call senderCallData,
    BuildContext context,
    Call receiverCallData,
  ) async {
    try {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CallScreen(
                    channelId: senderCallData.callId,
                    call: senderCallData,
                    isGroupChat: true,
                  )));
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firestore
          .collection('groups')
          .doc(senderCallData.receiverId)
          .get();

      model.Group group = model.Group.fromMap(groupSnapshot.data()!);

      for(var id in group.membersUid){
        await firestore
          .collection('call')
          .doc(id)
          .set(receiverCallData.toMap());
      }
      
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endCall(
    String callerId,
    String recevierId,
    BuildContext context,
  ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(recevierId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endGroupCall(
    String callerId,
    String recevierId,
    BuildContext context,
  ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      var groupSnapshot = await firestore
          .collection('groups')
          .doc(recevierId)
          .get();
      
      model.Group group = model.Group.fromMap(groupSnapshot.data()!);
      for(var id in group.membersUid){
        await firestore.collection('call').doc(id).delete();
      }
      
      
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
