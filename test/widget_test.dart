import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_matcher/generated/moviematch.pb.dart';
import 'package:movie_matcher/models/movie.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:movie_matcher/views/generator_page.dart';
import 'package:movie_matcher/widgets/set_username.dart';
import 'package:movie_matcher/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class FakeMovieMatchProvider extends ChangeNotifier implements MovieMatchProvider {
  @override
  StateMessage? newMessage;

  @override
  String userName = '';

  @override
  void clearMessage() {
  }

  @override
  void send(movieName) {
  }

  @override
  void setUserName(String name) {
    userName = name;
  }
  
}

void main() {
  testWidgets('If username is empty, GeneratorPage renders SetUsername', (WidgetTester tester) async {    

    final appState = MyAppState();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MyAppState>.value(value: appState),
          ChangeNotifierProvider<MovieMatchProvider>(create: (_) => FakeMovieMatchProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: GeneratorPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SetUsername), findsOneWidget);
  });

  testWidgets('If username is not empty, but snapshot doesnt have data, GeneratorPage renders error message', (WidgetTester tester) async {    

    final appState = MyAppState();
    final movieMatch = FakeMovieMatchProvider();
    movieMatch.setUserName("Iina");

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MyAppState>.value(value: appState),
          ChangeNotifierProvider<MovieMatchProvider>.value(value: movieMatch),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: GeneratorPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();    

    expect(find.text("Error fetching movies"), findsOneWidget);
  });
}