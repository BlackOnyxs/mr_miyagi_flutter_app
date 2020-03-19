import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/alert_request.dart';
import 'package:mr_miyagi_app/core/models/alert_response.dart';
import 'package:mr_miyagi_app/core/services/dialog_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget{
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);
  
  _DialogManagerState createState() => _DialogManagerState(); 
}

class _DialogManagerState extends State<DialogManager>{
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() { 
    super.initState();
    _dialogService.registerDialogListener(_showInterectiveDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showInterectiveDialog( AlertRequest request ){
    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      closeFunction: () =>
          _dialogService.dialogComplete(AlertResponse(confirmed: false)),
      buttons: [
        DialogButton(
          child: Text(request.buttonTitle),
          onPressed: (){
            _dialogService.dialogComplete(AlertResponse(confirmed: true));
            Navigator.of(context).pop();
          },
        )
      ]).show();
  }
  //add somplete dialog
  void _showProgressAlert( AlertRequest request){
    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      closeFunction: () => 
          _dialogService.dialogComplete(AlertResponse(confirmed: false)),
      content: CircularProgressIndicator()
    ).show();
  }
  
}