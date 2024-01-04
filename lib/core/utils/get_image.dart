import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class GetImage {
  static Future<Uint8List?> getImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      // File imageFile = File(image.path);
      return await _getImageBytes(image);
    }
    return null;
  }

  static Future<Uint8List> _getImageBytes(XFile image) async {
    return await image.readAsBytes();
  }
}