// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:findjobs/constants/app_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

class ImageNotifier extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = await cropImage(_imageFile);
    if (_imageFile != null) {
      imageUpload(_imageFile);
      imageFil.add(_imageFile.path);
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage(XFile? imageFile) async {
    if (imageFile != null) {
      CroppedFile? cropedFile = await ImageCropper.platform.cropImage(
          sourcePath: imageFile.path,
          maxHeight: 600,
          maxWidth: 600,
          compressQuality: 70,
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio5x4
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "FindJobs Croper",
              toolbarColor: Color(kLightBlue.value),
              toolbarWidgetColor: Color(kLight.value),
              initAspectRatio: CropAspectRatioPreset.ratio5x4,
            ),
            IOSUiSettings(
              title: "FindJobs Croper",
            )
          ]);
      if (cropedFile != null) {
        notifyListeners();
        return XFile(cropedFile.path);
      } else {
        return null;
      }
    }
    return null;
  }

  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);
    final ref = FirebaseStorage.instance.ref().child("${uuid.v1()}.jpg");
    await ref.putFile(image);
    imageUrl = (await ref.getDownloadURL());
    return imageUrl;
  }
}
