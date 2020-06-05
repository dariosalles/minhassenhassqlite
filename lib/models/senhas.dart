class Senhas {
  int id;
  int id_usuario;
  String categoria;
  String login;
  String senha;
  String obs;
  String data_cadastro;
  String ativado;

  Senhas(this.id, this.id_usuario, this.categoria, this.login, this.senha, this.obs, this.data_cadastro, this.ativado);

  // converte Objeto para Map
  Map<String,dynamic> toMap() {
    var map = <String,dynamic> {
      'id': id,
      'id_usuario': id_usuario,
      'categoria': categoria,
      'login': login,
      'senha': senha,
      'obs': obs,
      'data_cadastro': data_cadastro,
      'ativado': ativado
    };
    return map;
  }
  // Converte Map para Objeto
  Senhas.fromMap(Map<String, dynamic> map){
    id = map['id'];
    id_usuario = map['id_usuario'];
    categoria = map['categoria'];
    login = map['login'];
    senha = map['senha'];
    obs = map['obs'];
    data_cadastro = map['data_cadastro'];
    ativado = map['ativado'];
  }

}