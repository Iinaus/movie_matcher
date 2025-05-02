import 'dart:convert';
import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_matcher/models/movie.dart';

class MyAppState extends ChangeNotifier {

  List currentMovies = [];

  var favorites = <Movie>[];

  void addFavorite(Movie movie) {
    if (!favorites.any((fav) => fav.id == movie.id && fav.originalTitle == movie.originalTitle)) {
      favorites.add(movie);
    }
  }

  void deleteFavorite(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Comfirm deletion"),
          content: Text("Are you sure you want to delete '${movie.originalTitle}' from your favorites?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                favorites.remove(movie);
                notifyListeners();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${movie.originalTitle} has been deleted from favorites!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<List<Movie>> fetchMovies() async {

    try {
      var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=1');

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
