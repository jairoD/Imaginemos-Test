import 'package:flutter/material.dart';
import 'package:imaginemosTest/blocs/customProvider.dart';
import 'package:imaginemosTest/blocs/myThemeBloc.dart';
import 'dart:async';
import 'package:imaginemosTest/layouts/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final myThemeBloc = MyThemeBloc();
  @override
  Widget build(BuildContext context) {
    return CustomProvider(
      myThemeBloc: myThemeBloc,
      child: StreamBuilder(
        initialData: false,
        stream: myThemeBloc.currentTheme,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                snapshot.data == false ? ThemeData.light() : ThemeData.dark(),
            home: Index(),
          );
        },
      ),
    );
  }
}
