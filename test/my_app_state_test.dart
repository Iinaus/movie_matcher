import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_matcher/providers/my_app_state.dart';

void main() {
  group('MyAppState fetchMovies', () {
    late MyAppState appState;

    setUp(() async {
      await dotenv.load(fileName: ".env");
      appState = MyAppState();
    });

    test('fetchMovies populates currentMovies list', () async {
      await appState.fetchMovies();

      expect(appState.currentMovies, isNotEmpty);
    });

    test('fetchMovies throws error with invalid access token', () async {
      dotenv.env['TMBD_READ_ACCESS_KEY'] = 'invalid_token';  
      appState = MyAppState();

      expect(() async => await appState.fetchMovies(), throwsException);
    });

  });
}