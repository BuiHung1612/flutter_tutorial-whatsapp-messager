import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_messenger/common/extentions/custom_theme_extention.dart';
import 'package:whatsapp_messenger/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/common/widgets/short_h_bar.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/pages/image_picker_page.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key});

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;

  saveUserDataToFirebase() {
    String username = usernameController.text;
    if (username.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please provide a username");
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
          context: context,
          message: "A username length should be between 3-20");
    }
    ref.read(authControllerProvider).saveUserInfoToFireStore(
        username: username,
        profileImage: imageCamera ?? imageGallery ?? '',
        context: context,
        mounted: mounted);
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Profile photo',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: CustomIconButton(
                        onTap: () => Navigator.of(context).pop(),
                        icon: Icons.close),
                  )
                ],
              ),
              Divider(
                color: context.theme.greyColor!.withOpacity(0.3),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  imagePickerIcon(
                      onTap: pickImageFromCamera,
                      icon: Icons.camera_alt_rounded,
                      text: "Camera"),
                  const SizedBox(
                    width: 15,
                  ),
                  imagePickerIcon(
                      onTap: () async {
                        Navigator.pop(context);
                        final image = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ImagePickerPage()));

                        if (image == null) return;
                        setState(() {
                          imageGallery = image;
                          imageCamera = null;
                        });
                      },
                      icon: Icons.photo_camera_back_rounded,
                      text: "Gallary")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  imagePickerIcon(
      {required VoidCallback onTap,
      required IconData icon,
      required String text}) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          iconColor: AppColor.greenDark,
          minWidth: 50,
          border: Border.all(
              width: 1, color: context.theme.greyColor!.withOpacity(.2)),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        )
      ],
    );
  }

  pickImageFromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          imageGallery = null;
          imageCamera = File(image.path);
        });
      }
    } catch (e) {
      if (context.mounted) {
        showAlertDialog(context: context, message: e.toString());
      }
    }
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    usernameController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile info",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Please provide your name and an optional profile photo",
            textAlign: TextAlign.center,
            style: TextStyle(color: context.theme.greyColor),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: imagePickerTypeBottomSheet,
            child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: imageCamera != null || imageGallery != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: imageGallery != null
                                ? MemoryImage(imageGallery!) as ImageProvider
                                : FileImage(imageCamera!))
                        : null,
                    border: Border.all(
                        color: imageCamera == null && imageGallery == null
                            ? Colors.transparent
                            : context.theme.greyColor!.withOpacity(0.4)),
                    color: context.theme.photoIconBgColor),
                child: Icon(
                  Icons.add_a_photo_rounded,
                  size: 48,
                  color: imageCamera == null && imageGallery == null
                      ? context.theme.photoIconColor
                      : Colors.transparent,
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomTextField(
                controller: usernameController,
                hintText: "Type your name here",
                autoFocus: true,
                textAlign: TextAlign.left,
              )),
              Icon(
                Icons.emoji_emotions_outlined,
                color: context.theme.photoIconColor,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: "NEXT",
        buttonWidth: 90,
      ),
    );
  }
}
