import 'package:filfaitts/backend/service/basic_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation2/homepage/hompage.dart';
import 'presentation2/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BasicService.initializeAppDir();

  final mitText = await rootBundle.loadString('assets/LICENSE_whisper');

  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ['OpenAI Whisper (MIT License)'],
      mitText,
    );
  });

  runApp(const STTApp());
}

class STTApp extends StatelessWidget {
  const STTApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const HomePage2(),
    );
  }
}