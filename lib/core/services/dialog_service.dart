import 'dart:async';

import 'package:mr_miyagi_app/core/models/alert_request.dart';
import 'package:mr_miyagi_app/core/models/alert_response.dart';



class DialogService {

  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener( Function(AlertRequest) showDialogListener ){
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog({
    String title,
    String description,
    String buttonTitle = "Ok",
    int typeAlert,
  }){
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      typeAlert: typeAlert
    ));
    return _dialogCompleter.future;
  }
  

  void dialogComplete( AlertResponse response){
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }


}