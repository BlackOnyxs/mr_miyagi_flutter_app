import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
import 'package:mr_miyagi_app/core/models/menu_section_model.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/models/promotion_model.dart';
import 'package:mr_miyagi_app/core/utils/database_constant.dart';
import 'package:mr_miyagi_app/core/utils/state_constant.dart';
import 'package:mr_miyagi_app/core/utils/utils.dart';
import 'package:rxdart/rxdart.dart';


class FirestoreService{

  final CollectionReference _userCollectionReference = 
        Firestore.instance.collection(CUSTOMER_USER_PATH);

  final CollectionReference _promotionCollectionReference = 
        Firestore.instance.collection(PROMOTION_PATH);

  final CollectionReference _homeSectionsCollectionReference = 
        Firestore.instance.collection(HOME_SECTIONS_PATH);

  final CollectionReference _dailyLunchCollectionReference = 
        Firestore.instance.collection(DAILY_LUNCH_PATH);

  final CollectionReference _menuSectionCollectionReference = 
        Firestore.instance.collection(MENU_SECTIONS_PATH);

  final CollectionReference _orderRequestCollectionReference = 
        Firestore.instance.collection(ORDER_REQUEST_PATH);

  final CollectionReference _activeOrderCollectionReference = 
        Firestore.instance.collection(ACTIVE_ORDER_PATH);

  final _promotionContoller = BehaviorSubject<List<PromotionModel>>();
  final _dailyLunchContoller = BehaviorSubject<List<DailyLunchModel>>();
  final _orderController = BehaviorSubject<OrderModel>();

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
  Future updateUser( CustomerUser user ) async {
    try {
      await _userCollectionReference.document(user.id).updateData(user.toJson());
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

  Future getHomeSectionsOnceOff()async{
    try {
      var sectionsDocumentsSnapshot = await _homeSectionsCollectionReference.getDocuments();
      if (sectionsDocumentsSnapshot.documents.isNotEmpty) {
        return sectionsDocumentsSnapshot.documents
          .map((snapshot)=>  MenuSectionBase.fromJson(snapshot.data))
          .where((mappedItem)=> mappedItem.id != null)
          .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  Stream listenDailyLunch(){
    _dailyLunchCollectionReference.snapshots().listen((dailyLunchSnapshot){
      if(dailyLunchSnapshot.documents.isNotEmpty){
        var dailyLunches = dailyLunchSnapshot.documents
        .map((snapshot)=> DailyLunchModel.fromJson(snapshot.data))
        .where((mappedItem)=> mappedItem.id != null)
        .toList();
        _dailyLunchContoller.sink.add(dailyLunches);
      }
    }); 
    return _dailyLunchContoller.stream;                                               
  }
 
 Future createDailyLunch( DailyLunchModel lunchModel ) async{
   try {
     await _dailyLunchCollectionReference.document().setData(lunchModel.toJson());
   } catch (e) {
     if (e is PlatformException) {
        return e.message;
      }
   }
 }
 Future createMenuSection( MenuSection section ) async{
   try {
     await _menuSectionCollectionReference.document().setData(section.toJson());
   } catch (e) {
     if (e is PlatformException) {
        return e.message;
      }
   }
 }

 Future getMenuSections()async{
   try {
     var menuSectionSnapshot = await _menuSectionCollectionReference.getDocuments();
      if (menuSectionSnapshot.documents.isNotEmpty) {
        return menuSectionSnapshot.documents
          .map((snapshot)=>  MenuSection.fromJson(snapshot.data))
          .where((mappedItem)=> mappedItem.id != null)
          .toList();
      }
   } catch (e) {
     if (e is PlatformException) {
        return e.message;
      }
   }
 }

 Future sentOrder( OrderModel currentOrder)async{
    try{
      await _orderRequestCollectionReference.document(currentOrder.id).setData(currentOrder.toJson());
    }catch(e){
      if (e is PlatformException) {
        return e.message;
      }
    }
  }
  Future getOrderOnceOff( String id ) async{
    try {
    var orderData = await _orderRequestCollectionReference.document(id).get();
    if (orderData.exists) {
      return OrderModel.fromJson(orderData.data);
    } else{
      var orderData = await _activeOrderCollectionReference.document(id).get();
      return OrderModel.fromJson(orderData.data);
    }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  Stream listenOrder( String id ){
    bool exist = true; 
    _orderRequestCollectionReference.document(id).snapshots().listen((dataSnapshot){
      if (dataSnapshot.exists) {
        if (dataSnapshot.data.isNotEmpty) {
        var orderData = OrderModel.fromJson(dataSnapshot.data);
        if (orderData.state != null ) {
          if (orderData.state is int && orderData.state< onFinish) {
            _orderController.sink.add(orderData);
          } 
        }
      }
      
      }else{
        exist = false;
      }
    });
    if ( !exist ) {
      _activeOrderCollectionReference.document(id).snapshots().listen((dataSnapshot){
          if (dataSnapshot.exists) {
            if (dataSnapshot.data.isNotEmpty) {
            var orderData = OrderModel.fromJson(dataSnapshot.data);
            if (orderData.state != null ) {
              if (orderData.state is int ) {
                _orderController.sink.add(orderData);
              } 
            }
          }
        }else{
          /* TODO: add error */
        }
      });
    }
    return _orderController.stream;
  }
  
    
  void dispose() { 
    _promotionContoller?.close();
    _dailyLunchContoller?.close();
    _orderController?.close();
  }

}