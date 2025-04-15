import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:movie_matcher/views/generator_page.dart';
import 'package:provider/provider.dart';

class FakeMovieMatchProvider extends ChangeNotifier implements MovieMatchProvider {
  @override
  void send() {}
}

void main() {
  testWidgets('GeneratorPage has two text buttons', (WidgetTester tester) async {    

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

    expect(find.text('Test grpc'), findsOneWidget);
    expect(find.text('Fetch test'), findsOneWidget); 
  });
}