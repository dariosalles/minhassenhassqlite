import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/models/cadastro.dart';

class DbCadastroHelper {

  static DbCadastroHelper _dataBaseCadastroHelper;
  static Database _databaseCadastro;

//usada para definir as colunas da tabela passwords
  String cadastroTable = 'usuarios';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String colSenha = 'senha';
  String colData_Cadastro = 'data_cadastro';
  String colAtivado = 'ativado';


//construtor nomeado para criar instancia da classe
  DbCadastroHelper._createInstance();

  factory DbCadastroHelper(){

    if(_dataBaseCadastroHelper == null) {
      //executado somente uma
      _dataBaseCadastroHelper = DbCadastroHelper._createInstance();
    }
    return _dataBaseCadastroHelper;

  }

  Future<Database> get database async {
    if(_databaseCadastro == null) {
      _databaseCadastro = await initializeDatabase();
    }
    return _databaseCadastro;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/pass.db';
    print(path);

    var cadastroDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return cadastroDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $cadastroTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colEmail TEXT, $colSenha TEXT, $colData_Cadastro TEXT, $colAtivado TEXT)');
  }

  //INCLUIR UM OBJETO CADASTRO NO BANCO DE DADOS
  Future<int> insertCadastro(Cadastro cadastro) async {
    Database db = await this.database;
    var resultado = await db.insert(cadastroTable, cadastro.toMap());
    return resultado;
  }

  //FECHAR CONEXAO COM DB
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}