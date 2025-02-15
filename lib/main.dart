import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/src/business_logic/bloc/speech_bloc.dart';
import 'package:text_to_speech/src/data/services/speach_service.dart';
import 'package:text_to_speech/src/presentation/screens/home_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final speechService = SpeechService();
  await speechService.initialize();  // Ensure speech is initialized

  runApp(MyApp(speechService: speechService));
}

class MyApp extends StatelessWidget {
  final SpeechService speechService;

  MyApp({required this.speechService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechBloc(speechService),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}