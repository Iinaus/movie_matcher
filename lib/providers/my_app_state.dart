import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_matcher/models/movie.dart';
import 'package:movie_matcher/widgets/confirm_delete.dart';

class MyAppState extends ChangeNotifier {

  int _currentPage = 1;
  var favorites = <Movie>[];
  var skippedMovies = <Movie>[];  

  void incrementCurrentPage() {
    _currentPage++;
    fetchMovies();
    notifyListeners();
  }

  void addSkippedMovie(Movie movie) {
    if (!skippedMovies.any((skipped) => skipped.id == movie.id && skipped.originalTitle == movie.originalTitle)) {
      skippedMovies.add(movie);
    }
  }

  void addFavorite(Movie movie) {
    if (!favorites.any((fav) => fav.id == movie.id && fav.originalTitle == movie.originalTitle)) {
      favorites.add(movie);
    }
  }

  void deleteFavorite(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDelete(
        movie: movie,
        onDelete: () {
          favorites.remove(movie);
          notifyListeners();
        },
      ),
    ); 
  }

  Future<List<Movie>> fetchMovies() async {

    try {
      var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=$_currentPage');

      var response = await http.get(url, headers: {
        "accept":"application/json",
        "Authorization": "Bearer ${dotenv.env["TMBD_READ_ACCESS_KEY"]}"
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to load movies: ${response.statusCode}');        
      }

      var data = jsonDecode(response.body) as Map<String, dynamic>;

      List moviesJson = data["results"];

      return moviesJson.map((movieJson) => Movie.fromJson(movieJson)).toList();

    } catch (e) {
      rethrow;
    } finally {

    }
    
  }

}
