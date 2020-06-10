import 'dart:async';
import 'dart:io';
import 'package:sqlite/models/senhas.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {

static DataBaseHelper _dataBaseHelper;
static Database _database;

//usada para definir as colunas da tabela passwords
  String senhasTable = 'passwords';
  String colId = 'id';
  String colCategoria = 'categoria';
  String colLogin = 'login';
  String colSenha = 'senha';
  String colObs = 'obs';
  String colData_Cadastro = 'data_cadastro';
  String colAtivado = 'ativado';


//construtor nomeado para criar instancia da classe no padrão SINGLETON para acesso a classe de modo grobal
  DataBaseHelper._createInstance();

  factory DataBaseHelper(){

    if(_dataBaseHelper == null) {
      //executado somente uma
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;

  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/pass.db';
    //print(path);

    var senhasDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    print(senhasDatabase);
    return senhasDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $senhasTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCategoria TEXT, $colLogin TEXT, $colSenha TEXT, $colObs TEXT, $colData_Cadastro TEXT, $colAtivado TEXT)');
  }

  //RETORNAR UMA LISTA DE TODOS OS REGISTROS
  Future<List<Senhas>> getSenhas() async {
    Database db = await this.database;
    var resultado = await db.query(senhasTable);

    List<Senhas> lista =
        resultado.isNotEmpty ? resultado.map(
            (c) => Senhas.fromMap(c)).toList() : [];

    return lista;
  }


  //INCLUIR UM OBJETO SENHA NO BANCO DE DADOS CONVERTIDO PRA MAP
  Future<int> insertSenha(Senhas senha) async {
    Database db = await this.database;
    var resultado = await db.insert(senhasTable, senha.toMap());
    //print(resultado);
    return resultado;
  }

  //RETORNAR UMA SENHA PELO ID
  Future<Senhas> getSenha(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(senhasTable,
    columns: [colId, colCategoria, colLogin, colSenha, colObs, colData_Cadastro, colAtivado],
    where: "$colId = ?",
    whereArgs: [id]);

    if(maps.length > 0 ) {
      return Senhas.fromMap(maps.first);

    }else {
      return null;
    }
  }

  //ATUALIZAR UMA SENHA EXISTENTE
  Future<int> updateSenha(Senhas senha) async {

    var db = await this.database;

    var resultado =
        await db.update(senhasTable, senha.toMap(),
        where: '$colId = ?',
        whereArgs: [senha.id]);

    return resultado;
  }

  //DELETAR UMA SENHA EXISTENTE
  Future<int> deleteSenha(int id) async {
    var db = await this.database;

    int resultado =
    await db.delete(senhasTable,
        where: '$colId = ?',
        whereArgs: [id]);

    return resultado;

  }

  //OBTEM O NUMERO DE SENHAS NO BANCO DE DADOS
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $senhasTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;

  }

  //FECHAR CONEXAO COM DB
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}