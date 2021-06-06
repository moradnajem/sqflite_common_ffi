import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';

class DB{
  static final _databaseName = "muhnnad.db";
  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();
  var databaseFactory = databaseFactoryFfi;
  openDb()async{
    sqfliteFfiInit();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
       return await databaseFactory.openDatabase(
         path, options: OpenDatabaseOptions(
             version: 1,
             onCreate: (db, version){
               db.execute('''CREATE TABLE  Product (id INTEGER PRIMARY KEY,title TEXT)''');
              })
           );
  }




   void insert(Map<String, Object> map) async{
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     String path = join(documentsDirectory.path, _databaseName);
     var db = await databaseFactory.openDatabase(path);
     await db.insert('Product', map);
   }

  Future update({id,Map<String, Object> map}) async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
     var db = await databaseFactory.openDatabase(path);
     await db.update('Product', map, where: 'id = ?', whereArgs: [id]);
     var result = await db.rawQuery('select * from Product where id = $id');
     return result;
   }

  void delete({id}) async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db = await databaseFactory.openDatabase(path);
    await db.rawQuery('delete from Product where id = $id');
  }

  void deleteAll() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db = await databaseFactory.openDatabase(path);
    await db.delete('Product');
  }

   Future get({id}) async{
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     String path = join(documentsDirectory.path, _databaseName);
     var db = await databaseFactory.openDatabase(path);
     var result = await db.rawQuery('select * from Product where id = $id');
     return result;
   }

  Future getAll() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db = await databaseFactory.openDatabase(path);
    var result = await db.rawQuery('select * from Product');
    return result;
  }


  Future count() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db = await databaseFactory.openDatabase(path);
    var result = await db.rawQuery('select count(*) count from Product');
    return result;
  }

}