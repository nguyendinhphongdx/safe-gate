import 'dart:io';

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/permission_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../resource/keylanguage_resource/key_language.dart';

class PickImgBottomSheetDialog extends StatelessWidget {
  const PickImgBottomSheetDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.camera_fill),
            title: Text(
              KeyLanguage.camera.tr,
              style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8)),
            ),
            onTap: () async {
              bool checkPermission = true;
              if (!kIsWeb) {
                checkPermission = await PermissionConfig.instance.request(
                  permission: Permission.camera,
                  title: KeyLanguage.camera,
                  content: KeyLanguage.question_camera.tr,
                );
              }
              if (checkPermission) {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

                if (pickedImage != null) {
                  Navigator.pop(context, pickedImage);
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
            title: Text(
              KeyLanguage.image_gallery.tr,
              style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8)),
            ),
            onTap: () async {
              bool checkPermission = true;
              if (!kIsWeb) {
                checkPermission = await PermissionConfig.instance.request(
                  permission: Permission.photos,
                  title: KeyLanguage.image_gallery,
                  content: KeyLanguage.question_image_gallery.tr,
                );
              }
              if (checkPermission) {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  Navigator.pop(context, pickedImage);
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
