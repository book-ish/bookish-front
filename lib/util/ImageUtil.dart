
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'AppHelper.dart';

class ImageUtil {

  static Future<File> getImage(ImageSource imageSource) async {
    final picker = ImagePicker();

    final imageXFile = await picker.pickImage(source: imageSource, imageQuality: 100);

    var compressedImage = await AppHelper.compress(image: File(imageXFile!.path));
    return compressedImage;
  }


}