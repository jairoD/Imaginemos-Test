import 'dart:async';

import 'package:flutter/material.dart';

class MyThemeBloc {
  // definimos el StreamController como broadcast de manera que multiples Streams puedan escucharlo
  final _myThemeBlocController = StreamController<bool>.broadcast();

  //agregar datos
  get changeTheme => _myThemeBlocController.sink.add;

  //obtener datos
  get currentTheme => _myThemeBlocController.stream;

  void change() {
    _myThemeBlocController.stream.asBroadcastStream();
  }

  void dispose() {
    _myThemeBlocController.close();
  }
}
