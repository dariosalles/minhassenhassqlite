import 'package:flutter/material.dart';
import 'package:sqlite/helpers/database_helper.dart';
import 'package:sqlite/models/senhas.dart';
import 'package:sqlite/pages/senha_page.dart';

import 'drawer_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DataBaseHelper db = DataBaseHelper();
  List<Senhas> senhas = List<Senhas>();

  @override
  void initState() {
    super.initState();

    //Senhas c = Senhas(1,1,'Jogos','dariosalles@gmail.com','12345678','Teste2','2020-06-05 18:41','S');
    //db.insertSenha(c);
//    db.getSenhas().then((lista) {
//
//      print(lista);
//
//    });

  db.getSenhas().then((lista){
    setState(() {
      senhas = lista;
    });
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Minhas Senhas'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          _exibeSenhaPage();
          //Navigator.pushNamed(context, "/senha");
        },
        child: Icon(
            Icons.add,
            color: Colors.white
        ),

      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: senhas.length,
          itemBuilder: (context, index) {
            return _listaSenhas(context, index);
          }

    ),
    );
  }

  _listaSenhas(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage("assets/img/item_senha.png")
                  )
                ),

              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(senhas[index].categoria ?? "",
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                    Text(senhas[index].login ?? "",
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                    Text(senhas[index].obs ?? "",
                      style: TextStyle(
                        fontSize: 15
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  color: Colors.indigo,
                  iconSize: 30,
                  tooltip: 'Remover',
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            title: Text('Deseja remover o registro'),
                            titlePadding: EdgeInsets.all(20),
                            titleTextStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo
                            ),
                            content: Text(senhas[index].login.toString(),
                                textAlign: TextAlign.center),
                            contentPadding: EdgeInsets.all(20),
                            actions: <Widget>[
                              RaisedButton(
                                child: Text("Sim"),
                                onPressed: (){
                                  print('sim');
                                  //removeSenha(snapshot.data[indice]['id'].toString(),snapshot.data[indice]['id_usuario'].toString());

                                  Navigator.pop(context);
                                },
                              ),
                              RaisedButton(
                                child: Text('Não'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],

                          );
                        });
                    //print('Clicado $indice');
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _exibeSenhaPage(senha: senhas[index]);
      },
    );
  }

  void _exibeSenhaPage({Senhas senha}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=> SenhaPage(senha: senha))
    );
  }
}
