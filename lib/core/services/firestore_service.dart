import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
import 'package:mr_miyagi_app/core/models/promotion_model.dart';
import 'package:mr_miyagi_app/core/utils/database_constant.dart';
import 'package:mr_miyagi_app/core/utils/utils.dart';
import 'package:rxdart/rxdart.dart';


class FirestoreService{

  final CollectionReference _userCollectionReference = 
        Firestore.instance.collection(CUSTOMER_USER_PATH);

  final CollectionReference _promotionCollectionReference = 
        Firestore.instance.collection(PROMOTION_PATH);

  final CollectionReference _homeSectionsCollectionReference = 
        Firestore.instance.collection(HOME_SECTIONS_PATH);

  final _promotionContoller = BehaviorSubject<List<PromotionModel>>();

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

  Stream listenPromotions(){
    _promotionCollectionReference.snapshots().listen((promSnapshot){
      if(promSnapshot.documents.isNotEmpty){
        var promotions = promSnapshot.documents
        .map((snapshot)=> PromotionModel.fromJson(snapshot.data))
        .where((mappedItem)=> mappedItem.id != null)
        .toList();
        _promotionContoller.sink.add(promotions);
      }
    }); 
    return _promotionContoller.stream;                                               
  }

  Future getServicesOnceOff()async{
    try {
      var sectionsDocumentsSnapshot = await _homeSectionsCollectionReference.getDocuments();
      if (sectionsDocumentsSnapshot.documents.isNotEmpty) {
        return sectionsDocumentsSnapshot.documents
          .map((snapshot)=>  MenuSectionBase.fromData(snapshot.data))
          .where((mappedItem)=> mappedItem.id != null)
          .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }
 
  void dispose() { 
    _promotionContoller?.close();
  }

}