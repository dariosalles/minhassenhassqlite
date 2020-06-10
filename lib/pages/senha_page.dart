import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqlite/helpers/database_helper.dart';
import 'package:sqlite/models/senhas.dart';
import 'package:intl/intl.dart';


class SenhaPage extends StatefulWidget {

  final Senhas senha;
  SenhaPage({this.senha});

  @override
  _SenhaPageState createState() => _SenhaPageState();
}

class _SenhaPageState extends State<SenhaPage> {

//  DataBaseHelper db = DataBaseHelper();

//  count() async {
//
//    await db.getCount().then((valor) {
//      int pid = valor;
//      //print(pid);
//      return pid;
//    });
//
//
//  }

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    if(widget.senha == null) {

      print('Inserção');

      _editaSenha = Senhas(null, "", "", "", "", formattedDate, "S");


    }else{

      print('Edição');
      _editaSenha = Senhas.fromMap(widget.senha.toMap());
      //print(_editaSenha);
      _categoriaController.text = _editaSenha.categoria;
      _loginController.text = _editaSenha.login;
      _senhaController.text = _editaSenha.senha;
      _obsController.text = _editaSenha.obs;

      setState(() {
        _selectedCategoria = _editaSenha.categoria;
      });


    }
  }

  //DataBaseHelper db = DataBaseHelper();

//  _count() async {
//    int count  = await db.getCount();
//    print(count);
//    return count;
//  }
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //TextEditingValue _selectedCategoria = TextEditingValue();
  final _categoriaController = TextEditingController();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _obsController = TextEditingController();

  final _categoriaFocus = FocusNode();
  final _loginFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _obsFocus = FocusNode();

  bool editado = false;
  Senhas _editaSenha;


  List<String> _categorias = ['Banco', 'Email', 'Entretenimento', 'Internet', 'Jogos', 'Outro', 'Social','Trabalho' ]; // Option 2
  String _selectedCategoria; // Option 2

  //MENSAGENS AMIGAVEIS
  mensagemToast(String msg) {

    return Fluttertoast.showToast(

        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        backgroundColor: Color.fromARGB(255, 214, 37, 1),
        textColor: Colors.white,
        fontSize: 16.0
    );


  }

  //AVISO
  void _exibeAviso() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Campos obrigatórios"),
            content: Text("Preencha todos os campos"),
            actions: <Widget>[
              FlatButton(
                child: Text("Fechar"),
                onPressed: () {
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(_editaSenha.login == '' ? "Nova Senha" :
        _editaSenha.login ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          if(_editaSenha.login != null && _editaSenha.login.isNotEmpty){
            Navigator.pop(context, _editaSenha);
          }else{
            _exibeAviso();
            FocusScope.of(context).requestFocus(_loginFocus);

          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
//            Container(
//              color: Colors.white,
//              child: Text("ID")
//            ),
            DropdownButton(
              focusNode: _categoriaFocus,
              autofocus: true,
              focusColor: Colors.red,
              hint: Text('Selecione a categoria'), // Not necessary for Option 1
              value: _selectedCategoria,
              onChanged: (newValue) {

               setState(() {
                  _selectedCategoria = newValue;
                  _editaSenha.categoria = newValue;
                });
              },
              items: _categorias.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                controller: _loginController,
                focusNode: _loginFocus,
                maxLength: 30,
                obscureText: false,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaSenha.login = text;
                  });
                },
              ),
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                focusNode: _senhaFocus,
                controller: _senhaController,
                maxLength: 30,
                obscureText: _obscureText,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: (){
                        _toggle();
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),

                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaSenha.senha = text;
                  });
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                maxLines: 4,
                focusNode: _obsFocus,
                controller: _obsController,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observação',
                    prefixIcon: Icon(Icons.message),
                    labelStyle: TextStyle(
                      fontSize: 15,
                    )
                ),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaSenha.obs = text;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
