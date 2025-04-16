import 'dart:convert';
import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyAppState extends ChangeNotifier {

  List currentMovies = [];

  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

   var favorites = <WordPair>[];

   void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  Future<void> fetchMovies() async {

    try {
      var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=1');

      var response = await http.get(url, headers: {
        "accept":"application/json",
        "Authorization": "Bearer ${dotenv.env["TMBD_READ_ACCESS_KEY"]}"
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to load movies: ${response.statusCode}');        
      }

      var data = jsonDecode(response.body);

      if (data["results"] != null) {
        currentMovies.addAll(data["results"]);
      } else {
        throw Exception('No results found in the response');
      }

      notifyListeners();

    } catch (e) {
      rethrow;
    } finally {

    }
    
  }

}
