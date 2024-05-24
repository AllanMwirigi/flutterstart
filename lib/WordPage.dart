import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordPageState(),
      child: WordSection(),
      // child: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //     title: const Text('Word Gen'),
      //   ),
      //   body: WordSection(),
      // ),
    );
  }

}

class WordPageState extends ChangeNotifier {
  var currentWord = WordPair.random();
}

class WordSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<WordPageState>();
    return Column(children: [const Text('A random Idea:'), Text(state.currentWord.asLowerCase)],);
  }
}