import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:filfaitts/backend/service/directory_provider.dart';

import 'basic_service.dart';

class FilesService {
  static Future<String> loadAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'wav',
          'mp3',
          'm4a',
          'mp4',
          'mpeg',
          'mpga',
          'webm',
          'ogg',
          'flac',
        ],
        allowMultiple: false,
        withData: false,
      );

      if (result == null) throw Exception('No file selected');

      final inputPath = result.files.single.path!;
      return inputPath;
    } catch (e) {
      throw Exception('Failed to convert audio: $e');
    }
  }

  static Future<void> addToQueue(String inputPath) async {
    Directory queueDir = BasicService.getQueueDir();

    String fileName = p.basename(inputPath);
    String newPath = p.join(queueDir.path, fileName);
    await File(inputPath).copy(newPath);
  }

  static Future<void> openAppFolder() async {
    Directory transcriptionsDir = await DirectoryProvider.getDocumentsDir();

    String path = transcriptionsDir.path + r"\filfaitts";
    Process.start('explorer', [path]);
  }
}
