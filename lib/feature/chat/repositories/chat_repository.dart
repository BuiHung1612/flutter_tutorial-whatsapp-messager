import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/enum/message_type.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/models/last_message_model.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<LastMessageModel> contacts = [];
      for (var document in event.docs) {
        final lastMessage = LastMessageModel.fromMap(document.data());
        final userData = await firestore
            .collection('users')
            .doc(lastMessage.contactId)
            .get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(LastMessageModel(
            username: user.username,
            avatarUrl: user.avatarUrl,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage));
      }
      return contacts;
    });
  }

  void sendTextMessage(
      {required BuildContext context,
      required String textMessage,
      required String receiverId,
      required UserModel senderData}) async {
    try {
      print(
        'receiverId' + receiverId,
      );
      final timeSent = DateTime.now();
      final receiverDataMap =
          await firestore.collection('users').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();
      saveToMessageCollection(
          textMessage: textMessage,
          textMessageId: textMessageId,
          timeSent: timeSent,
          receiverId: receiverId,
          senderUsername: senderData.username,
          receiverUsername: receiverData.username,
          messageType: MessageType.text);

      saveAsLastMessage(
          senderUserData: senderData,
          receiverUserData: receiverData,
          lastMessage: textMessage,
          timeSent: timeSent,
          receiverId: receiverId);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void saveToMessageCollection({
    required String textMessage,
    required String textMessageId,
    required DateTime timeSent,
    required String receiverId,
    required String senderUsername,
    required String receiverUsername,
    required MessageType messageType,
  }) async {
    final message = MessageModel(
        senderId: auth.currentUser!.uid,
        receiverId: receiverId,
        textMessage: textMessage,
        type: messageType,
        timeSent: timeSent,
        messageId: textMessageId,
        isSeen: false);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String lastMessage,
    required DateTime timeSent,
    required String receiverId,
  }) async {
    final receiverLastMessage = LastMessageModel(
        username: senderUserData.username,
        avatarUrl: senderUserData.avatarUrl,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: lastMessage);
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
        username: receiverUserData.username,
        avatarUrl: receiverUserData.avatarUrl,
        contactId: receiverUserData.uid,
        timeSent: timeSent,
        lastMessage: lastMessage);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }
}
