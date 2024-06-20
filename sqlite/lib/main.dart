import 'package:flutter/material.dart';
import 'package:sqlite/listado.dart';
import 'package:sqlite/editar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Listado(),
        "/editar": (context) => Editar(),
      },
    );
  }
}