import 'package:flutter/material.dart';
import 'package:imaginemosTest/blocs/myThemeBloc.dart';

class CustomProvider extends InheritedWidget {
  CustomProvider({Key key, this.child, this.myThemeBloc})
      : super(key: key, child: child);

  final Widget child;
  // declaramos una instancia de myThemeBloc la cual se compartira en todo el arbol de widgets
  // y podra ser accedida en cualquier momento
  final MyThemeBloc myThemeBloc;

  // enviar myThemeBloc a todo el arbol
  static CustomProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomProvider>();
  }

  // funcion para escuchar cuando cambie myThemeBloc
  @override
  bool updateShouldNotify(CustomProvider oldWidget) {
    return true;
  }
}
