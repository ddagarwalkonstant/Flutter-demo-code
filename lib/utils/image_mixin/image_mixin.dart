import 'dart:io';

import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../debug_utils/debug_utils.dart';
import '../permission/permission_util.dart';


mixin ImageMixin {
  final ImagePicker _imagePicker = ImagePicker();
  static bool _hasPopped = false;

  //camera dialog
  Future<File?> openImagePicker(
      BuildContext context,
      int size,
      AndroidDeviceInfo? info, {
        int? multiImageSize,
      })  async {
    _hasPopped = false;
    final imageFile = await showCupertinoModalPopup<File>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text(AppStrings.txtSelectPhoto),
          actions: [
            CupertinoActionSheetAction(
              child: const Text(AppStrings.txtCamera, style: TextStyle(color: Colors.black),),
              onPressed: () async {
                try {
                  await getImage(
                    context,
                    ImageType.camera,
                    Permission.camera,
                    size,
                  ).then((value) {
                    Navigator.pop(context, value);
                  }
                  );
                } on Exception catch (e) {
                  DebugUtils.showLog(e.toString());
                  if (!_hasPopped) {
                    Navigator.pop(context);
                    _hasPopped = true;
                  }
                }
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(AppStrings.txtGallery, style: TextStyle(color: Colors.black),),
              onPressed: () async {
                try {
                  await getImage(
                    context, ImageType.gallery, Platform.isIOS || Platform.isAndroid && info != null && info.version.sdkInt >= 33 ? Permission.photos : Permission.storage,
                    size,
                    multiImageSize: multiImageSize,
                  ).then((value) {
                    Navigator.pop(context, value);
                  });
                } on Exception catch (e) {
                  DebugUtils.showLog(e.toString());
                  if (!_hasPopped) {
                    Navigator.pop(context);
                    _hasPopped = true;
                  }
                }
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text('Cancel', style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );

    return imageFile;
  }

  //getImageFromGallery question
  Future<File?> getImageFromGallery(int size, {int? multiImageSize}) async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: size,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }


  //getImageFromCamera question
  Future<File?> getImageFromCamera(int size) async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: size,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  //get image file from camera / gallery
  Future<File?> getImage(
      BuildContext context,
      ImageType getImageType,
      Permission permissionType,
      int size, {
        int? multiImageSize,
      }) async {
    // final PermissionStatus? permissionStatus =
    final permissionStatus = await PermissionUtil.getPermission(permissionType);

    // if (permissionStatus == PermissionStatus.granted ||
    //     permissionStatus == PermissionStatus.limited) {
      if (getImageType == ImageType.camera) {
        final file = await getImageFromCamera(size);
        if (file != null) {
          return file;
        }
      } else {
        File? file;
        file = await getImageFromGallery(size);

        if (file != null) {
          return file;
        }
      }
    // }
    /*else {
      // ignore: use_build_context_synchronously
      await PermissionUtil.showActionDialog(
        context: context,
        description: permissionType == Permission.camera
            ? Constants.txtCameraPermission
            : Constants.txtGalleryPermission,
        title: permissionType == Permission.camera
            ? Constants.txtThisAppNeedsCameraAccess
            : Platform.isIOS
            ? Constants.txtThisAppNeedsGalleryAccess
            : Constants.txtThisAppNeedsStorageAccess,
      );
      /* await Future.delayed(const Duration(milliseconds: 500), () {


        if (!hasPopped) {
          Navigator.pop(context);
          hasPopped = true;
        }
      });*/
    }*/
    return null;

    //return null;
  }

}

class MultiImageContainer {
  final List<File> files;
  final String? errorMsg;

  MultiImageContainer(this.files, this.errorMsg);
}

enum ImageType { camera, gallery }
