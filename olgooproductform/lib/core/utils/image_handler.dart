import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {
  File? _image;
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) {
      return null;
    } else {
      return File(croppedImage.path);
    }
  }

  Future<void> pickAndCropImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File img = File(image.path);
      final cropped = await _cropImage(imageFile: img);
      if (cropped == null) return;
      _image = cropped;
    } catch (e) {
      print(e);
    }
  }

  File? get getImage => _image;
}
