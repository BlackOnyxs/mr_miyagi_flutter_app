import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/dialog_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/utils/validators.dart';

import '../../locator.dart';
import 'base_model.dart';

class LogInViewModel extends BaseModel with Validators{
  final AuthenticationService _authenticationService =
    locator<AuthenticationService>();
  final DialogService _dialogService =locator<DialogService>();
  final NavigationService _navigationService =
    locator<NavigationService>();

  Future logIn({@required email, @required password}) async{
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email, password: password
    );

    setBusy(false);
    if(result is bool){
      if (result) {
        _navigationService.navigateToPop(START_UP_VIEW_ROUTE);
      }
    }else{
      await _dialogService.showDialog(
        title: 'Login Failure!',
        //Change the description with de error message of autResult 
        description: result.toString()
      );
    }
  }

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validateEmptyField );

  Stream<bool> get validateForm =>
    CombineLatestStream.combine2(emailStream, passwordStream, (e,p) => true);
  
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changepassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  
  void navigateToSignUp(){
    _navigationService.navigateToPop(SIGNUP_VIEW_ROUTE);
  }

  
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}