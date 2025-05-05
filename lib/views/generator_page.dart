import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:movie_matcher/widgets/set_username.dart';
import 'package:movie_matcher/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var movieMatch = context.watch<MovieMatchProvider>();

    if (movieMatch.userName.isEmpty) {
      return Center(child: SetUsername());
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(future: appState.fetchMovies(), builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if(snapshot.connectionState == ConnectionState.done 
            && !snapshot.hasError 
            && snapshot.hasData) { 
              return SwipeableCards(snapshot.data!);
            }

            return Text("Error fetching movies");

          })
        ],
      ),
    );
  }
}
