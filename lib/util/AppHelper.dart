import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class AppHelper {
  static Future<File> compress({
    required File image,
    int quality = 100,
    int percentage = 30,
  }) async {

    var path = await FlutterNativeImage.compressImage(
        image.absolute.path,
        quality: quality, percentage: percentage,

    );
    return path;
  }
}
