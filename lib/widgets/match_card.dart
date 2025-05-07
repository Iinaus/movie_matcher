import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:provider/provider.dart';

class MatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var movieMatch = context.watch<MovieMatchProvider>();

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("It's a match!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 10),
            Text("You both like movie ${movieMatch.newMessage?.data}."),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    movieMatch.clearMessage();
                  },
                  child: Text("Continue"),
                ),
                TextButton(
                  onPressed: () {
                    // to-do: show movie card information
                  },
                  child: Text("Show movie"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
