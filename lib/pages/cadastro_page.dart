import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<String> _categorias = ['Banco', 'Email', 'Entretenimento', 'Internet', 'Jogos', 'Outro', 'Social','Trabalho' ]; // Option 2
  String _selectedCategoria; // Option 2


  String _resultCad;

  //CONTROLLER - CADASTRO - RECUPERA O QUE FOI DIGITADO
  //TextEditingController _controllerCategoria = TextEditingController();
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerObs = TextEditingController();


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

//  _setCadastro() async {
//
//    SharedPreferences sp = await SharedPreferences.getInstance();
//
//    String categoria = _selectedCategoria;
//    String login = _controllerLogin.text.trim();
//    String senha = _controllerSenha.text.trim();
//    String obs = _controllerObs.text.trim();
//    String idusuario = sp.getString('id_usuario');
//
//    //print('Categoria: ' + categoria + ' Id Usuario: ' + idusuario + ' Senha: ' + senha + ' Obs: ' + obs);
//
//    if(categoria.isEmpty || login.isEmpty || senha.isEmpty || obs.isEmpty) {
//
//      mensagemToast("Campo Categoria, Login, Senha ou/e Observação em branco");
//
//    } else {
//
//
//      //String _apiCadastro = 'http://www.dsxweb.com/apps/minhassenhas/api/apiCadastra_senha.php?token=$_token';
//      String _apiCadastro = '${Constants.baseUrlApi}apiCadastra_senha.php';
//
//      //print(_apiCadastro);
//
//      http.Response response;
//
//      response = await http.post(_apiCadastro, body: {'id_usuario': idusuario, 'categoria': categoria, 'login': login, 'senha': senha, 'obs': obs, 'token': Constants.token.toString()});
//
//      //print(response.body);
//
//
//      if (response.statusCode == 200) {
//
//        setState(() {
//          _resultCad = response.body;
//        });
//
//        //print('Resultado: $_resultCad');
//
//
//        if(_resultCad=='Erro') {
//
//          //print('Erro no Cadastro');
//          mensagemToast('Erro Cadastro');
//
//
//        } else {
//
//          //print('Cadastro feito com sucesso');
//
//
//          showDialog(context: context,
//              builder: (context){
//                return AlertDialog(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(20.0))
//                  ),
//                  title: Text('Cadastrado com sucesso'),
//                  titlePadding: EdgeInsets.all(20),
//                  titleTextStyle: TextStyle(
//                      fontSize: 20,
//                      color: Colors.red
//                  ),
//                  content: Text('Cadastro do login efetuado com sucesso.',
//                      textAlign: TextAlign.center),
//                  contentPadding: EdgeInsets.all(20),
//                  actions: <Widget>[
//                    RaisedButton(
//                      child: Text("OK"),
//                      onPressed: (){
//                        print('sim');
//                        Navigator.pushNamed(context, '/inicial');
//                      },
//                    ),
//                  ],
//
//                );
//              });
//          //print('Clicado $indice');
//          //Navigator.pushNamed(context, '/');
//
//        }
//
//
//
//      } else {
//
//        print('Erro 500');
//
//      }
//
//
//
//    }
//
//  }

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
                    Padding(
                      padding: EdgeInsets.all(10),
                      //alignment: Alignment.center,
                      //color: Colors.orange,
                      child: DropdownButton(
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
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _controllerLogin,
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
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _controllerSenha,
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        maxLines: 4,
                        controller: _controllerObs,
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: (){
                          //_setCadastro();
                          //Navigator.pushNamed(context, '/pecas');
                        },//since this is only a UI app
                        child: Text('Cadastrar',
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

}
