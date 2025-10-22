import 'dart:convert';
import 'dart:io';

class Segment {
  double startTime;
  double endTime;
  String content;

  Segment({
    required this.startTime,
    required this.endTime,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'content': content,
    };
  }

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      startTime: (json['startTime'] as num).toDouble(),
      endTime: (json['endTime'] as num).toDouble(),
      content: json['content'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Segment(startTime: $startTime, endTime: $endTime, content: $content)';
  }
}

class Trascription {
  String id;
  String title;
  DateTime date;
  List<Segment> segments;

  Trascription({
    required this.id,
    required this.title,
    required this.date,
    List<Segment>? segments,
  }) : segments = segments ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'segments': segments.map((s) => s.toJson()).toList(),
      'created_at': date.toIso8601String(),
    };
  }

  factory Trascription.fromJson(Map<String, dynamic> json) {
    final segmentsJson = json['segments'] as List<dynamic>?;
    final segments = segmentsJson != null
        ? segmentsJson
            .map((e) => Segment.fromJson(e as Map<String, dynamic>))
            .toList()
        : <Segment>[];


    return Trascription(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['created_at'] as String),
      segments: segments,
    );
  }

  factory Trascription.fromJsonFile(File file) {
    final jsonString = file.readAsStringSync();
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    return Trascription.fromJson(jsonData);
  }

  String get content {
    return segments.map((s) => s.content).join(' ');
  }
}