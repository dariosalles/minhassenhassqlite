class Cadastro {
  String nome;
  String email;
  String senha;

  Cadastro(this.nome, this.email, this.senha);

  // converte Objeto para Map
  Map<String,dynamic> toMap() {
    var map = <String,dynamic> {
      'nome': nome,
      'email': email,
      'senha': senha
    };
    return map;
  }
  // Converte Map para Objeto
  Cadastro.fromMap(Map<String, dynamic> map){
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
  }

}