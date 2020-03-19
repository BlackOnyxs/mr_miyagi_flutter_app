import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/viewmodels/startup_view_model.dart';
import 'base_view.dart';


class StartUpView extends StatelessWidget{
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model)=>model.handleStartUpLogic(),
      builder: ( context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                //Change that with MediaQuery
                width: 600.0,
                height: 300.0,
                child: Image(
                  image: AssetImage('assets/no-image.png'),
                )
              ),
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Color.fromRGBO(6, 6, 6, 1)),
              )
            ],
          ),
        ),
      ),
    );
  }
}