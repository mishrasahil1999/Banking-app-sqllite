import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grip_banking/db/user_data.dart';


class BankDatabase {

  static final _tableName = 'bankUsers';


  static final columnName = 'Name';
  static final columnAccountNumber = 'AccountNumber';
  static final columnAccountBalance = 'AccountBalance';
  static final columnPhone = 'Phone';

  static Database _database;
  static BankDatabase _bankdatabase;

  BankDatabase._createInstace();


  factory BankDatabase(){
    if (_bankdatabase == null) {
      _bankdatabase = BankDatabase._createInstace();
    }
    return _bankdatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'bank.db';

    var bankDatabase = await openDatabase(
        path, version: 1, onCreate: _createDB);
    return bankDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        '''
      CREATE TABLE $_tableName ($columnAccountNumber TEXT NOT NULL,
      $columnName TEXT NOT NULL,
      $columnPhone TEXT NOT NULL, 
      $columnAccountBalance FLOAT)
      '''
    );
    insertValues();
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $_tableName');
    return result;
  }


  Future<int> insert(userData user) async {
    Database db = await this.database;
    return await db.insert(_tableName, user.toMap());
  }

  Future update(userData user) async {
    Database db = await this.database;
    return await db.update(
        _tableName, user.toMap(), where: 'AccountNumber = ?',
        whereArgs: [user.AccountNumber]);
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT * FROM $_tableName');
    return Sqflite.firstIntValue(x);
  }

  Future<void> insertValues() {
    insert(userData("Shyam", "000002", 4000, "1234567890"));
    insert(userData("Mohan", "000003", 8000, "1234567890"));
    insert(userData("Sahil", "000004", 9000, "1234567890"));
    insert(userData("Raj", "000005", 62000, "1234567890"));
    insert(userData("Ram", "000001", 3000, "1234567890"));
    insert(userData("Anita", "000008", 300, "1234567890"));
    insert(userData("Sumita", "000009", 9000, "1234567890"));
    insert(userData("Isha", "000006", 30000, "1234567890"));
    insert(userData("Rajat", "000007", 3050, "1234567890"));
    insert(userData("Babita", "000010", 85000, "1234567890"));
    return null;
  }

  Future <List<userData>> getUserList() async {
    var userMapList = await getUserMapList();
    int count = userMapList.length;

    List<userData> userList = [];
    for (int i = 0; i < count; i++) {
      userList.add(userData.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> SearchUser(String accno) async {
    Database db = await this.database;
    var userMapList = await db.rawQuery(
        'SELECT * FROM $_tableName WHERE AccountNumber= $accno;');
    int count = userMapList.length;
    if (count!=0){
    return userMapList;}
    return null;
  }

}