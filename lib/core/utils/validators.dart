import 'dart:async';

class Validators {


  final validateEmptyField = StreamTransformer<String, String>.fromHandlers(
    handleData: ( fullName, sink ){

      if( fullName.trim().length>1){
        sink.add( fullName );
      }else{
        sink.addError( 'This field is required' );
      }
    }
  );

final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if ( regExp.hasMatch(email.trim())) {
        sink.add( email );
      } else {
        sink.addError( 'The email is not valid' );
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ){

      if( password.length >= 6 ){
        sink.add( password );
      }else{
        sink.addError('Password must contain more than 6 characters');
      }
    }
  );
  final validateCant = StreamTransformer<String, String>.fromHandlers(
    handleData: ( cant, sink ){
      
      final n = num.tryParse(cant);
      if( n == null ){
        sink.addError('Invalid character');
      }else{
        if( n<=0 ){
          sink.addError('The quantity must be greater than 0');
        }else{
          sink.add(cant);
        }
        
      }
      
    }
  );
  
}