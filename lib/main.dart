import 'package:flutter/material.dart';
import 'package:sqlite/pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/senha_page.dart';


void main() {
  runApp(MaterialApp(
    //home: HomePage(),
    debugShowCheckedModeBanner: false,
    title: 'Minhas Senhas',
    initialRoute: "/",
    routes: {
      '/': (context) => Inicial(),
      '/inicial': (context) => HomePage(),
      '/senha':(context) => SenhaPage()

    },
  ));
}

// PAGE INICIAL
class Inicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TelaLogin()
    );
  }
}