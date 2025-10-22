import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import 'directory_provider.dart';

class BasicService {

  static bool isInit = false;
  static late Directory queueDir;
  static late Directory transcriptionsDir;
  static late Directory modelsDir;
  static late File isRunning_whisper;
  static late File whisperLogs;
  static late File whisperExe;

  static Future<void> initializeAppDir() async {
    Directory documentsDir = await DirectoryProvider.getDocumentsDir();
    documentsDir = Directory(p.join(documentsDir.path, 'filfaitts'));

    // Create queueDir
    queueDir = Directory(p.join(documentsDir.path, 'queue'));
    if (!await queueDir.exists()) {
      await queueDir.create(recursive: true);
    }

    // Create transcriptionsDir
    transcriptionsDir = Directory(p.join(documentsDir.path, 'transcriptions'));
    if (!await transcriptionsDir.exists()) {
      await transcriptionsDir.create(recursive: true);
    }

    // Prepare control file for running whisper
    isRunning_whisper = File(
      p.join(documentsDir.path, 'isRunning_whisper.txt'),
    );
    if (await isRunning_whisper.exists()) {
      await isRunning_whisper.delete();
    }

    // Prepare log file for whisper
    whisperLogs = File(p.join(documentsDir.path, 'whisper_logs.txt'));
    if (!await whisperLogs.exists()) {
      await whisperLogs.create(recursive: true);
    }

    // Copy transcriber.exe from assets to documentsDir if it doesn't exist
    whisperExe = File(p.join(documentsDir.path, 'transcriber.exe'));
    if (!await whisperExe.exists()) {
      // Load as bytes (binary) and write bytes to disk
      final byteData = await rootBundle.load('assets/transcriber.exe');
      final bytes = byteData.buffer.asUint8List();
      await whisperExe.writeAsBytes(bytes, flush: true);
    }

    isInit = true;
  }

  static Directory getQueueDir() {
    if (!isInit) {
      throw Exception('SetupService not initialized. Call initializeAppDir() first.');
    }
    return queueDir;
  }

  static Directory getTranscriptionsDir() {
    if (!isInit) {
      throw Exception('SetupService not initialized. Call initializeAppDir() first.');
    }
    return transcriptionsDir;
  }

  static File getIsRunningWhisperFile() {
    if (!isInit) {
      throw Exception('SetupService not initialized. Call initializeAppDir() first.');
    }
    return isRunning_whisper;
  }

  static File getWhisperLogsFile() {
    if (!isInit) {
      throw Exception('SetupService not initialized. Call initializeAppDir() first.');
    }
    return whisperLogs;
  }

  static File getWhisperExeFile() {
    if (!isInit) {
      throw Exception('SetupService not initialized. Call initializeAppDir() first.');
    }
    return whisperExe;
  }

}