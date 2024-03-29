import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/share_pref/user_preferences.dart';
import '../../locator.dart';
import 'firestore_service.dart';
import 'local_db_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  UserPreferences _userPreferences = locator<UserPreferences>();
  LocalDBService _dbService = locator<LocalDBService>();
  
  CustomerUser _currentUser;
  CustomerUser get currentUser => _currentUser;
  
  Future loginWithEmail({
    @required String email,
    @required String password
  })async{
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
        await _populateCurrentUser(authResult.user);
        return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
}) async {
    try {
        var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        //create a user on Firestore
        print(authResult.toString());
        _currentUser = CustomerUser(
          id: authResult.user.uid,
          email: email,
          fullName: fullName
        );
        await _firestoreService.createUser(_currentUser);
        /* await _userPreferences.initPref();
        if (_userPreferences.aplicationVersion == 1) {
          _dbService.addUser(_currentUser.id);
        }else{
          var result = _dbService.getUserById(_currentUser.id);
          if (result == null) {
            _dbService.addUser(_currentUser.id);
          }
        } */
        return authResult.user != null;
    } catch (e) {
        return e.message;
    }
}

Future<bool> isUserLoggedIn() async {
  var user = await _firebaseAuth.currentUser();
  await _populateCurrentUser(user);
  return user != null;
}

Future _populateCurrentUser( FirebaseUser user ) async{
  if (user != null) {
    _currentUser = await _firestoreService.getUser(user.uid);
  }
}

}