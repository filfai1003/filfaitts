import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryProvider{
  static Directory? appDocumentsDir;
  static Directory? appTempDir;

  static Future<Directory> getDocumentsDir() async {
    if (appDocumentsDir == null) {
      try {
        appDocumentsDir = await getApplicationDocumentsDirectory();
      } catch (_) {
        appDocumentsDir = Directory.current;
      }
    }
    return appDocumentsDir!;
  }

  static Future<Directory> getAppTempDir() async {
    if (appTempDir == null) {
      try {
        appTempDir = await getTemporaryDirectory();
      } catch (_) {
        appTempDir = Directory.systemTemp;
      }
    }
    return appTempDir!;
  }
}