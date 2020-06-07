import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  bool rememberMe = false;

  initState() {
    _verificarLembrarMe();
  }

  //VERIFICA SE JÁ EXISTE UM LOGIN
  _verificarLembrarMe() async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    bool rememberMe = sp.getBool('lembrarme');
    print(rememberMe);
    if(rememberMe==true) {

      Navigator.pushNamed(context, '/inicial');
    }
  }



  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;
  });

  List _result = [];

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //CONTROLLER - BUSCA - RECUPERA O QUE FOI DIGITADO
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  // MENSAGENS AMIGAVEIS
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

  getSenha(){
    Navigator.pushNamed(context, '/esqueci');
  }

  getAcesso() async {
//
    String email;
    String senha;
//    String nome;
//    String id_usuario;
//
    email = _controllerEmail.text.trim();
    senha = _controllerSenha.text.trim();
//
//    //print(email);
//    //print(senha);
//
//    //VERIFICA OS CAMPOS DIGITADOS
//    if(email.isEmpty || senha.isEmpty) {
//
//      mensagemToast("Campo e-mail ou/e senha em branco");
//
//    } else {
//
//      // String apiAcesso_get = 'http://www.dsxweb.com/apps/autoparts/api/usuario.php?token=$token' + '&email=' + email + '&senha=' + senha;
//      //String apiAcesso = 'http://www.dsxweb.com/apps/minhassenhas/api/apiRecupera_usuario.php?token=$token';
//      //String apiAcesso = '${Constants.baseUrlApi}apiRecupera_usuario.php';
//
//      //print(apiAcesso);
//
//      //http.Response response;
//
//      //response = await http.get(apiAcesso);
//
//      //response = await http.post(apiAcesso, body: {'email': email, 'senha': senha });
//      //response = await http.post(apiAcesso, body: {'email': email, 'senha': senha, 'token': Constants.token.toString()});
//
////    var headers = response.headers;
////
//      //print(response.body);
//
//
//      //if (response.statusCode == 200) {
//
////        setState(() {
////          _result = json.decode(response.body) as List;
////        });
////
////        //print('Resultado:' + _result.toString());
////
////        if(_result.isEmpty) {
////
////          //print('acesso não permitido');
////          mensagemToast('Acesso não permitido');
////
////
////        } else {
////
////          setState(() {
////            email = _result[0]['email'];
////            nome = _result[0]['nome'];
////            id_usuario = _result[0]['id_usuario'].toString();
////          });
//
//          //print('acesso permitido');
//
//          //guarda email
//          SharedPreferences sp = await SharedPreferences.getInstance();
//          sp.setString('nome', nome);
//          sp.setString('email', email);
//          sp.setString('id_usuario', id_usuario);
//          if(rememberMe){
//            sp.setBool('lembrarme', rememberMe);
//          }
//
////              setState(() {
////                email = sp.getString('email');
////              });
//
//          //print('Email sp antes $email');
//
//          // NAVEGA COM BOTAO VOLTAR
//          Navigator.pushNamed(context, '/inicial');
//
//          // NAVEGA SEM DEIXAR BOTAO VOLTAR
//          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext) => InicialSenhas()));
//
//
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


    //}


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/fundo7.jpg'),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter
              )
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
          child: Image.asset('assets/img/logo_minhassenhas2.png'),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Text('Acessar Minhas Senhas',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo
                  ),),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      controller: _controllerEmail,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          labelStyle: TextStyle(
                              fontSize: 15
                          )
                      ),
                    ),

                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  //color: Color(0xfff5f5f5),
                  child: new Column(
                    children: <Widget>[
                      TextFormField(
                        obscureText: _obscureText,
                        maxLength: 8,
                        controller:_controllerSenha,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: (){
                              _toggle();
                            },
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blue,
                            ),
                          ),

                        ),
                      ),
                      CheckboxListTile(
                        title: Text("Lembrar me?"),
                        value: rememberMe,
                        onChanged: _onRememberMeChanged,
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      )


                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () async {
                      //getAcesso();
                      Navigator.pushNamed(context, '/inicial');
                    },//since this is only a UI app
                    child: Text('Acessar',
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
    );
  }
}