import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/helper/show_loading_dialog.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/common/repository/firebase_storage_repository.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      firebaseDatabase: FirebaseDatabase.instance);
});

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase firebaseDatabase;

  AuthRepository(
      {required this.firebaseAuth,
      required this.firestore,
      required this.firebaseDatabase});

  Stream<UserModel> getUserPresenceStatus({required String uid}) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void updateUserPresence() async {
    Map<String, dynamic> online = {
      'active': true,
      "lastSeen": DateTime.now().millisecondsSinceEpoch
    };

    Map<String, dynamic> offline = {
      'active': false,
      "lastSeen": DateTime.now().millisecondsSinceEpoch
    };

    final connectedRef = firebaseDatabase.ref('.info/connected');
    connectedRef.onValue.listen((event) async {
      final isConnected = event.snapshot.value as bool? ?? false;

      if (isConnected) {
        await firebaseDatabase
            .ref()
            .child(firebaseAuth.currentUser!.uid)
            .update(online);
        await firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update(offline);
      } else {
        await firebaseDatabase
            .ref()
            .child(firebaseAuth.currentUser!.uid)
            .onDisconnect()
            .update(offline);
        await firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update(offline);
      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFireStore(
      {required String username,
      required var profileImage,
      required ProviderRef ref,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context: context, message: "Saving user info...");
      String uid = firebaseAuth.currentUser!.uid;
      String avatarUrl = profileImage is String ? profileImage : '';

      if (profileImage != null && profileImage is! String) {
        avatarUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storageFileToFirebase('profileImage/$uid', profileImage);
      }

      UserModel user = UserModel(
          lastSeen: DateTime.now().millisecondsSinceEpoch,
          username: username,
          uid: uid,
          avatarUrl: avatarUrl,
          active: true,
          phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
          groupId: []);
      await firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      showLoadingDialog(
          context: context,
          message: "Sending a verification code to $phoneNumber");
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          showAlertDialog(context: context, message: error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verification, (route) => false, arguments: {
            'phoneNumber': phoneNumber,
            'verificationId': verificationId
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuth catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifyOTPCode(
      {required BuildContext context,
      required String verificationId,
      required String otpCode,
      required bool mounted}) async {
    try {
      showLoadingDialog(context: context, message: "Verifiying code...");
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);
      UserModel? user = await getCurrentUserInfo();

      await firebaseAuth.signInWithCredential(credential).then((value) async {
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.userInfo, (route) => false,
              arguments: user?.avatarUrl);
        }
      }).catchError((error) {
        Navigator.pop(context);
        showAlertDialog(context: context, message: error.toString());
      });
    } on FirebaseAuth catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showAlertDialog(context: context, message: e.toString());
      }
    }
  }
}
