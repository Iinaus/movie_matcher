import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:movie_matcher/generated/moviematch.pbgrpc.dart';

Future<void> main() async {

  final server = Server.create(services: [MovieMatchService()]);

  final port = 50051;

  await server.serve(port: port);

  print('MovieMatch gRPC server running on port $port');

}

class MovieMatchService extends MovieMatchServiceBase {

  final Map<String, StreamController<StateMessage>> clients = {};
  final Map<String, List<String>> userValues = {};

  MovieMatchService() {
    userValues['TestUser'] = [
      'Exterritorial',
      'Thunderbolts*',
      'A Working Man',
      'Havoc',
      'A Minecraft Movie',
      'Tarzan',
      'Rust',
      'Death of a Unicorn',
      'ज्वेल थीफ: द हीस्ट बिगिन्स',
      'Captain America: Brave New World',
    ];
  }

  @override
  Stream<StateMessage> streamState(ServiceCall call, Stream<StateMessage> request) {
    
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen((msg) {

      print(msg);

      currentUser = msg.user;
      clients[msg.user] = controller;

      if (userValues.containsKey(msg.user)) {
        userValues[msg.user]?.add(msg.data);
      } else {
        userValues[msg.user] = [msg.data];
      }

      for (var entry in userValues.entries) {
        if (entry.key != msg.user && entry.value.contains(msg.data)) {

          final matchMessage = StateMessage()
            ..user = 'server'
            ..data = msg.data;

          clients[entry.key]?.add(matchMessage);
          clients[msg.user]?.add(matchMessage);

        }
      }
    }, onDone: (){

      if (currentUser != null) {

        clients.remove(currentUser);
        userValues.remove(currentUser);

      }

    });

    return controller.stream;

  }

}