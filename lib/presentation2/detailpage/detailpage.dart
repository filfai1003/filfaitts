import 'package:filfaitts/backend/trascription.dart';
import 'package:flutter/material.dart';

class DetailPage2 extends StatefulWidget {
  final Trascription transcription;

  const DetailPage2({Key? key, required this.transcription}) : super(key: key);

  @override
  State<DetailPage2> createState() => _DetailPage2State();
}

class _DetailPage2State extends State<DetailPage2> {
  int _segmentMode = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transcription.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () => setState(() {
              _segmentMode++;
            }),
          ),
        ],
      ),
      body: _segmentMode % 3 == 1
          ? _segmentModeWidget()
          : _segmentMode % 3 == 2
          ? _fullSegmentModeWidget()
          : _textModeWidget(),
    );
  }

  Widget _textModeWidget() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SelectableText(
        widget.transcription.content,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }

  Widget _segmentModeWidget() {
    final theme = Theme.of(context);
    String bufferTime = '';
    String bufferContent = '';

    for (var segment in widget.transcription.segments) {
      bufferTime += '[${_formatTimestamp(segment.startTime)}]\n';
      bufferContent += '${segment.content}\n';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(bufferTime, style: theme.textTheme.bodyLarge),
          Expanded(child: SelectableText(bufferContent, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }

  Widget _fullSegmentModeWidget() {
    final theme = Theme.of(context);

    String buffer = '';
    for (var segment in widget.transcription.segments) {
      buffer += '[${_formatTimestamp(segment.startTime)}] ${segment.content} ';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SelectableText(
        buffer.toString(),
        style: theme.textTheme.bodyLarge,
      ),
    );
  }

  String _formatTimestamp(double seconds) {
    final int total = seconds.floor();
    final int hours = total ~/ 3600;
    final int mins = (total % 3600) ~/ 60;
    final int secs = total % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
