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

  @override
  Stream<StateMessage> streamState(ServiceCall call, Stream<StateMessage> request) {
    
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen((msg) {

      print(msg.data);

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