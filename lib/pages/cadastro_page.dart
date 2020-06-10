import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //CONTROLLER - BUSCA - RECUPERA O QUE FOI DIGITADO
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          backgroundColor: Colors.indigo,
        ),
        //drawer: MenuDrawer(),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/fundo7.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter
                  )
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(23),
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _controllerNome,
                        maxLength: 30,
                        obscureText: false,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                      ),

                    ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 20),
//                      child: TextField(
//                        maxLines: 1,
//                        controller: _controllerNome,
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontFamily: 'SFUIDisplay'
//                        ),
//                        decoration: InputDecoration(
//                            border: OutlineInputBorder(),
//                            labelText: 'Nome',
//                            prefixIcon: Icon(Icons.person),
//                            labelStyle: TextStyle(
//                              fontSize: 15,
//
//                            )
//                        ),
//                      ),
//                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _controllerEmail,
                        maxLength: 30,
                        obscureText: false,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.mail),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _controllerSenha,
                        maxLength: 8,
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
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: (){
                          _setCadastro();
                          //Navigator.pushNamed(context, '/pecas');
                        },//since this is only a UI app
                        child: Text('Cadastrar Usuário',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.indigo,
                        //color: Color(0xffff2d55),
                        elevation: 0,
                        minWidth: 400,
                        height: 50,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ));

  }

  void _setCadastro() {


  }

}
