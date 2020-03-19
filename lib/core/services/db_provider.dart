import 'dart:io';

import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/local_food.dart';
import 'package:mr_miyagi_app/core/models/local_order.dart';
import 'package:mr_miyagi_app/core/utils/database_constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';



class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if ( _database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentDirectory.path, 'TurboDeliveryDB.db' );

    return await openDatabase( 
      path,
      version: 1,
      onOpen: (db){},
      onCreate: ( Database db, int version) async {

        await db.execute(
          'CREATE TABLE $CUSTOMER_USER_PATH ('
          ' localId INTEGER PRIMARY KEY AUTOINCREMENT, '
          ' firebaseId TEXT'
          ')'
        );
        await db.execute(
          'CREATE TABLE $FOOD_PATH ('
          ' id TEXT PRIMARY KEY, '
          ' name TEXT, '
          ' price TEXT, '
          ' orderId TEXT, '
          ' FOREIGN KEY (orderId) REFERENCES $ORDER_PATH (orderId)'
          ')'
        );
        //TODO: create all others master before Order master
        await db.execute(
          ' CREATE TABLE $ORDER_PATH ('
          ' id TEXT PRIMARY KEY, '
          ' restaurantId TEXT, '
          ' subTotalPrice TEXT, '
          ' deliveryPrice TEXT, '
          ' totalPrice TEXT, '
          ' latitudeC TEXT, '
          ' longitudeC TEXT, '
          ' latitudeR TEXT, '
          ' longitudeR TEXT, '
          ' userId TEXT, '
          ' FOREIGN KEY (userId) REFERENCES $CUSTOMER_USER_PATH (userId)'
          ')'
        );
      } 
    );
  }
  getVersion()async{
    final db = await database;
    return await db.getVersion();
  }

  //Create registers
  newRowUser( String firebaseId ) async {
    final db = await database;
    
    final answer = db.rawInsert( 
      "INSERT INTO $CUSTOMER_USER_PATH (firebaseId) "
      "VALUES ( '$firebaseId' )"
    );

    return answer;
  }

   newFood( LocalFood food ) async {

    final db = await database;

    final answer = await db.insert( FOOD_PATH, food.toJson());
      /* "INSERT INTO $Food (id, name, price) "
      "VALUES ( ${food.id}, '${food.name}', '${food.price}' )"
    ); */
    return answer;

  }
   newRowOrder( LocalOrder order ) async {
    final db = await database;

    final answer = await db.insert( ORDER_PATH, order.toJson());
     /*  "INSERT INTO $Order (id, restaurantId, subTotalPrice, deliveryPrice, totalPrice, latitudeC, longitudeC, latitudeR, longitudeR) "
      "VALUES ( ${order.id}, '${order.restaurantId}', '${order.subTotalPrice}', '${order.deliveryPrice}', '${order.totalPrice}', '${order.location[0].lat}', '${order.location[0].lng}', '${order.location[1].lat}', '${order.location[1].lng}' )"
    ); */

    return answer;
  }

  //SELECT

  Future<CustomerUser>getUserById( String id ) async {
    
    final db = await database;

    final answer = await db.query( CUSTOMER_USER_PATH , where: 'id= ?', whereArgs: [id] );

    return answer.isNotEmpty ? CustomerUser.fromJson( answer.first ) : null;

  }

  Future<LocalFood>getFoodById( String id ) async {
    
    final db = await database;

    final answer = await db.query( FOOD_PATH , where: 'id= ?', whereArgs: [id] );

    return answer.isNotEmpty ? LocalFood.fromJson( answer.first ) : null;

  }

  Future<LocalOrder>getOrderById( String id ) async {
    
    final db = await database;

    final answer = await db.query( ORDER_PATH , where: 'id= ?', whereArgs: [id] );

    return answer.isNotEmpty ? LocalOrder.fromJson( answer.first ) : null;

  }

   Future<List<LocalOrder>> getAllOrders( String id ) async {

    final db = await database;

    final answer = await db.query( ORDER_PATH,  where: 'id= ?', whereArgs: [id] );

    List<LocalOrder> list = answer.isNotEmpty 
                            ? answer.map( ( s ) => LocalOrder.fromJson( s )).toList() 
                            : [];

    return list;
  } 
/*
  Future<List<ScanModel>> getAllScansByType ( String type ) async {

    final db = await database;

    final answer = await db.rawQuery( "SELECT * FROM Scans WHERE id='$type'" );

    List<ScanModel> list = answer.isNotEmpty 
                            ? answer.map( ( s ) => ScanModel.fromJson( s )).toList() 
                            : [];

    return list;
  }
  */

  //Update registers

  Future<int> updateUser ( CustomerUser  user ) async {

    final db = await database;

    final answer = await db.update( CUSTOMER_USER_PATH, user.toJson() );

    return answer;

  }
   Future<int> updateFood ( LocalFood food) async {

    final db = await database;

    final answer = await db.update( FOOD_PATH , food.toJson(), where: 'id = ?', whereArgs: [food.id] );

    return answer;

  }
  Future<int> updateOrder ( LocalOrder order ) async {

    final db = await database;

    final answer = await db.update( ORDER_PATH, order.toJson(), where: 'id = ?', whereArgs: [order.id] );

    return answer;

  }

  //Delete registers

  Future<int> deleteUser ( String id) async {

    final db = await database;

    final answer = await db.delete( CUSTOMER_USER_PATH , where: 'id = ?', whereArgs: [id] );

    return answer;

  }
  Future<int> deleteFood ( String id) async {

    final db = await database;

    final answer = await db.delete( FOOD_PATH , where: 'id = ?', whereArgs: [id] );

    return answer;

  }
  Future<int> deleteScan ( String id) async {

    final db = await database;

    final answer = await db.delete( ORDER_PATH , where: 'id = ?', whereArgs: [id] );

    return answer;

  }

  Future<int> deleteAllUsers () async {

    final db = await database;

    final answer = await db.rawDelete('DELETE FROM $CUSTOMER_USER_PATH');

    return answer;

  }

  Future<int> deleteAllFoods () async {

    final db = await database;

    final answer = await db.rawDelete('DELETE FROM $FOOD_PATH');

    return answer;

  }

  Future<int> deleteAllOrders () async {

    final db = await database;

    final answer = await db.rawDelete('DELETE FROM $ORDER_PATH');

    return answer;

  }

}