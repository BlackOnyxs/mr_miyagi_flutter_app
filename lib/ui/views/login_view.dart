import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/viewmodels/login_view_model.dart';
import 'package:mr_miyagi_app/ui/widgets/busy_button.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<LogInViewModel>(
        builder: (context, model, child) =>Scaffold(
          body: Stack(
        children: <Widget>[
        _createBacground( context ),
        _loginForm( context, model ),
        ],
          ),
      ),
      
    );
    
  }

 Widget _createBacground( BuildContext context ){
   final size = MediaQuery.of(context).size;

   final purpleBackground = Container(
    height: size.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0)
        ]
      )
      
    ),
   );

  final circle = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Color.fromRGBO(255, 255, 255, 0.05)
    ),
  );

   return Stack(
     children: <Widget>[
      purpleBackground,
      Positioned( top: 90.0,     left: 30.0,    child: circle),
      Positioned( top: -40.0,    right: -30.0,  child: circle),
      Positioned( bottom: -50.0, right: -10.0,  child: circle),
      Positioned( bottom: 120.0, right: 20.0,   child: circle),
      Positioned( bottom: -50.0, left: -20.0,   child: circle),

      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon ( Icons.person_pin_circle, color: Colors.white, size: 100.0),
            SizedBox( height: 10.0, width: double.infinity ),
            Text('Dark Tech', style: TextStyle( color: Colors.white, fontSize:25.0))
          ],
        ),
      )
     ],
   );
 }

  Widget _loginForm( BuildContext context, LogInViewModel model ){
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(

      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
            
          ),

          Container(
            margin: EdgeInsets.symmetric( vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset( 0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Login ', style: TextStyle(fontSize: 20)),
                SizedBox( height: 50.0 ),
                _createEmail( model ),
                SizedBox( height: 25.0 ),
                _createPass( model ),
                SizedBox( height: 25.0 ),
                _createButton( model ),
              ],
            ),
          ),

          FlatButton(
            child: Text('You do not have an account? Sign Up!'),
            onPressed: () {
              model.navigateToSignUp();
            },
          ),
          SizedBox( height: 100.0 )
        ],
      ),
    );
  }

  Widget _createEmail( LogInViewModel model ){
    return StreamBuilder(
      stream: model.emailStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
              labelText: 'Email Address',
              errorText: snapshot.error
            ),
            onChanged: model.changeEmail,
          ),
        );
      },
    );
  }  

  
Widget _createPass( LogInViewModel model ){
  return StreamBuilder(
    stream: model.passwordStream,
    builder: ( BuildContext context, AsyncSnapshot snapshot ){
      return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0 ),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon( Icons.lock_outline, color: Colors.deepPurple ),
            hintText: 'password',
            errorText: snapshot.error
          ),
          onChanged: model.changepassword,
        ),
      );
    },
   
  );
}

Widget _createButton( LogInViewModel model ){
  return StreamBuilder(
    stream: model.validateForm,
    builder: ( BuildContext context, AsyncSnapshot snapshot ){
      return BusyButton(
        title: 'Login',
        busy: model.busy,
        onPressed: (snapshot.hasData) ? (){
          model.logIn(
            email     :  model.email,
            password  :  model.password,
          );
        } : null
      );
    },
    
  );
}
     
}
 
