import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';

final contactsRepositoryProvider = Provider((ref) {
  return ContactRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ContactRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ContactRepository({required this.firestore, required this.auth});

  String replacePhoneNuber(String phoneNumber) {
    return phoneNumber
        .replaceAll(' ', '')
        .replaceAll('+84', '0')
        .replaceAll('-', '');
  }

  Future<List<List>> getAllContacts() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allContactsInThePhone =
            await FlutterContacts.getContacts(withProperties: true);
        bool isContactFound = false;

        for (var contact in allContactsInThePhone) {
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            var firebasePhoneNumber =
                replacePhoneNuber(firebaseContact.phoneNumber);

            if (replacePhoneNuber(contact.phones[0].number) ==
                    firebasePhoneNumber &&
                firebasePhoneNumber !=
                    replacePhoneNuber(auth.currentUser!.phoneNumber ?? '')) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
            if (!isContactFound) {
              phoneContacts.add(UserModel(
                  username: contact.displayName,
                  uid: '',
                  avatarUrl: '',
                  active: false,
                  lastSeen: 0,
                  phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
                  groupId: []));
            }
            isContactFound = false;
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return [firebaseContacts, phoneContacts];
  }
}
