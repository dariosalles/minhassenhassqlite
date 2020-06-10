import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

//  String email;
//  String nome;
//
//  initState() {
//
//    getEmail();
//
//  }
//
//  // pega os dados do usuário inicialmente
//  getEmail() async {
//    SharedPreferences sp = await SharedPreferences.getInstance();
//
//    setState(() {
//      email = sp.getString('email');
//      nome = sp.getString('nome');
//    });
//
//    //print('Email depois $email');
//  }
//
  _logout() async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    bool rememberMe = sp.getBool('lembrarme');
    print('Logout $rememberMe');

    if(rememberMe == true) {
      setState(() {
        sp.setBool('lembrarme', false);
        rememberMe = false;
      });
    }
    print('Logout $rememberMe');
    print('Sair Logout');


    Navigator.pushNamed(context, '/');

  }

  @override
  Widget build(BuildContext context) {

    const TextStyle optionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              accountName: Text('Dario' ?? ''),
              accountEmail: Text('dariosalles@gmail.com' ?? ''),
              currentAccountPicture: CircleAvatar(
                child: Text('MS',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo

                  ),),
                backgroundColor: Colors.white,

              ),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          ListTile(
              title: Column(

                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.security),
                        color: Colors.indigo,
                        iconSize: 30,
                        tooltip: 'Lista de Senhas',
                        onPressed: () {
                          print('Recarrega a pagina Senhas');
                          Navigator.pushNamed(context, '/inicial');
                        },
                      ),
                      Text("Senhas",
                          style: optionStyle)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        color: Colors.indigo,
                        iconSize: 30,
                        tooltip: 'Sair',
                        onPressed: () async{
                          _logout();
                        },
                      ),
                      Text("Sair (Logout)",
                          style: optionStyle),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
                    child: Image.asset('assets/img/logo_ds.png'),
                  ),

                ],
              )
          )
        ],

      ),
    );


  }

}
