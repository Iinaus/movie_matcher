import 'package:flutter/material.dart';
import 'package:movie_matcher/providers/moviematch.dart';
import 'package:movie_matcher/providers/my_app_state.dart';
import 'package:movie_matcher/views/my_home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  print("${dotenv.env["TMBD_READ_ACCESS_KEY"]}");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyAppState()),
      ChangeNotifierProvider(create: (_) => MovieMatchProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Matcher',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: MyHomePage(),
    );
  }
}
