import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqlite/models/senhas.dart';

class SenhaPage extends StatefulWidget {

  final Senhas senha;
  SenhaPage({this.senha});

  @override
  _SenhaPageState createState() => _SenhaPageState();
}

class _SenhaPageState extends State<SenhaPage> {

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _categoriaController = TextEditingController();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _obsController = TextEditingController();

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

  @override
  void initState() {
    super.initState();

    if(widget.senha == null) {
      _editaSenha = Senhas(0,1, "Jogos", "", "123456789", "Teste 2", "2020-06-05", "S");
      //print('aki');
    }else{
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

        },
        child: Icon(Icons.save),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            DropdownButton(
              hint: Text('Selecione a categoria'), // Not necessary for Option 1
              value: _selectedCategoria,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategoria = newValue;
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
            ),
//            Padding(
//              padding: EdgeInsets.only(top: 20),
//              child: MaterialButton(
//                onPressed: (){
//                  //_setCadastro();
//                  //Navigator.pushNamed(context, '/pecas');
//                },//since this is only a UI app
//                child: Text('Cadastrar',
//                  style: TextStyle(
//                    fontSize: 15,
//                    fontFamily: 'SFUIDisplay',
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                color: Colors.indigo,
//                //color: Color(0xffff2d55),
//                elevation: 0,
//                minWidth: 400,
//                height: 50,
//                textColor: Colors.white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10)
//                ),
//              ),
//            ),
          ],

        ),
      ),
    );
  }
}
