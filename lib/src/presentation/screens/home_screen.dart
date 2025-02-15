import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/speach_state.dart';
import '../../business_logic/bloc/speech_bloc.dart';
import '../widgets/speak_button.dart';

class HomeScreen extends StatelessWidget {
//   final List<String> targetWords = [
//   "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
//   "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
//   "الرَّحْمَٰنِ الرَّحِيمِ",
//   "مَالِكِ يَوْمِ الدِّينِ",
//   "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
//   "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ",
//   "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ",
// ];
  final List<String> targetWords = [
  "Hello Flutter",
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Speech Recognition")),
      body: Center(
        child: BlocBuilder<SpeechBloc, SpeechState>(
          builder: (context, state) {
            List<bool> wordMatches = [];
             String recognizedWords = "";
            if (state is SpeechSuccess) {
              wordMatches = state.wordMatches;
               recognizedWords = state.recognizedWords;
            }

            List<String> words = targetWords.expand((sentence) => sentence.split(' ')).toList();
            List<String> recognizedList = recognizedWords.split(' ');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8, // Space between words
                  children: List.generate(words.length, (index) {
                    Color textColor = Colors.black; // Default color
                    if (state is SpeechSuccess) {
                      textColor = wordMatches[index] ? Colors.green : Colors.red;
                    }

                    return Text(
                      words[index],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                SpeakButton(targetWords: words), // **Button stays here**
                SizedBox(height: 20),

                // Recognized Words
                Text(
                  "You said: ${recognizedWords.isNotEmpty ? recognizedWords : "..." }",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}