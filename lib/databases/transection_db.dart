import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB{

  String dbName;

  TransactionDB({required this.dbName});

  Future <Database> openDatabase() async{
    //หาตำแหน่งเก็บ
    Directory appDirectory = await getApplicationCacheDirectory();
    String dbLocation = join(appDirectory.path,dbName);
    //สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }
 }