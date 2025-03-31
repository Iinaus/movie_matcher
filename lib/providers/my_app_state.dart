import 'dart:convert';

import 'package:english_words/english_words.dart';
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

      var data = jsonDecode(response.body);

      currentMovies.addAll(data["results"]);

      notifyListeners();

    } finally {

    }
    
  }

}
