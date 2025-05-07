import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:provider/provider.dart';

class MatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var movieMatch = context.watch<MovieMatchProvider>();
  
    return AlertDialog(
      title: Text("It is a match!"),
      content: Text("You both like movie ${movieMatch.newMessage?.data}."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            movieMatch.clearMessage();
          },
          child: Text("Continue"),
        ),
        TextButton(
          onPressed: () {
            // to-do: show movie card infomation
          },
          child: Text("Show movie"),
        ),
      ],
    );
  }
}
