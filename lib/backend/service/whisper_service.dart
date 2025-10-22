import 'dart:convert';
import 'dart:io';

import 'basic_service.dart';

class WhisperService {

  static Future<void> runWhisper(Function(String) updateCurrentFile, Function(int) updateProgress, {String? model}) async {
    File isRunning_whisper = BasicService.getIsRunningWhisperFile();
    File whisperLogs = BasicService.getWhisperLogsFile();
    File whisperExe = BasicService.getWhisperExeFile();
    Directory queueDir = BasicService.getQueueDir();
    Directory transcriptionsDir = BasicService.getTranscriptionsDir();

    if (await isRunning_whisper.exists()) {
      return;
    }

    await isRunning_whisper.create();
    IOSink? sink;
    try {
      sink = whisperLogs.openWrite(mode: FileMode.append, encoding: utf8);
      await whisperLogs.writeAsString('', flush: true);

      // Build arguments: base args are queueDir and transcriptionsDir
      final args = [
        queueDir.path,
        transcriptionsDir.path,
      ];

      // If a model was specified, append --model <model>
      if (model != null && model.isNotEmpty) {
        args.addAll(['--model', model]);
      }

      final process = await Process.start(whisperExe.path, args, runInShell: true);

      // Stream stdout to log file (with timestamp)
      final stdoutFuture = process.stdout
          .transform(const Utf8Decoder(allowMalformed: true))
          .forEach((data) {
        if (data.isNotEmpty) {
          final timestamp = DateTime.now().toIso8601String();
          sink?.write('[$timestamp][whisper stdout] $data');

          final lines = data.split(RegExp(r'\r?\n'));
          for (var line in lines) {
            final trimmed = line.trim();
            if (trimmed.isEmpty) continue;
            if (trimmed.startsWith('Transcribing:')) {
              final fileName = trimmed.split(r'\').last.trim();
              if (fileName.isNotEmpty) updateCurrentFile(fileName);
            }
          }
        }
      });

      // Stream stderr to log file (with timestamp)
      final stderrFuture = process.stderr
          .transform(const Utf8Decoder(allowMalformed: true))
          .forEach((data) {
        if (data.isNotEmpty) {
          final timestamp = DateTime.now().toIso8601String();
          sink?.write('[$timestamp][whisper stderr] $data');

          // Process stderr line-by-line.
          final lines = data.split(RegExp(r'\r?\n'));
          for (var line in lines) {
            final trimmed = line.trim();
            if (trimmed.isEmpty) continue;

            // Extract percentage progress like "12%" (or up to 3 digits)
            final match = RegExp(r'(\d{1,3})%').firstMatch(trimmed);
            if (match != null) {
              final raw = int.tryParse(match.group(1)!) ?? 0;
              final progress = raw < 0 ? 0 : (raw > 100 ? 100 : raw);
              updateProgress(progress);
            }
          }
        }
      });

      // Wait for the process to exit, then wait for streams to complete
      final exitCode = await process.exitCode;
      await Future.wait([stdoutFuture, stderrFuture]);

      final timestamp = DateTime.now().toIso8601String();
      sink.writeln('[$timestamp][whisper exit] exitCode=$exitCode');
    } catch (e) {
      final timestamp = DateTime.now().toIso8601String();
      if (sink != null) {
        sink.writeln('[$timestamp][whisper error] $e');
      } else {
        // If sink is not available, print to console
        print('[$timestamp][whisper error] $e');
      }
    } finally {
      if (sink != null) {
        await sink.flush();
        await sink.close();
      }
      if (await isRunning_whisper.exists()) {
        await isRunning_whisper.delete();
        updateCurrentFile('');
        updateProgress(0);
      }
    }
  }
}