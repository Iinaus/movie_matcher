import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:provider/provider.dart';

class SwipeableCards extends StatelessWidget {
  List<Widget> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text('1'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text('2'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: const Text('3'),
    )
  ];

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();

    var movies = appState.currentMovies;

    if (movies.isEmpty){
      return Text("No movies available");
    }

    return Flexible(
        child: CardSwiper(
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) {

              var baseUrl = "https://image.tmdb.org/t/p/w500";
              var posterPath = movies[index]["poster_path"];

              return Container(
                alignment: Alignment.center,
                child: Image.network(baseUrl + posterPath)
              );
            },
            cardsCount: movies.length));
  }
}
