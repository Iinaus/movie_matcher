import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/moviematch.dart';
import '../providers/my_app_state.dart';

class SwipeableCards extends StatelessWidget {

  final List<Movie> movies;

  final CardSwiperController controller = CardSwiperController();

  SwipeableCards(this.movies);

  @override
  Widget build(BuildContext context) {

    var appState = context.read<MyAppState>();    
    var movieMatch = context.read<MovieMatchProvider>();

    List<Movie> filteredMovies = movies.where((movie) {
      return !appState.favorites.any((favorite) => favorite.id == movie.id)
          && !appState.skippedMovies.any((skipped) => skipped.id == movie.id);
    }).toList();

    if (filteredMovies.isEmpty || filteredMovies.length == 1){
      return Text("No movies available");
    }

    return Column(
      children: [
        SizedBox(
          height: 500,
          child: CardSwiper(
              controller: controller,
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) {

                var baseUrl = "https://image.tmdb.org/t/p/w500";
                var posterPath = filteredMovies[index].posterPath;
                var fullImageUrl = baseUrl + posterPath;

                return Container(
                  alignment: Alignment.center,
                  child: Image.network(fullImageUrl)
                );
              },
              cardsCount: filteredMovies.length,
              onSwipe: (oldIndex, currentIndex, direction) async {
                print("$oldIndex $currentIndex $direction");

                if (direction == CardSwiperDirection.right) {
                  movieMatch.send(filteredMovies[oldIndex].originalTitle);
                  appState.addFavorite(filteredMovies[oldIndex]);
                }

                if (direction == CardSwiperDirection.left) {
                  appState.addSkippedMovie(filteredMovies[oldIndex]);
                }

                return true;
              },
              isLoop: false,
              allowedSwipeDirection: AllowedSwipeDirection.only(
                left: true,
                right: true,
              ),
            ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () { controller.swipe(CardSwiperDirection.left); },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.red,
              ),
              child: Icon(Icons.close, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () { controller.swipe(CardSwiperDirection.right); },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.green,
              ),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
