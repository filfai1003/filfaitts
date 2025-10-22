import 'dart:io';

import 'package:filfaitts/backend/service/files_service.dart';
import 'package:filfaitts/backend/service/whisper_service.dart';
import 'package:filfaitts/backend/trascription.dart';
import 'package:flutter/material.dart';

import '../../backend/service/basic_service.dart';
import '../custom_widgets/custom_dropdown_button.dart';
import '../detailpage/detailpage.dart';
import 'input_widget.dart';
import 'progress_widget.dart';
import 'transcriptions_list.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final TextEditingController controller = TextEditingController();
  List<Trascription> transcriptions = [];
  List<Trascription> filteredTranscriptions = [];

  String currentlyProcessingFile = '';
  int currentProgress = 0;

  // models state
  List<String> models = ["tiny", "base", "small", "medium", "large-v3"];
  String selectedModel = "base";

  @override
  void initState() {
    super.initState();
    loadTranscriptions();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filfaitts'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: loadTranscriptions),
          IconButton(
            onPressed: () {
              FilesService.openAppFolder();
            },
            icon: const Icon(Icons.folder),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LicensePage(),
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProgressWidget(
                      currentlyProcessingFile: currentlyProcessingFile,
                      currentProgress: currentProgress,
                    ),
                    const SizedBox(height: 8),
                    TranscriptionsList(
                      transcriptions: filteredTranscriptions,
                      onTap: onTapTranscription,
                    ),
                  ],
                ),
              ),
            ),

            // Model dropdown (if models available)
            if (models.isNotEmpty) ...[
              ModelDropdown(
                models: models,
                selectedModel: selectedModel,
                onChanged: (s) {
                  setState(() {
                    selectedModel = s ?? selectedModel;
                  });
                },
              ),
              const SizedBox(height: 8),
            ],

            InputWidget(
              controller: controller,
              onSearchChanged: onSearchChanged,
              onAddPressed: onAddTranscription,
            ),
          ],
        ),
      ),
    );
  }

  void loadTranscriptions() {
    final Directory transcriptionsDir = BasicService.transcriptionsDir;
    final List<FileSystemEntity> files = transcriptionsDir.listSync();

    final List<Trascription> loaded = [];
    for (final file in files) {
      if (file is File && file.path.endsWith('.json')) {
        try {
          final transcription = Trascription.fromJsonFile(file);
          loaded.add(transcription);
        } catch (e) {
          // ignore malformed files
        }
      }
    }

    setState(() {
      transcriptions = loaded;
    });

    // apply current search filter
    onSearchChanged(controller.text);
  }

  void onTapTranscription(Trascription transcription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage2(transcription: transcription),
      ),
    );
  }

  void onSearchChanged(String value) {
    setState(() {
      filteredTranscriptions = transcriptions
          .where(
            (t) => t.title.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  Future<void> onAddTranscription() async {
    try {
      String filePath = await FilesService.loadAudioFile();
      if (currentlyProcessingFile == '') {
        updateCurrentFile('Loading...');
      }
      await FilesService.addToQueue(filePath);
      await WhisperService.runWhisper(
        updateCurrentFile,
        updateProgress,
        model: selectedModel,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void updateCurrentFile(String file) {
    setState(() {
      currentlyProcessingFile = file;
      if (file == '') {
        loadTranscriptions();
      }
    });
  }

  void updateProgress(int progress) {
    setState(() {
      currentProgress = progress;
    });
  }
}

