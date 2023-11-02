import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/models/user_modal.dart';
import 'package:whatsapp_messenger/feature/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userInfoAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserInfo();
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

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void updateUserPresence() {
    return authRepository.updateUserPresence();
  }

  Stream<UserModel> getUserPresenceStatus({required String uid}) {
    return authRepository.getUserPresenceStatus(uid: uid);
  }
}
