import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
        
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:',
              style: style,),
        ),
        for (var movie in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(movie.originalTitle),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                appState.deleteFavorite(context, movie);
              },
            )
          ),          
      ],
    );
  }
}