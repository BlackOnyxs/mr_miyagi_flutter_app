import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/utils/validators.dart';
import 'package:mr_miyagi_app/core/services/dialog_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import '../../locator.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel with Validators{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({@required String email, @required password, @required fullName}) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email, password: password, fullName: fullName
    );

    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateToPop(START_UP_VIEW_ROUTE);
      }else{
        await _dialogService.showDialog(
          title: 'Sign Up Failure!',
          //Change the description with de error message of autResult 
          description: 'General sign Up failure. Please try again later',
        );
      }
    }else{
      await _dialogService.showDialog(
        title: 'Sign Up Failure!',
        description: result,
      );
    }

  }
  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _fullNameController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );
  Stream<String> get fullNameStream => _fullNameController.stream.transform( validateEmptyField );

  Stream<bool> get validateForm => 
    CombineLatestStream.combine3(emailStream, passwordStream, fullNameStream, (e, p, n) => true);
  
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeFullName => _fullNameController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get fullName => _fullNameController.value;

dispose(){
  _emailController?.close();
  _passwordController?.close();
  _fullNameController?.close();
}

  void navigateToLogin(){
    _navigationService.navigateToPop(LOGIN_VIEW_ROUTE);
  }
}