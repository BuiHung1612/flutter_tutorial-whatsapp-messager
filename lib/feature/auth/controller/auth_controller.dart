import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/feature/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  void sendSmsCode(
      {required BuildContext context, required String phoneNumber}) {
    authRepository.sendSmsCode(context: context, phoneNumber: phoneNumber);
  }

  void verifyOTPCode(
      {required BuildContext context,
      required String verificationId,
      required String otpCode,
      required bool mounted}) async {
    authRepository.verifyOTPCode(
        context: context,
        verificationId: verificationId,
        otpCode: otpCode,
        mounted: mounted);
  }

  void saveUserInfoToFireStore(
      {required String username,
      required var profileImage,
      required BuildContext context,
      required bool mounted}) {
    authRepository.saveUserInfoToFireStore(
        username: username,
        profileImage: profileImage,
        ref: ref,
        context: context,
        mounted: mounted);
  }
}
