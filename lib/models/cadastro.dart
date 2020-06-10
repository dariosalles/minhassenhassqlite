class Cadastro {
  String nome;
  String email;
  String senha;
  String data_cadastro;
  String ativado;

  Cadastro(this.nome, this.email, this.senha, this.data_cadastro, this.ativado);

  // converte Objeto para Map
  Map<String,dynamic> toMap() {
    var map = <String,dynamic> {
      'nome': nome,
      'email': email,
      'senha': senha,
      'data_cadastro': data_cadastro,
      'ativado': ativado
    };
    return map;
  }
  // Converte Map para Objeto
  Cadastro.fromMap(Map<String, dynamic> map){
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
    data_cadastro = map['data_cadastro'];
    ativado = map['ativado'];
  }

}