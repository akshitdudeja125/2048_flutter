// ignore_for_file: unused_import
import 'dart:html' as html;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void takeScreenShot(ScreenshotController screenshotController) async {
  if (!kIsWeb) {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/2048image.png').create();
        await imagePath.writeAsBytes(image);
        // await FlutterShare.shareFile(
        //   title: 'Share via',
        //   text: 'Share 2048 Game',
        //   filePath: imagePath.path,
        // );
        // await Share.shareFiles([imagePath.path]);
        await Share.shareXFiles([XFile(imagePath.path)]);
      }
    }).catchError((error) {
      throw (error);
    });
  } else {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/2048image.png').create();
        await imagePath.writeAsBytes(image);
        html.AnchorElement(
          href: imagePath.path,
        ).click();
      }
    }).catchError((error) {
      throw (error);
    });
  }
}
