import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordPageState(),
      child: _WordSection(),
    );
  }
}

class WordPageState extends ChangeNotifier {
  var currentWord = WordPair.random();
  void nextWord() {
    currentWord = WordPair.random();
    notifyListeners(); // any watchers of this state are notified
  }

  var favourites = <WordPair>{};
  void toggleFavourite() {
    if (favourites.contains(currentWord)) { favourites.remove(currentWord); }
    else { favourites.add(currentWord); }
    notifyListeners();
  }
}

class _WordSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var wordPageState = context.watch<WordPageState>();
    final theme = Theme.of(context);
    // use the preset displayMedium text theme with an updated color
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary);
    var likeIcon = wordPageState.favourites.contains(wordPageState.currentWord) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('A Random Word:'),
        const SizedBox(height: 10,),
        Card(
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(wordPageState.currentWord.asPascalCase, style: style),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () { wordPageState.toggleFavourite(); },
              icon: likeIcon,
              label: const Text("Like"),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
                onPressed: () { wordPageState.nextWord(); },
                child: const Text("Next")
            ),
          ],
        ),
        wordPageState.favourites.isNotEmpty ? _FavouritesSection() : Container(),
      ],
    );
  }
}

class _FavouritesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageState = context.watch<WordPageState>();

    return Column(
      children: [
        const SizedBox(height: 50,),
        Text('Favorites:', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10,),
        Wrap(
          children: pageState.favourites.map((f) =>
              Padding(padding: const EdgeInsets.all(10), child: Text(f.asPascalCase),)
          ).toList(),
        ),
      ],
    );
  }
}
