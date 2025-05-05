import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:movie_matcher/generated/moviematch.pbgrpc.dart';

class MovieMatchProvider extends ChangeNotifier {

  late final ClientChannel _channel;
  late final MovieMatchClient _stub;
  late final StreamController<StateMessage> _send;
  late final ResponseStream<StateMessage> _receive;
  String userName = "";

  MovieMatchProvider() {

    _channel = ClientChannel('10.0.2.2', 
      port: 50051, 
      options: ChannelOptions(credentials: ChannelCredentials.insecure()));

    _stub = MovieMatchClient(_channel);
    _send = StreamController<StateMessage>();
    _receive = _stub.streamState(_send.stream);

    _receive.listen((msg) {
      print("message: ${msg.user}: ${msg.data}");
    });
  }

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  //jatkokehitys: pelkän nimen perusteella hakeekin ID ja sen kautta kaikki tiedot
  void send(movieName) {

    var msg = StateMessage()
      ..data = movieName
      ..user = userName;

    _send.add(msg);

    print("Message sent: ${msg.user} - ${msg.data}");
  }

}