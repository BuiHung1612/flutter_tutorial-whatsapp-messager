import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/enum/message_type.dart';
import 'package:whatsapp_messenger/common/models/last_message_model.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/chat/repositories/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return chatRepository.getAllOneToOneMessage(receiverId);
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return chatRepository.getAllLastMessageList();
  }

  void sendTextMessage(
      {required BuildContext context,
      required String textMessage,
      required String receiverId}) {
    ref.read(userInfoAuthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            textMessage: textMessage,
            receiverId: receiverId,
            senderData: value!));
  }

  void sendFileMessage(
      {required BuildContext context,
      required var file,
      required String receiverId,
      required MessageType messageType}) {
    ref.read(userInfoAuthProvider).whenData((value) {
      return chatRepository.sendFileMessage(
          context: context,
          file: file,
          receiverId: receiverId,
          senderData: value!,
          ref: ref,
          messageType: messageType);
    });
  }
}
