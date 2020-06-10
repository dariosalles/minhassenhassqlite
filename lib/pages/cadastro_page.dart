import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite/models/cadastro.dart';

class CadastroPage extends StatefulWidget {

  final Cadastro cadastro;
  CadastroPage({this.cadastro});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    if(widget.cadastro == null) {

      print('Inserção Cadastro');

      _cadastroUsuario = Cadastro("","","", formattedDate, "S");


    }else{

      print('Edição');
      _cadastroUsuario = Cadastro.fromMap(widget.cadastro.toMap());
      //print(_editaSenha);
      _controllerNome.text = _cadastroUsuario.nome;
      _controllerEmail.text = _cadastroUsuario.email;
      _controllerSenha.text = _cadastroUsuario.senha;

    }
  }

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

  final _nomeFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();

  Cadastro _cadastroUsuario;

  //AVISO - CADASTRO USUARIO
  void _exibeAvisoCadastro() {
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
          title: Text('Cadastro'),
          backgroundColor: Colors.indigo,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            bool nomepreenchido = false;
            bool emailpreenchido = false;
            bool senhapreenchido = false;

            if(_controllerNome.text != null && _controllerNome.text.isNotEmpty) {
              setState(() {
                nomepreenchido = true;
                print(nomepreenchido);
              });
            }

            if(_controllerEmail.text != null && _controllerEmail.text.isNotEmpty){
              setState(() {
                emailpreenchido = true;
                print(emailpreenchido);
              });
            }

            if(_controllerSenha.text != null && _controllerSenha.text.isNotEmpty){
              setState(() {
                senhapreenchido = true;
                print(senhapreenchido);
              });

            }

            if(nomepreenchido && emailpreenchido && senhapreenchido) {
              Navigator.pop(context, _cadastroUsuario);
            } else {
              _exibeAvisoCadastro();
              FocusScope.of(context).requestFocus(_senhaFocus);
            }

          },
          child: Icon(Icons.save),
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
                        focusNode: _nomeFocus,
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

//                    Padding(
//                      padding: EdgeInsets.only(top: 20),
//                      child: MaterialButton(
//                        onPressed: (){
//                          _setCadastro();
//                          //Navigator.pushNamed(context, '/pecas');
//                        },//since this is only a UI app
//                        child: Text('Cadastrar Usuário',
//                          style: TextStyle(
//                            fontSize: 15,
//                            fontFamily: 'SFUIDisplay',
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        color: Colors.indigo,
//                        //color: Color(0xffff2d55),
//                        elevation: 0,
//                        minWidth: 400,
//                        height: 50,
//                        textColor: Colors.white,
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(10)
//                        ),
//                      ),
//                    ),

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
