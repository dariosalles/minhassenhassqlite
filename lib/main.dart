import 'package:flutter/material.dart';
import 'package:sqlite/pages/home_page.dart';
import 'package:sqlite/pages/senha_page.dart';

void main() {
  runApp(MaterialApp(
    //home: HomePage(),
    debugShowCheckedModeBanner: false,
    title: 'Minhas Senhas',
    initialRoute: "/",
    routes: {
      '/': (context) => HomePage(),
      '/inicial': (context) => HomePage(),
      '/senha':(context) => SenhaPage()

    },
  ));
}