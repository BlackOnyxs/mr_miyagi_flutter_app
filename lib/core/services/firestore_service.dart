import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/utils/database_constant.dart';
import 'package:mr_miyagi_app/core/utils/utils.dart';


class FirestoreService{

  final CollectionReference _userCollectionReference = 
        Firestore.instance.collection(CUSTOMER_USER_PATH);

  final Utils _utils = new Utils(); 
  
  Future createUser( CustomerUser user ) async {
    try {
      await _userCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }
  Future updateUser( String uid, CustomerUser user ) async {
    try {
      await _userCollectionReference.document(uid).updateData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }
  Future getUser( String uid ) async{
    try {
      var userData = await _userCollectionReference.document(uid).get();
      return _utils.fetchUser(userData);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  

}