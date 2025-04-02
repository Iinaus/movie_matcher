import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:movie_matcher/widgets/big_card.dart';
import 'package:movie_matcher/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => context.read<MovieMatchProvider>().send(),
              child: Text("Test grpc")),
          TextButton(
              onPressed: () => appState.fetchMovies(),
              child: Text("Fetch test")),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(appState.currentMovies[index]["title"]));
              },
              itemCount: appState.currentMovies.length,
            ),
          ),
          BigCard(pair: pair),
          SizedBox(height: 10),
          SwipeableCards()
        ],
      ),
    );
  }
}
