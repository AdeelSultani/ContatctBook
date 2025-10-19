import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

class DBHelper{
DBHelper._init();
Database ?_dtabase;
static DBHelper instance=DBHelper._init();

Future<Database> get database async{
if(_dtabase!=null) return _dtabase!;
_dtabase=await _initializeDB();
return _dtabase!;
  
}
Future<Database> _initializeDB() async{
  String  dbpath=await getDatabasesPath();
  String path=join(dbpath,'phonebook.db');
  return await openDatabase(
    path,version: 1,
    onCreate: _createDB
  );
}
_createDB(Database db,int version) async{
   String query='''
Create table Contact (ID INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,number TEXT,imageString TEXT,email TEXT
)
''';
await db.execute(query);
}
Future<int> insertRaw(String name,String number,String ?image,String ?email)
  async {
    String query='''
     insert into Contact (name,number,imageString,email) values 
      ('${name}','${number}','${image}','${email}')
     ''';
     Database db=await database;
   return await db.rawInsert(query);
  //  Database db = await database;
  // Map<String, dynamic> data = {
  //   'name': name,
  //   'number': number,
  //   'imageString': image,
  //   'email': email,
  // };
  // return await db.insert('Contact', data);
     
  }
    Future<List<Map<String,dynamic>>> selectRaw()async
  {
    Database db=await database;
    String query='Select * from  Contact';
     return await db.rawQuery(query);
  }

  Future<int> delete(int id) async{
    Database db=await database;
    String query='Delete from Contact where ID=${id} ';
    return await db.rawDelete(query);

  }
}